// profile.dart
import 'package:clothing_swap/features/clothing/presentation/clothing_detail.dart';
import 'package:clothing_swap/features/profile/presentation/profilegalleryviewtop.dart';
import 'package:flutter/material.dart';

class ProfileGalleryView extends StatelessWidget {
  ProfileGalleryView({super.key});
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const PageScrollPhysics(),
        scrollDirection: Axis.vertical,
        controller: _controller,
        children: const [ProfileGalleryViewTop(), ClothingDetail()],
      ),
    );
  }
}
