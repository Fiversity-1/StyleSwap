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
    if (currentIndex >= widget.item.images.length) {
      currentIndex = 0;
    }

    return GestureDetector(
      onLongPress: () {
        setState(() {
          //GPT was used for the following reasons:
          //Prompt: "I am swiping through cards similar to tinder in flutter.
          //These cards can be tapped to view additional images for that card
          //as well. How do I handle the logic to switch back to the beginning
          //to avoid an index error"
          currentIndex = (currentIndex + 1) % widget.item.images.length;
        });
      },
      onTap: () {
        setState(() {
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
