// signup.dart
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
      body: SingleChildScrollView(
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
                        _handlePress(
                            index,
                            category,
                            //Chat GPT to transform into correct format
                            _getText(category, index),
                            preferencesNotifier,
                            preferences);
                      },
                      onTap: () {
                        _handlePress(index, category, _getText(category, index),
                            preferencesNotifier, preferences);
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
                          children: [
                            Text(
                                _getText(category, index) == "Newwithtags"
                                    ? "New with tags"
                                    : _getText(category, index) == "Newnotags"
                                        ? "New no tags"
                                        : _getText(category, index) == "Likenew"
                                            ? "Like new"
                                            : _getText(category, index) ==
                                                    "Wellworn"
                                                ? "Well worn"
                                                : _getText(category, index),
                                style: Theme.of(context).textTheme.bodyLarge),
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
    );
  }
}

//Generative AI for icon generation
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
      const FaIcon(FontAwesomeIcons.palette, size: 75, color: Colors.red),
  ClothingColour.green:
      const FaIcon(FontAwesomeIcons.palette, size: 75, color: Colors.green),
  ClothingColour.lightBlue:
      const FaIcon(FontAwesomeIcons.palette, size: 75, color: Colors.lightBlue),
  ClothingColour.darkBlue:
      const FaIcon(FontAwesomeIcons.palette, size: 75, color: Colors.blue),
  ClothingColour.purple:
      const FaIcon(FontAwesomeIcons.palette, size: 75, color: Colors.purple),
  ClothingColour.pink:
      const FaIcon(FontAwesomeIcons.palette, size: 75, color: Colors.pink),
  ClothingColour.orange:
      const FaIcon(FontAwesomeIcons.palette, size: 75, color: Colors.orange),
  ClothingColour.yellow:
      const FaIcon(FontAwesomeIcons.palette, size: 75, color: Colors.yellow),
  ClothingColour.white:
      const FaIcon(FontAwesomeIcons.palette, size: 75, color: Colors.white),
  ClothingColour.black:
      const FaIcon(FontAwesomeIcons.palette, size: 75, color: Colors.black),
  ClothingColour.lightGrey:
      FaIcon(FontAwesomeIcons.palette, size: 75, color: Colors.grey[300]),
  ClothingColour.darkGrey:
      FaIcon(FontAwesomeIcons.palette, size: 75, color: Colors.grey[800]),
  ClothingColour.brown:
      const FaIcon(FontAwesomeIcons.palette, size: 75, color: Colors.brown),
};

const Map<ClothingType, FaIcon> clothingTypeIcons = {
  // ClothingType.hat: FaIcon(FontAwesomeIcons.hatCowboy, size: 75),
  // ClothingType.scarf: FaIcon(FontAwesomeIcons.scarf, size: 75),
  // ClothingType.tie: FaIcon(FontAwesomeIcons.necktie, size: 75),
  // ClothingType.shirt: FaIcon(FontAwesomeIcons.shirt, size: 75),
  // ClothingType.midriff: FaIcon(FontAwesomeIcons.shirt, size: 75), // No specific midriff icon, using shirt
  // ClothingType.belt: FaIcon(FontAwesomeIcons.belt, size: 75),
  // ClothingType.shorts: FaIcon(FontAwesomeIcons.shorts, size: 75),
  // ClothingType.pants: FaIcon(FontAwesomeIcons.pants, size: 75), // No specific pants icon, using trousers
  // ClothingType.skirt: FaIcon(FontAwesomeIcons.skirt, size: 75),
  // ClothingType.dress: FaIcon(FontAwesomeIcons.dress, size: 75),
  // ClothingType.shoes: FaIcon(FontAwesomeIcons.shoePrints, size: 75),
  // ClothingType.jumper: FaIcon(FontAwesomeIcons.sweater, size: 75),
  // ClothingType.jacket: FaIcon(FontAwesomeIcons.jacket, size: 75),
  // ClothingType.sweater: FaIcon(FontAwesomeIcons.sweater, size: 75),
  // ClothingType.coat: FaIcon(FontAwesomeIcons.coat, size: 75),
  // ClothingType.gloves: FaIcon(FontAwesomeIcons.gloves, size: 75),
  ClothingType.vest: FaIcon(FontAwesomeIcons.vest, size: 75),
  // ClothingType.leggings: FaIcon(FontAwesomeIcons.leggings, size: 75),
  // ClothingType.tights: FaIcon(FontAwesomeIcons.leggings, size: 75), // No specific tights icon, using leggings
};

const Map<ClothingCondition, FaIcon> clothingConditionIcons = {
  ClothingCondition.newWithTags:
      FaIcon(FontAwesomeIcons.solidStar, size: 75), // Tags for new with tags
  ClothingCondition.newNoTags: FaIcon(FontAwesomeIcons.solidStar,
      size: 75), // Single tag for new without tags
  ClothingCondition.likeNew:
      FaIcon(FontAwesomeIcons.solidStar, size: 75), // Check circle for like new
  ClothingCondition.worn:
      FaIcon(FontAwesomeIcons.solidStar, size: 75), // Trash for worn
  ClothingCondition.wellWorn:
      FaIcon(FontAwesomeIcons.solidStar, size: 75), // Cogs for well worn
};

const Map<ClothingGender, FaIcon> clothingGenderIcons = {
  ClothingGender.male: FaIcon(FontAwesomeIcons.mars, size: 75),
  ClothingGender.female: FaIcon(FontAwesomeIcons.venus, size: 75),
  ClothingGender.unisex: FaIcon(FontAwesomeIcons.venusMars, size: 75),
};
