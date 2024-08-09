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
      //boo
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomTopAppBar(),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
      body: Stack(
        children: [
          SizedBox(
            width: width,
            height: height,
            child: Image.asset('lib/images/1.jpg', fit: BoxFit.fill),
          ),
          Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: (2.5), left: (5.0)),
                    child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        iconSize: 25,
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pushNamed(context, '/profile');
                        }),
                  ),
                  SizedBox(
                    height: height * 0.765,
                    width: width,
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/clothing_detail');
                },
                child: const Text('Details'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
