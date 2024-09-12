// startpage.dart
import 'package:clothing_swap/features/clothing/presentation/clothing_detail.dart';
import 'package:clothing_swap/features/clothing/application/search_provider.dart';
import 'package:clothing_swap/features/clothing/presentation/swipetop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwipePage extends StatelessWidget {
  const SwipePage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchResults = Provider.of<Search>(context);
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: [
          const SwipePageTop(),
          // Only include this page if the condition is met- chat modified
          if (searchResults.checkCardType() == "Clothes")
            const ClothingDetail(),
        ],
      ),
    );
  }
}
