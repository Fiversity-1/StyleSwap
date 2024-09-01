import 'package:clothing_swap/features/clothing/presentation/advanced_search.dart';
import 'package:clothing_swap/features/clothing/presentation/preferences_provider.dart';
import 'package:clothing_swap/widgets/preference_row.dart';
import 'package:clothing_swap/widgets/tag.dart';
import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    //Chat GPT for tracking preference changes
    List<String> typePreferences =
        context.watch<PreferencesNotifier>().getPreferences("Type");
    List<String> sizePreferences =
        context.watch<PreferencesNotifier>().getPreferences("Size");
    List<String> colourPreferences =
        context.watch<PreferencesNotifier>().getPreferences("Colour");
    List<String> conditionPreferences =
        context.watch<PreferencesNotifier>().getPreferences("Condition");
    List<String> genderPreferences =
        context.watch<PreferencesNotifier>().getPreferences("Gender");
    List<List<String>> allPreferences = [
      typePreferences,
      sizePreferences,
      colourPreferences,
      conditionPreferences,
      genderPreferences
    ];

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    List<Widget> type = [];
    for (int index = 0; index < preferences.length; index++) {
      type.add(Tag(text: preferences[index]));
    }
    type.add(Chip(
      label: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/clothes_preferences',
              arguments: 'Type');
        },
      ),
      backgroundColor: Theme.of(context).hoverColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Rounded edges
          side: BorderSide(color: Theme.of(context).hoverColor, width: 3)),
    ));

    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 0,
      ),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomTopAppBar(),
      ),
      body: Row(
        children: [
          Visibility(
            visible: kIsWeb,
            child: Expanded(
                flex: 1,
                child: Container(
                  color: Theme.of(context).canvasColor,
                )),
          ),
          Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.05,
                      child: Image.asset('lib/images/backdrop.jpg',
                          fit: kIsWeb ? BoxFit.fitWidth : BoxFit.fill),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: height * 0.025,
                        width: width,
                      ),
                      Text('Preferences',
                          style: kIsWeb
                              ? Theme.of(context).textTheme.headlineLarge
                              : Theme.of(context).textTheme.headlineMedium),
                      PreferenceRow(category: "Type", tags: type)
                    ],
                  ),
                ],
              )),
          Visibility(
            visible: kIsWeb,
            child: Expanded(
                flex: 1,
                child: Container(
                  color: Theme.of(context).canvasColor,
                )),
          ),
        ],
      ),
    );
  }
}
