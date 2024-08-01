import 'package:flutter/material.dart';

class CustomTopAppBar extends StatelessWidget {
  const CustomTopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Image.asset(
        'lib/images/hanger.png',
        height: 80,
        width: 80,
      ),
      centerTitle: true,
      leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.catching_pokemon))
      ],
    );
  }
}
