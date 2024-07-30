import 'package:clothing_swap/widgets/image_selection.dart';
import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';

class AddClothingItemPage extends StatelessWidget {
  const AddClothingItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1,),
      appBar: AppBar(
        title: const Text('Add Item'),
        backgroundColor: const Color.fromRGBO(255, 87, 87, 1),
      ),
      body: const Center(
        child: ImageSelection()
      ),
    );
  }
}
