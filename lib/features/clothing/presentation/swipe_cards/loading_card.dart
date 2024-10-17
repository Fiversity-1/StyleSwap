import 'package:clothing_swap/theme/theme.dart';
import 'package:clothing_swap/theme/theme_switcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingCard extends StatefulWidget {
  const LoadingCard({super.key});

  @override
  LoadingCardState createState() => LoadingCardState();
}

class LoadingCardState extends State<LoadingCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Container(
            color: Colors.grey, // Solid grey background
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor, // Primary color of the app
                  ),
                ),
                const SizedBox(height: 16), // Space between the indicator and text
                const Text(
                  "Fetching clothes, please wait",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white, // Adjust text color as needed
                    fontSize: 18, // Larger font size
                    fontWeight: FontWeight.bold, // Bold text
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
