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

Map<Enum, FaIcon> _pickCatgory(String option) {
  switch (option) {
    case "Type":
      return clothingTypeIcons;
    case "Size":
      return letteredSizeIcons;
    case "Condition":
      return clothingConditionIcons;
    case "Colour":
      return clothingColourIcons;
  }
  return clothingColourIcons;
}

List<Enum> preferences = [];

class _ClothesPreferencesState extends State<ClothesPreferences> {
  late String categories;
  late List<bool> _pressedStates;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Extract the 'categories' argument from the route
    categories = ModalRoute.of(context)!.settings.arguments as String;
    Map<Enum, FaIcon> category = _pickCatgory(categories);
    _pressedStates = List.generate(category.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    Map<Enum, FaIcon> category = _pickCatgory(categories);

    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 3,
      ),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomTopAppBar(),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                "Select $categories",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
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
                        //preferences.add(category.entries[index]);
                        _pressedStates[index] = !_pressedStates[index];
                      });
                    },
                    onTap: () {
                      setState(() {
                        _pressedStates[index] = !_pressedStates[index];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _pressedStates[index]
                            ? Theme.of(context).hoverColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Text(
                              category.keys
                                  .toList()[index]
                                  .toString()
                                  .split('.')
                                  .last
                                  .capitalize,
                              style: Theme.of(context).textTheme.bodyLarge),
                          IconButton(
                            icon: category.values.toList()[index],
                            onPressed: () {
                              setState(() {
                                _pressedStates[index] = !_pressedStates[index];
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                itemCount: category.values.toList().length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).hoverColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const Map<LetteredSize, FaIcon> letteredSizeIcons = {
  LetteredSize.xxs: FaIcon(FontAwesomeIcons.s, size: 75),
  LetteredSize.xs: FaIcon(FontAwesomeIcons.x, size: 75),
  LetteredSize.s: FaIcon(FontAwesomeIcons.caretDown, size: 75),
  LetteredSize.m: FaIcon(FontAwesomeIcons.caretDown, size: 75),
  LetteredSize.l: FaIcon(FontAwesomeIcons.caretDown, size: 75),
  LetteredSize.xl: FaIcon(FontAwesomeIcons.caretDown, size: 75),
  LetteredSize.xxl: FaIcon(FontAwesomeIcons.caretDown, size: 75),
};

Map<ClothingColour, FaIcon> clothingColourIcons = {
  ClothingColour.red:
      const FaIcon(FontAwesomeIcons.square, size: 75, color: Colors.red),
  ClothingColour.green:
      const FaIcon(FontAwesomeIcons.circle, size: 75, color: Colors.green),
  ClothingColour.lightBlue:
      const FaIcon(FontAwesomeIcons.circle, size: 75, color: Colors.lightBlue),
  ClothingColour.darkBlue:
      const FaIcon(FontAwesomeIcons.circle, size: 75, color: Colors.blue),
  ClothingColour.purple:
      const FaIcon(FontAwesomeIcons.circle, size: 75, color: Colors.purple),
  ClothingColour.pink:
      const FaIcon(FontAwesomeIcons.circle, size: 75, color: Colors.pink),
  ClothingColour.orange:
      const FaIcon(FontAwesomeIcons.circle, size: 75, color: Colors.orange),
  ClothingColour.yellow:
      const FaIcon(FontAwesomeIcons.circle, size: 75, color: Colors.yellow),
  ClothingColour.white:
      const FaIcon(FontAwesomeIcons.circle, size: 75, color: Colors.white),
  ClothingColour.black:
      const FaIcon(FontAwesomeIcons.circle, size: 75, color: Colors.black),
  ClothingColour.lightGrey:
      FaIcon(FontAwesomeIcons.circle, size: 75, color: Colors.grey[300]),
  ClothingColour.darkGrey:
      FaIcon(FontAwesomeIcons.circle, size: 75, color: Colors.grey[800]),
  ClothingColour.brown:
      const FaIcon(FontAwesomeIcons.circle, size: 75, color: Colors.brown),
};

const Map<ClothingType, FaIcon> clothingTypeIcons = {
  ClothingType.hat: FaIcon(FontAwesomeIcons.hatCowboy, size: 75),
  ClothingType.vest: FaIcon(FontAwesomeIcons.vest, size: 75),
  ClothingType.shirt: FaIcon(FontAwesomeIcons.shirt, size: 75),
  ClothingType.midriff: FaIcon(FontAwesomeIcons.shirt, size: 75),
};

const Map<ClothingCondition, FaIcon> clothingConditionIcons = {
  ClothingCondition.newWithTags: FaIcon(FontAwesomeIcons.tag, size: 75),
  ClothingCondition.newNoTags: FaIcon(FontAwesomeIcons.tag, size: 75),
  ClothingCondition.likeNew: FaIcon(FontAwesomeIcons.star, size: 75),
  ClothingCondition.worn: FaIcon(FontAwesomeIcons.heartbeat, size: 75),
  ClothingCondition.wellWorn: FaIcon(FontAwesomeIcons.batteryHalf, size: 75),
};
