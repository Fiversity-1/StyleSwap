import 'package:flutter/material.dart';

class CardSwipe extends StatefulWidget {
  const CardSwipe({super.key, required this.title});

  final String title;
  @override
  State<CardSwipe> createState() => _CardSwipeState();
}

class _CardSwipeState extends State<CardSwipe> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (dragEndDetails) {
        if (dragEndDetails.primaryVelocity! < 0) {
          //left swipe
          _incrementCounter();
        } else if (dragEndDetails.primaryVelocity! > 0) {
          //right swipe
        }
        ;
      },
      child: Image.asset('lib/images/$_counter.jpg', fit: BoxFit.fill),
    );
  }
}
