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
        image: (!kIsWeb &&
                Provider.of<ThemeSwitcher>(context).themeData == lightTheme)
            ? funFactLightPhone[widget.index]
            : (!kIsWeb &&
                    Provider.of<ThemeSwitcher>(context).themeData == darkTheme)
                ? funFactDarkPhone[widget.index]
                : (kIsWeb &&
                        Provider.of<ThemeSwitcher>(context).themeData ==
                            lightTheme)
                    ? funFactLightWeb[widget.index]
                    : funFactDarkWeb[widget.index],
        fit: kIsWeb ? BoxFit.fill : BoxFit.cover,
      ),
    );
  }
}

//List of different images for different colour scheme and devices
List<AssetImage> funFactDarkPhone = [
  const AssetImage('lib/images/funFact1PhoneDark.png'),
  const AssetImage('lib/images/funFact2PhoneDark.png'),
  const AssetImage('lib/images/funFact3PhoneDark.png'),
];

List<AssetImage> funFactLightPhone = [
  const AssetImage('lib/images/funFact1PhoneLight.png'),
  const AssetImage('lib/images/funFact2PhoneLight.png'),
  const AssetImage('lib/images/funFact3PhoneLight.png'),
];
List<AssetImage> funFactDarkWeb = [
  const AssetImage('lib/images/funFact1WebDark.png'),
  const AssetImage('lib/images/funFact2WebDark.png'),
  const AssetImage('lib/images/funFact3WebDark.png'),
];
List<AssetImage> funFactLightWeb = [
  const AssetImage('lib/images/funFact1WebLight.png'),
  const AssetImage('lib/images/funFact2WebLight.png'),
  const AssetImage('lib/images/funFact3WebLight.png'),
];
