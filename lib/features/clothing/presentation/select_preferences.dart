import 'package:clothing_swap/features/clothing/domain/clothing_info.dart';
import 'package:clothing_swap/features/clothing/presentation/preferences_provider.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
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
    case "Gender":
      return clothingGenderIcons;
  }
  return clothingColourIcons;
}

class _ClothesPreferencesState extends State<ClothesPreferences> {
  late String categories;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Extract the 'categories' argument from the route, Chat GPT suggested code
    categories = ModalRoute.of(context)!.settings.arguments as String;
  }

  void _handlePress(int index, Map<Enum, FaIcon> category, String currentOption,
      PreferencesNotifier preferencesNotifier, List<String> preferences) {
    setState(() {
      if (preferences.contains(currentOption)) {
        preferencesNotifier.removePreference(categories, currentOption);
      } else {
        preferencesNotifier.addPreference(
            categories,
            category == letteredSizeIcons
                ? category.keys
                    .toList()[index]
                    .toString()
                    .split('.')
                    .last
                    .toUpperCase()
                : category.keys
                    .toList()[index]
                    .toString()
                    .split('.')
                    .last
                    .capitalize);
      }
    });
  }

  String _getText(Map<Enum, FaIcon> category, int index) {
    return category == letteredSizeIcons
        ? category.keys.toList()[index].toString().split('.').last.toUpperCase()
        : category.keys.toList()[index].toString().split('.').last.capitalize;
  }

  @override
  Widget build(BuildContext context) {
    Map<Enum, FaIcon> category = _pickCatgory(categories);
    //Chat GPT for tracking changes via provider
    final preferencesNotifier = context.watch<PreferencesNotifier>();
    List<String> preferences =
        context.watch<PreferencesNotifier>().getPreferences(categories);
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 3,
      ),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomTopAppBar(),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Define grid column count based on available width
          int crossAxisCount = constraints.maxWidth > 800
              ? 7
              : constraints.maxWidth > 400
                  ? 3
                  : 2;
          return Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/images/backdrop5.jpg'),
                    opacity: 0.1,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SingleChildScrollView(
                child: Center(
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
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                          ),
                          itemBuilder: (_, index) => GridTile(
                            child: GestureDetector(
                              onLongPress: () {
                                _handlePress(
                                    index,
                                    category,
                                    //Chat GPT to transform into correct format
                                    _getText(category, index),
                                    preferencesNotifier,
                                    preferences);
                              },
                              onTap: () {
                                _handlePress(
                                    index,
                                    category,
                                    _getText(category, index),
                                    preferencesNotifier,
                                    preferences);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: preferences.contains(
                                    _getText(category, index),
                                  )
                                      ? Theme.of(context).hoverColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        _getText(category, index) ==
                                                "Newwithtags"
                                            ? "New with tags"
                                            : _getText(category, index) ==
                                                    "Newnotags"
                                                ? "New no tags"
                                                : _getText(category, index) ==
                                                        "Likenew"
                                                    ? "Like new"
                                                    : _getText(category,
                                                                index) ==
                                                            "Wellworn"
                                                        ? "Well worn"
                                                        : _getText(
                                                            category, index),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                    IconButton(
                                      icon: category.values.toList()[index],
                                      onPressed: () {
                                        _handlePress(
                                            index,
                                            category,
                                            _getText(category, index),
                                            preferencesNotifier,
                                            preferences);
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
              ),
            ],
          );
        },
      ),
    );
  }
}

//Generative AI for icon generation
const double iconSize = kIsWeb ? 65 : 35;

const Map<LetteredSize, FaIcon> letteredSizeIcons = {
  LetteredSize.xxs: FaIcon(FontAwesomeIcons.ruler, size: iconSize),
  LetteredSize.xs: FaIcon(FontAwesomeIcons.ruler, size: iconSize),
  LetteredSize.s: FaIcon(FontAwesomeIcons.ruler, size: iconSize),
  LetteredSize.m: FaIcon(FontAwesomeIcons.ruler, size: iconSize),
  LetteredSize.l: FaIcon(FontAwesomeIcons.ruler, size: iconSize),
  LetteredSize.xl: FaIcon(FontAwesomeIcons.ruler, size: iconSize),
  LetteredSize.xxl: FaIcon(FontAwesomeIcons.ruler, size: iconSize),
};

