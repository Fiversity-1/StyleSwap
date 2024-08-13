import 'package:flutter/material.dart';
import 'package:clothing_swap/features/clothing/presentation/clothing_item.dart';

class ClothingCard extends StatefulWidget {
  final ClothingItem item;

  const ClothingCard({super.key, required this.item});

  @override
  _ClothingCardState createState() => _ClothingCardState();
}

//60% Generative Code
class _ClothingCardState extends State<ClothingCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          widget.item.currentIndex =
              (widget.item.currentIndex + 1) % widget.item.images.length;
        });
      },
      onTap: () {
        setState(() {
          widget.item.currentIndex =
              (widget.item.currentIndex + 1) % widget.item.images.length;
        });
      },
      child: Card(
        child: Image.asset(
          widget.item.images[widget.item.currentIndex],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
