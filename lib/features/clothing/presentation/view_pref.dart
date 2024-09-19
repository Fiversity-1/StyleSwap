import 'package:clothing_swap/features/profile/presentation/profile_class.dart';
import 'package:clothing_swap/theme/gradient.dart';
import 'package:clothing_swap/widgets/preference_row.dart';
import 'package:clothing_swap/widgets/tag.dart';
import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';

class ViewPrefences extends StatefulWidget {
  const ViewPrefences({super.key});

  @override
  State<ViewPrefences> createState() => _ViewPrefencesState();
}

class _ViewPrefencesState extends State<ViewPrefences> {
  @override
  Widget build(BuildContext context) {
    //Chat GPT for tracking preference changes
    final userManager = context.watch<UserManager>();
    final preferencesNotifier = userManager.currentUser.preferences;
    List<String> typePreferences = preferencesNotifier.getPreferences("Type");
    List<String> sizePreferences = preferencesNotifier.getPreferences("Size");
    List<String> colourPreferences =
        preferencesNotifier.getPreferences("Colour");
    List<String> conditionPreferences =
        preferencesNotifier.getPreferences("Condition");
    List<String> genderPreferences =
        preferencesNotifier.getPreferences("Gender");
    List<List<String>> allPreferences = [
      typePreferences,
      sizePreferences,
      colourPreferences,
      conditionPreferences,
      genderPreferences
    ];

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    List<List<Widget>> tags = [[], [], [], [], []];
    for (int i = 0; i < 5; i++) {
      for (int index = 0; index < allPreferences[i].length; index++) {
        tags[i].add(Tag(
          text: allPreferences[i][index],
          category: i == 0
              ? 'Type'
              : i == 1
                  ? 'Size'
                  : i == 2
                      ? 'Colour'
                      : i == 3
                          ? 'Condition'
                          : 'Gender',
        ));
      }
      tags[i].add(Chip(
        labelPadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        label: SizedBox(
          width: 15,
          height: 15,
          child: IconButton(
            icon: const Icon(
              Icons.add,
              size: 15,
            ),
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            onPressed: () {
              Navigator.pushNamed(context, '/add_clothes_preferences',
                  arguments: i == 0
                      ? 'Type'
                      : i == 1
                          ? 'Size'
                          : i == 2
                              ? 'Colour'
                              : i == 3
                                  ? 'Condition'
                                  : 'Gender');
            },
          ),
        ),
        backgroundColor: Theme.of(context).hoverColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100), // Rounded edges
            side: BorderSide(color: Theme.of(context).hoverColor, width: 3)),
      ));
    }

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: const CustomBottomNavBar(
          currentIndex: 0,
        ),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomTopAppBar(),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            // Define grid column count based on available width

            return SingleChildScrollView(
              child: Row(
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
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.025,
                          width: width,
                        ),
                        Text('Search Preferences',
                            style: kIsWeb
                                ? Theme.of(context).textTheme.headlineLarge
                                : Theme.of(context).textTheme.headlineMedium),
                        PreferenceRow(category: "Type", tags: tags[0]),
                        PreferenceRow(category: "Size", tags: tags[1]),
                        PreferenceRow(category: "Colour", tags: tags[2]),
                        PreferenceRow(category: "Condition", tags: tags[3]),
                        PreferenceRow(category: "Gender", tags: tags[4]),
                        Padding(
                            padding: const EdgeInsets.only(left: (25.0)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 15, left: (5.0), bottom: 15),
                                  child: Row(
                                    children: [
                                      Text(
                                          preferencesNotifier.getDistance() == 0
                                              ? "Distance within 5 km"
                                              : preferencesNotifier
                                                          .getDistance() ==
                                                      100
                                                  ? "Distance 100 km +"
                                                  : "Distance ${preferencesNotifier.getDistance().round().toString()} km",
                                          style: kIsWeb
                                              ? Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall
                                              : Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall),
                                      //FlutterMap Slider Tutorial
                                    ],
                                  ),
                                ),
                                Slider(
                                    value: preferencesNotifier.getDistance(),
                                    max: 100,
                                    min: 0,
                                    divisions: 20,
                                    label: preferencesNotifier
                                        .getDistance()
                                        .round()
                                        .toString(),
                                    onChanged: (double value) {
                                      setState(() {
                                        preferencesNotifier.setDistance(value);
                                      });
                                    })
                              ],
                            ))
                      ],
                    ),
                  ),
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
          },
        ),
      ),
    );
  }
}
