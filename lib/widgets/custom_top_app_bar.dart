import 'package:clothing_swap/theme/theme.dart';
import 'package:clothing_swap/theme/theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTopAppBar extends StatelessWidget {
  const CustomTopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        Provider.of<ThemeSwitcher>(context).themeData == lightTheme
            ? 'lib/images/hanger.png'
            : 'lib/images/hanger_white.png',
        height: 65,
        width: 75,
      ),
      leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/preferences');
          },
          icon: const Icon(Icons.settings)),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/events');
            },
            icon: const Icon(Icons.event))
      ],
    );
  }
}
