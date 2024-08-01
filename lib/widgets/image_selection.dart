import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSelectionField extends FormField<XFile?> {
  ImageSelectionField({
    super.onSaved,
    super.validator,
    super.initialValue,
    AutovalidateMode super.autovalidateMode = AutovalidateMode.disabled
  }) : super(
      builder: (FormFieldState<XFile?> state) {
        final ImagePicker _picker = ImagePicker();

        Future<void> _selectImage() async {
          final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
          if (image != null) {
            state.didChange(image);
          }
        }

        Future<void> _takeImage() async {
          final XFile? image = await _picker.pickImage(source: ImageSource.camera);
          if (image != null) {
            state.didChange(image);
          }
        }

        void _clearImage() {
          state.didChange(null);
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
                        icon: const Icon(Icons.close), onPressed: _clearImage,
                      )
                  )
                ],
              ))
            else
              Column(
                  children: <Widget>[
                    Text(state.errorText ?? ""),
                    ElevatedButton(
                    onPressed: _selectImage,
                    child: const Text('Select Image'),
                  ),ElevatedButton(
                    onPressed: _takeImage,
                    child: const Text('Take Image'),
                  ),]
              )
          ],
        );

      }
  );
}