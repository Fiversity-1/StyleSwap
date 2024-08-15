import 'dart:io';

import 'package:flutter/material.dart';
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
            builder: (FormFieldState<List<XFile>> state) {
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

              void onReorder(int oldIndex, int newIndex) {
                List<XFile> updatedList = List<XFile>.from(state.value ?? []);
                var image = updatedList.removeAt(oldIndex);
                updatedList.insert(newIndex, image);
                state.didChange(updatedList);
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ReorderableGridView.count(
                      crossAxisCount: 2,
                      // 2 images across
                      childAspectRatio: 3 / 4,
                      onReorder: onReorder,
                      footer: [
                        Container(
                            key: const Key("add_button"),
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: AddImageButton(
                                callback: () => addImage(state.context),
                                errorText: state.errorText))
                      ],
                      dragWidgetBuilderV2: DragWidgetBuilderV2(
                          isScreenshotDragWidget: false,
                          builder: (index, child, screenshot) {
                            return Material(
                              color: Colors.transparent, // Ensure transparency
                              child: child,
                            );
                          }),
                      dragStartDelay: const Duration(milliseconds: 250),
                      // 3:4 ratio
                      children: (state.value ?? [])
                          .asMap()
                          .entries
                          .map((e) => Container(
                                key: Key(e.value.path),
                                margin: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16.0),
                                  child: ImageWithCloseIcon(
                                    imageFile: e.value,
                                    onClose: () => onClearImage(e.key),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ))
                ],
              );
            });
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
