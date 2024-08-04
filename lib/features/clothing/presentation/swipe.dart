// startpage.dart
import 'package:clothing_swap/features/clothing/presentation/clothing_detail.dart';
import 'package:clothing_swap/features/clothing/presentation/swipetop.dart';
import 'package:flutter/material.dart';

class SwipePage extends StatelessWidget {
  SwipePage({super.key});
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: const [SwipePageTop(), ClothingDetail()],
      ),
    );
  }
}
