import 'package:clothing_swap/theme/theme.dart';
import 'package:clothing_swap/theme/theme_switcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//No result card that is displayed when there are no listings left in search
class NoResultCard extends StatefulWidget {
  const NoResultCard({super.key});

  @override
  NoResultCardState createState() => NoResultCardState();
}

class NoResultCardState extends State<NoResultCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //Different Colour Schemes and Device Type require different image
      child: Image(
        image: (!kIsWeb &&
                Provider.of<ThemeSwitcher>(context).themeData == lightTheme)
            ? const AssetImage('lib/images/search_exhausted/nothingPhoneLight.png')
            : (!kIsWeb &&
                    Provider.of<ThemeSwitcher>(context).themeData == darkTheme)
                ? const AssetImage('lib/images/search_exhausted/nothingPhoneDark.png')
                : (kIsWeb &&
                        Provider.of<ThemeSwitcher>(context).themeData ==
                            lightTheme)
                    ? const AssetImage('lib/images/search_exhausted/nothingWebLight.png')
                    : const AssetImage('lib/images/search_exhausted/nothingWebDark.png'),
        fit: BoxFit.cover,
      ),
    );
  }
}
