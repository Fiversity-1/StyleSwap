// signup.dart
import 'package:clothing_swap/features/clothing/domain/clothing_info.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:string_extensions/string_extensions.dart';

class ClothesPreferences extends StatefulWidget {
  const ClothesPreferences({super.key});

  @override
  State<ClothesPreferences> createState() => _ClothesPreferencesState();
}

void _incrementCounter(context) {
  _counter++;
  if (_counter == 4) {
    Navigator.pushNamed(context, '/swipe');
  }
}

int _counter = 0;
List<Map> categories = [clothingTypeIcons, clothingConditionIcons];

List<String> categoriesName = ["Size", "Colour", "Type", "Condition"];

class _ClothesPreferencesState extends State<ClothesPreferences> {
  late String chosenValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const CustomBottomNavBar(
          currentIndex: 3,
        ),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomTopAppBar(),
        ),
        body: Center(
          child: Column(children: [
            Text(
              categoriesName[_counter],
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: kIsWeb ? 6 : 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (_, index) => GridTile(
                  child: GestureDetector(
                    onLongPress: () {
                      setState(() {
                        _incrementCounter(context);
                      });
                    },
                    onTap: () {
                      setState(() {
                        _incrementCounter(context);
                      });
                    },
                    //GPT recommended this package and icon mapping seen below
                    child: Column(
                      children: [
                        Text(
                          categories[_counter]
                              .keys
                              .toList()[index]
                              .toString()
                              .split('.')
                              .last
                              .capitalize,
                        ),
                        IconButton(
                          icon: categories[_counter].values.toList()[index],
                          onPressed: () {
                            _incrementCounter(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                itemCount: categories[_counter].values.toList().length,
              ),
            ),
          ]),
        ));
  }
}

const Map<LetteredSize, FaIcon> letteredSizeIcons = {
  LetteredSize.xxs: FaIcon(FontAwesomeIcons.s, size: 100),
  LetteredSize.xs: FaIcon(FontAwesomeIcons.x, size: 100),
  LetteredSize.s: FaIcon(FontAwesomeIcons.caretDown, size: 100),
  LetteredSize.m: FaIcon(FontAwesomeIcons.caretDown, size: 100),
  LetteredSize.l: FaIcon(FontAwesomeIcons.caretDown, size: 100),
  LetteredSize.xl: FaIcon(FontAwesomeIcons.caretDown, size: 100),
  LetteredSize.xxl: FaIcon(FontAwesomeIcons.caretDown, size: 100),
};

Map<ClothingColour, FaIcon> clothingColourIcons = {
  ClothingColour.red:
      const FaIcon(FontAwesomeIcons.circle, size: 100, color: Colors.red),
  ClothingColour.green:
      const FaIcon(FontAwesomeIcons.circle, size: 100, color: Colors.green),
  ClothingColour.lightBlue:
      const FaIcon(FontAwesomeIcons.circle, size: 100, color: Colors.lightBlue),
  ClothingColour.darkBlue:
      const FaIcon(FontAwesomeIcons.circle, size: 100, color: Colors.blue),
  ClothingColour.purple:
      const FaIcon(FontAwesomeIcons.circle, size: 100, color: Colors.purple),
  ClothingColour.pink:
      const FaIcon(FontAwesomeIcons.circle, size: 100, color: Colors.pink),
  ClothingColour.orange:
      const FaIcon(FontAwesomeIcons.circle, size: 100, color: Colors.orange),
  ClothingColour.yellow:
      const FaIcon(FontAwesomeIcons.circle, size: 100, color: Colors.yellow),
  ClothingColour.white:
      const FaIcon(FontAwesomeIcons.circle, size: 100, color: Colors.white),
  ClothingColour.black:
      const FaIcon(FontAwesomeIcons.circle, size: 100, color: Colors.black),
  ClothingColour.lightGrey:
      FaIcon(FontAwesomeIcons.circle, size: 100, color: Colors.grey[300]),
  ClothingColour.darkGrey:
      FaIcon(FontAwesomeIcons.circle, size: 100, color: Colors.grey[800]),
  ClothingColour.brown:
      const FaIcon(FontAwesomeIcons.circle, size: 100, color: Colors.brown),
};

const Map<ClothingType, FaIcon> clothingTypeIcons = {
  ClothingType.hat: FaIcon(FontAwesomeIcons.hatCowboy, size: 100),
  ClothingType.scarf: FaIcon(FontAwesomeIcons, size: 100),
  ClothingType.tie: FaIcon(FontAwesomeIcons.necktie, size: 100),
  ClothingType.shirt: FaIcon(FontAwesomeIcons.shirt, size: 100),
  ClothingType.midriff: FaIcon(FontAwesomeIcons.shirt, size: 100),
  ClothingType.belt: FaIcon(FontAwesomeIcons.belt, size: 100),
  ClothingType.shorts: FaIcon(FontAwesomeIcons.shorts, size: 100),
  ClothingType.pants: FaIcon(FontAwesomeIcons.pants, size: 100),
  ClothingType.skirt: FaIcon(FontAwesomeIcons.skirt, size: 100),
  ClothingType.dress: FaIcon(FontAwesomeIcons.dress, size: 100),
  ClothingType.shoes: FaIcon(FontAwesomeIcons.shoePrints, size: 100),
  ClothingType.jumper: FaIcon(FontAwesomeIcons.sweater, size: 100),
  ClothingType.jacket: FaIcon(FontAwesomeIcons.jacket, size: 100),
  ClothingType.sweater: FaIcon(FontAwesomeIcons.sweater, size: 100),
  ClothingType.coat: FaIcon(FontAwesomeIcons.coat, size: 100),
  ClothingType.gloves: FaIcon(FontAwesomeIcons.gloves, size: 100),
  ClothingType.vest: FaIcon(FontAwesomeIcons.vest, size: 100),
  ClothingType.leggings: FaIcon(FontAwesomeIcons.leggings, size: 100),
  ClothingType.tights: FaIcon(FontAwesomeIcons.tights, size: 100),
};

const Map<ClothingCondition, FaIcon> clothingConditionIcons = {
  ClothingCondition.newWithTags: FaIcon(FontAwesomeIcons.tag, size: 100),
  ClothingCondition.newNoTags: FaIcon(FontAwesomeIcons.tag, size: 100),
  ClothingCondition.likeNew: FaIcon(FontAwesomeIcons.star, size: 100),
  ClothingCondition.worn: FaIcon(FontAwesomeIcons.heartbeat, size: 100),
  ClothingCondition.wellWorn: FaIcon(FontAwesomeIcons.batteryHalf, size: 100),
};
