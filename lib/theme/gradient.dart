import 'package:flutter/material.dart';

//Gradient Background for scaffolds used in app
//GPT was used for the following reasons:
//Prompt: "Generate a page with a colour gradient that can be used as
//a background to a scaffold"
class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          //Colour change will affect all pages in the app
          colors: [Colors.deepPurpleAccent, Colors.blue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: child,
    );
  }
}