Map<ClothingColour, FaIcon> clothingColourIcons = {
  ClothingColour.red: const FaIcon(FontAwesomeIcons.solidCircle,
      size: iconSize, color: Colors.red),
  ClothingColour.green: const FaIcon(FontAwesomeIcons.solidCircle,
      size: iconSize, color: Colors.green),
  ClothingColour.lightBlue: const FaIcon(FontAwesomeIcons.solidCircle,
      size: iconSize, color: Colors.lightBlue),
  ClothingColour.darkBlue: const FaIcon(FontAwesomeIcons.solidCircle,
      size: iconSize, color: Colors.blueAccent),
  ClothingColour.purple: const FaIcon(FontAwesomeIcons.solidCircle,
      size: iconSize, color: Colors.purple),
  ClothingColour.pink: const FaIcon(FontAwesomeIcons.solidCircle,
      size: iconSize, color: Colors.pink),
  ClothingColour.orange: const FaIcon(FontAwesomeIcons.solidCircle,
      size: iconSize, color: Colors.orange),
  ClothingColour.yellow: const FaIcon(FontAwesomeIcons.solidCircle,
      size: iconSize, color: Colors.yellow),
  ClothingColour.white: const FaIcon(FontAwesomeIcons.solidCircle,
      size: iconSize, color: Colors.white),
  ClothingColour.black: const FaIcon(FontAwesomeIcons.solidCircle,
      size: iconSize, color: Colors.black),
  ClothingColour.lightGrey: FaIcon(FontAwesomeIcons.solidCircle,
      size: iconSize, color: Colors.grey[300]),
  ClothingColour.darkGrey: FaIcon(FontAwesomeIcons.solidCircle,
      size: iconSize, color: Colors.grey[800]),
  ClothingColour.brown: const FaIcon(FontAwesomeIcons.solidCircle,
      size: iconSize, color: Colors.brown),
};

const Map<ClothingType, FaIcon> clothingTypeIcons = {
  ClothingType.hat: FaIcon(FontAwesomeIcons.hatCowboy, size: iconSize),
  ClothingType.tie: FaIcon(FontAwesomeIcons.blackTie, size: iconSize),
  ClothingType.jumper: FaIcon(FontAwesomeIcons.wind, size: iconSize),
  ClothingType.shirt: FaIcon(FontAwesomeIcons.shirt, size: iconSize),
  ClothingType.skirt: FaIcon(FontAwesomeIcons.personDress, size: iconSize),
  ClothingType.shoes: FaIcon(FontAwesomeIcons.shoePrints, size: iconSize),
  ClothingType.gloves: FaIcon(FontAwesomeIcons.mitten, size: iconSize),
  ClothingType.jacket: FaIcon(FontAwesomeIcons.wind, size: iconSize),
  ClothingType.vest: FaIcon(FontAwesomeIcons.vest, size: iconSize),
  ClothingType.dress: FaIcon(FontAwesomeIcons.personDress, size: iconSize),
  ClothingType.midriff: FaIcon(FontAwesomeIcons.shirt, size: iconSize),
  ClothingType.pants: FaIcon(FontAwesomeIcons.personRunning, size: iconSize),
  ClothingType.sweater: FaIcon(FontAwesomeIcons.wind, size: iconSize),
  ClothingType.scarf: FaIcon(FontAwesomeIcons.ribbon, size: iconSize),
  ClothingType.leggings: FaIcon(FontAwesomeIcons.personDress, size: iconSize),
  ClothingType.belt: FaIcon(FontAwesomeIcons.tape, size: iconSize),
  ClothingType.shorts: FaIcon(FontAwesomeIcons.personRunning, size: iconSize),
  ClothingType.coat: FaIcon(FontAwesomeIcons.wind, size: iconSize),
};

const Map<ClothingCondition, FaIcon> clothingConditionIcons = {
  ClothingCondition.newWithTags: FaIcon(FontAwesomeIcons.tag, size: iconSize),
  ClothingCondition.newNoTags:
      FaIcon(FontAwesomeIcons.solidStar, size: iconSize),
  ClothingCondition.likeNew:
      FaIcon(FontAwesomeIcons.solidHeart, size: iconSize),
  ClothingCondition.worn: FaIcon(FontAwesomeIcons.wrench, size: iconSize),
  ClothingCondition.wellWorn: FaIcon(FontAwesomeIcons.gears, size: iconSize),
};

const Map<ClothingGender, FaIcon> clothingGenderIcons = {
  ClothingGender.male: FaIcon(FontAwesomeIcons.mars, size: iconSize),
  ClothingGender.female: FaIcon(FontAwesomeIcons.venus, size: iconSize),
  ClothingGender.unisex: FaIcon(FontAwesomeIcons.venusMars, size: iconSize),
};
