import 'package:clothing_swap/features/clothing/presentation/fun_fact_class.dart';
import 'package:flutter/material.dart';

class FunFactCard extends StatefulWidget {
  final FunFact funFact;

  const FunFactCard({super.key, required this.funFact});

  @override
  FunFactCardState createState() => FunFactCardState();
}

class FunFactCardState extends State<FunFactCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Image(
        image: widget.funFact.image,
        fit: BoxFit.fill,
      ),
    );
  }
}
