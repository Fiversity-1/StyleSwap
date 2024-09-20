import 'package:flutter/material.dart';
import 'package:clothing_swap/features/clothing/presentation/clothing_item_class.dart';

//Individual Clothing Card for swipe_top page
class ClothingCard extends StatefulWidget {
  final ClothingItem item;

  const ClothingCard({
    super.key,
    required this.item,
  });

  @override
  ClothingCardState createState() => ClothingCardState();
}

class ClothingCardState extends State<ClothingCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          //GPT code for cycling through listings with multiple images and resetting index
          widget.item.currentIndex =
              (widget.item.currentIndex + 1) % widget.item.images.length;
        });
      },
      onTap: () {
        setState(() {
          //GPT code for cycling through listings with multiple images and resetting index
          widget.item.currentIndex =
              (widget.item.currentIndex + 1) % widget.item.images.length;
        });
      },
      child: Card(
        child: Image(
          image: widget.item.images[widget.item.currentIndex],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
