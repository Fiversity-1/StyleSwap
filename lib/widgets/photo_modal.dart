import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//ChatGPT suggested use of async, wait with Future returns, context.mounted when using navigator.pop
Future<XFile?> photoOptionModal(BuildContext context, ImagePicker picker,
    int quality, double? maxwidth, double? maxheight) async {
  XFile? image;
  await showModalBottomSheet(
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
                image = await picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: quality,
                    maxHeight: maxheight,
                    maxWidth: maxwidth);
                if (context.mounted) {
                  Navigator.pop(context, image);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Select from Camera Roll'),
              onTap: () async {
                // Handle select from gallery
                image = await picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: quality,
                    maxHeight: maxheight,
                    maxWidth: maxwidth);
                if (context.mounted) {
                  Navigator.pop(context, image);
                }
              },
            ),
          ],
        );
      });
  return image;
}
