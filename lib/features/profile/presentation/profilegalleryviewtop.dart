// profile.dart

import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/material.dart';

class ProfileGalleryViewTop extends StatelessWidget {
  const ProfileGalleryViewTop({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomTopAppBar(),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
      body: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: Image.asset('lib/images/1.jpg', fit: BoxFit.fill),
        ),
      ),
    );
  }
}
