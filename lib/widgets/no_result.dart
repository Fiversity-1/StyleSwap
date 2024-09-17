import 'package:clothing_swap/theme/theme.dart';
import 'package:clothing_swap/theme/theme_switcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoResultCard extends StatefulWidget {
  const NoResultCard({super.key});

  @override
  NoResultCardState createState() => NoResultCardState();
}

class NoResultCardState extends State<NoResultCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Image(
        image: (!kIsWeb &&
                Provider.of<ThemeSwitcher>(context).themeData == lightTheme)
            ? const AssetImage('lib/images/nothingPhoneLight.png')
            : (!kIsWeb &&
                    Provider.of<ThemeSwitcher>(context).themeData == darkTheme)
                ? const AssetImage('lib/images/nothingPhoneDark.png')
                : (kIsWeb &&
                        Provider.of<ThemeSwitcher>(context).themeData ==
                            lightTheme)
                    ? const AssetImage('lib/images/nothingWebLight.png')
                    : const AssetImage('lib/images/nothingWebDark.png'),
        fit: BoxFit.cover,
      ),
    );
  }
}
