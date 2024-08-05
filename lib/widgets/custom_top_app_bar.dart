import 'package:flutter/material.dart';

class CustomTopAppBar extends StatelessWidget {
  const CustomTopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        'lib/images/hanger.png',
        height: 65,
        width: 75,
      ),
      leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/swipe');
          },
          icon: const Icon(Icons.recycling)),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/commenting');
            },
            icon: const Icon(Icons.event))
      ],
    );
  }
}
