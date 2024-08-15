import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelectionField extends FormField<XFile?> {

  void Function(XFile?)? onChanged;

  ImageSelectionField({
    super.key,
    super.onSaved,
    this.onChanged,
    super.validator,
    super.initialValue,
    AutovalidateMode super.autovalidateMode = AutovalidateMode.disabled
  }) : super(
      builder: (FormFieldState<XFile?> state) {
        final ImagePicker picker = ImagePicker();

        // uses the ImagePicker to select an image from the gallery
        Future<void> selectImage() async {
          final XFile? image = await picker.pickImage(source: ImageSource.gallery);
          if (image != null) {
            state.didChange(image);
            onChanged!(image);
          }
        }

        // uses the ImagePicker to take an image from the host camera
        Future<void> takeImage() async {
          final XFile? image = await picker.pickImage(source: ImageSource.camera);
          if (image != null) {
            state.didChange(image);
            onChanged!(image);
          }
        }

        // removes the current image
        void clearImage() {
          state.didChange(null);
          onChanged!(null);
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (state.value != null)
              Expanded(child:
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.file(
                      File(state.value!.path),
                      fit: BoxFit.fill,
                    )
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.close), onPressed: clearImage,
                      )
                  )
                ],
              ))
            else
              Column(
                  children: <Widget>[
                    Text(
                      state.errorText ?? "",
                      style: const TextStyle(
                        color: Colors.red, // Set the text color to red
                        fontSize: 18, // Optional: Set the font size
                        fontWeight: FontWeight.bold, // Optional: Set the font weight
                      ),
                    ),
                    ElevatedButton(
                    onPressed: selectImage,
                    child: const Text('Select Image'),
                  ),ElevatedButton(
                    onPressed: takeImage,
                    child: const Text('Take Image'),
                  ),]
              )
          ],
        );

      }
  );
}