import 'package:clothing_swap/features/clothing/application/search_provider.dart';
import 'package:clothing_swap/features/clothing/presentation/clothing_detail.dart';
import 'package:clothing_swap/features/clothing/presentation/swipetop.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Used to make scrollable between "swipe_Top" and "clothing_details"
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
          //GPT was used for the following reasons:
          //Prompt: Using this page view in flutter (provided code), how to make a certain page
          //not scrollable based on a certain condition"
          if (searchResults.checkCardType() == "Clothes")
            const ClothingDetail(),
        ],
      ),
    );
  }
}
