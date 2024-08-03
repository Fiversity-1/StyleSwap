import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';

class ClothingDetail extends StatelessWidget {
  const ClothingDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomTopAppBar(),
      ),
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 1,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Details',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
