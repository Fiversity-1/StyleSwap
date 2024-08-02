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
      centerTitle: true,
      leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.event))],
    );
  }
}
