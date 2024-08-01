import 'package:flutter/material.dart';

class CustomTopAppBar extends StatelessWidget {
  const CustomTopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(255, 87, 87, 1),
      title: Image.asset(
        'lib/images/hanger.png',
        height: 70,
        width: 70,
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.menu),
        color: Colors.white,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.catching_pokemon),
          color: Colors.white,
        )
      ],
    );
  }
}
