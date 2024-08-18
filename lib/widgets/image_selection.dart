import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_reorderable_grid_view/widgets/reorderable_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class ImageSelectionField extends FormField<List<XFile>> {
  ImageSelectionField(
      {super.key,
      super.onSaved,
      super.validator,
      initialValue,
      AutovalidateMode super.autovalidateMode =
          AutovalidateMode.onUserInteraction})
      : super(
            initialValue: initialValue ?? [],
            builder: (FormFieldState<List<XFile>> field) {
              var state = field as _ImageSelectionFieldState;
              final ImagePicker picker = ImagePicker();

              // uses the ImagePicker to select an image from the gallery
              Future<void> selectImage() async {
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);

                if (image == null) {
                  return;
                }

                List<XFile> updatedList = List<XFile>.from(state.value ?? []);
                updatedList.add(image);
                state.didChange(updatedList);

                state.didChange(updatedList);
              }

              // uses the ImagePicker to take an image from the host camera
              Future<void> takeImage() async {
                final XFile? image =
                    await picker.pickImage(source: ImageSource.camera);

                if (image == null) {
                  return;
                }

                List<XFile> updatedList = List<XFile>.from(state.value ?? []);
                updatedList.add(image);
                state.didChange(updatedList);

                state.didChange(updatedList);
              }

              void addImage(BuildContext context) {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(Icons.camera_alt),
                            title: const Text('Take Photo'),
                            onTap: () async {
                              // Handle select from camera roll action
                              takeImage();
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.photo_library),
                            title: const Text('Select from Camera Roll'),
                            onTap: () async {
                              // Handle select from camera roll action
                              selectImage();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
              }

              // removes the current image
              void onClearImage(int index) {
                List<XFile> updatedList = List<XFile>.from(state.value ?? []);
                updatedList.removeAt(index);
                state.didChange(updatedList);
              }

              void onReorder(ReorderedListFunction reorderedListFunction) {
                state.didChange(
                    reorderedListFunction(state.value!) as List<XFile>);
              }

              final generatedChildren =
                  List.generate((state.value ?? []).length + 1, (index) {
                if (index < state.value!.length) {
                  return Container(
                    key: Key(state.value![index].path),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: ImageWithCloseIcon(
                        imageFile: state.value![index],
                        onClose: () => onClearImage(index),
                      ),
                    ),
                  );
                } else {
                  return Container(
                      key: const Key("add_button"),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: AddImageButton(
                          callback: () => addImage(state.context),
                          errorText: state.errorText));
                }
              });

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: ReorderableBuilder(
                            children: generatedChildren,
                            lockedIndices: [state.value!.length],
                            nonDraggableIndices: [state.value!.length],
                            scrollController: state.scrollController,
                            builder: (children) {
                              return GridView(
                                key: state.gridViewKey,
                                controller: state.scrollController,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                  childAspectRatio: 3 / 4,
                                ),
                                children: children,
                              );
                            },
                            onReorder: onReorder,
                            dragChildBoxDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  spreadRadius: 4,
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                          )))
                ],
              );
            });

  @override
  FormFieldState<List<XFile>> createState() => _ImageSelectionFieldState();
}

class _ImageSelectionFieldState extends FormFieldState<List<XFile>>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  final scrollController = ScrollController();
  final gridViewKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    animation = Tween<double>(begin: 1.0, end: 0.8).animate(controller);
  }
}

class ImageWithCloseIcon extends StatelessWidget {
  final XFile imageFile;
  final VoidCallback onClose;

  const ImageWithCloseIcon(
      {super.key, required this.imageFile, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.file(
            File(imageFile.path),
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 8.0,
          right: 8.0,
          child: GestureDetector(
            onTap: onClose,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.close,
                  color: Theme.of(context).colorScheme.onSecondary),
            ),
          ),
        ),
      ],
    );
  }
}

class AddImageButton extends StatefulWidget {
  final VoidCallback callback;
  final String? errorText;

  const AddImageButton({super.key, required this.callback, this.errorText});

  @override
  _AddImageButtonState createState() => _AddImageButtonState();
}

class _AddImageButtonState extends State<AddImageButton> {
  bool _showError = false;

  @override
  void didUpdateWidget(covariant AddImageButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.errorText != null) {
      setState(() {
        _showError = true;
      });
      Future.delayed(const Duration(milliseconds: 200), () {
        setState(() {
          _showError = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: _showError
            ? Theme.of(context).colorScheme.errorContainer
            : Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 0.5,
            blurRadius: 0.5,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          // Use transparent to show AnimatedContainer's color
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          // Use surface color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          padding: EdgeInsets.zero,
          // Remove default padding // Remove default padding
          shadowColor: Colors.transparent, // Remove shadow if any
        ),
        onPressed: widget.callback,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.add,
              size: 48.0, // Adjust size if needed
            ),
            if (widget.errorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  widget.errorText!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
