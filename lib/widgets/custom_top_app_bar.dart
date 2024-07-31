import 'package:flutter/material.dart';

class CustomTopAppBar extends StatelessWidget {
  const CustomTopAppBar({super.key});

  void _onIconTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/drawer');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/swipe');
        break;
    }
  }

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
        //change this to drawer if we need one
        onPressed: () {
          _onIconTapped(context, 1);
        },
        icon: const Icon(Icons.menu),
        color: Colors.white,
      ),
      actions: [
        IconButton(
          onPressed: () {
            _onIconTapped(context, 1);
          },
          icon: const Icon(Icons.catching_pokemon),
          color: Colors.white,
        )
      ],
    );
  }
}
