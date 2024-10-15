import 'package:clothing_swap/theme/theme.dart';
import 'package:clothing_swap/theme/theme_switcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//FunFact Card Widget for displaying in search results periodically
class FunFactCard extends StatefulWidget {
  final int index;

  const FunFactCard({super.key, required this.index});

  @override
  FunFactCardState createState() => FunFactCardState();
}

class FunFactCardState extends State<FunFactCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Image(
        //Logic for selecting images for different colour scheme and devices
        image: funFactDarkPhone[widget.index],
        fit: kIsWeb ? BoxFit.fill : BoxFit.cover,
      ),
    );
  }
}

int numFunFacts = 10;
//List of different images for different colour scheme and devices
List<AssetImage> funFactDarkPhone = List.generate(numFunFacts, (index) {
  return AssetImage('lib/images/fun_facts/fun_fact_$index.png');
});
