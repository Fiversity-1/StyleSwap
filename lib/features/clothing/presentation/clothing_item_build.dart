import 'package:flutter/material.dart';

import '../domain/clothing_info.dart';

//Individual Clothing Card for swipe_top page
class ClothingCard extends StatefulWidget {
  final ClothingInfo item;

  const ClothingCard({
    super.key,
    required this.item,
  });

  @override
  ClothingCardState createState() => ClothingCardState();
}

class ClothingCardState extends State<ClothingCard> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          //GPT code for cycling through listings with multiple images and resetting index
          currentIndex = (currentIndex + 1) % widget.item.images.length;
        });
      },
      onTap: () {
        setState(() {
          //GPT code for cycling through listings with multiple images and resetting index
          currentIndex = (currentIndex + 1) % widget.item.images.length;
        });
      },
      child: Card(
        child: Image(
          image: widget.item.images.isNotEmpty
              ? MemoryImage(widget.item.images[currentIndex])
              : const AssetImage('lib/images/noImage.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
