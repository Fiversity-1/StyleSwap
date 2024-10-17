import 'package:clothing_swap/features/preferences/presentation/preference_row.dart';
import 'package:clothing_swap/theme/gradient.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../preferences/domain/clothing_search.dart';
import '../application/search_provider.dart';

//View list of preferences
class ViewPrefences extends StatefulWidget {
  const ViewPrefences({super.key});

  @override
  State<ViewPrefences> createState() => _ViewPrefencesState();
}

class _ViewPrefencesState extends State<ViewPrefences> {
  void deleteEnum<T>(index, List<T>? list, void Function(List<T>?) update) {
    List<T>? shallowCopy = list != null ? List.from(list) : [];

    shallowCopy.removeAt(index);

    update(shallowCopy.isEmpty ? null : shallowCopy);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
        // LayoutBuilder used for responsive design
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Row(
                children: [
                  Visibility(
                    visible: kIsWeb,
                    child: Expanded(
                      flex: 1,
                      child: Container(
                        color: Theme.of(context).canvasColor,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child:
                        // PreferenceRow widget for list of tags
                        Consumer<ClothingSearch>(
                      builder: (context, clothingSearch, child) {
                        return Column(
                          children: [
                            SizedBox(
                              height: height * 0.025,
                              width: width,
                            ),
                            Text(
                              'Search Preferences',
                              style: kIsWeb
                                  ? Theme.of(context).textTheme.headlineLarge
                                  : Theme.of(context).textTheme.headlineMedium,
                            ),
                            // PreferenceRow widget for list of tags
                            Column(
                              children: [
                                PreferenceRow(
                                    category: "Type",
                                    preferences: clothingSearch.types ?? [],
                                    onDelete: (index) {
                                      deleteEnum(index, clothingSearch.types,
                                          clothingSearch.updateTypes);
                                    }),
                                PreferenceRow(
                                    category: "Size",
                                    preferences: clothingSearch.sizes ?? [],
                                    onDelete: (index) {
                                      deleteEnum(index, clothingSearch.sizes,
                                          clothingSearch.updateSizes);
                                    }),
                                PreferenceRow(
                                    category: "Colour",
                                    preferences: clothingSearch.colours ?? [],
                                    onDelete: (index) {
                                      deleteEnum(index, clothingSearch.colours,
                                          clothingSearch.updateColours);
                                    }),
                                PreferenceRow(
                                    category: "Condition",
                                    preferences:
                                        clothingSearch.conditions ?? [],
                                    onDelete: (index) {
                                      deleteEnum(
                                          index,
                                          clothingSearch.conditions,
                                          clothingSearch.updateConditions);
                                    }),
                                PreferenceRow(
                                    category: "Gender",
                                    preferences: clothingSearch.genders ?? [],
                                    onDelete: (index) {
                                      deleteEnum(index, clothingSearch.genders,
                                          clothingSearch.updateGenders);
                                    }),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 25.0, right: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 15, left: 5.0, bottom: 15),
                                      child: Row(
                                        children: [
                                          Text(
                                            clothingSearch.distance == null
                                                ? "Distance 100 km +"
                                                : "Distance ${clothingSearch.distance!.round().toString()} km",
                                            style: kIsWeb
                                                ? Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall
                                                : Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall,
                                          ),
                                        ],
                                      )),
                                  // Based on FlutterMap Slider Tutorial
                                  // https://www.youtube.com/watch?v=AW2YVbvbbmQ
                                  Slider(
                                    value: (clothingSearch.distance ?? 100)
                                        .toDouble(),
                                    max: 100,
                                    min: 5,
                                    divisions: 19,
                                    label: (clothingSearch.distance ?? 100)
                                        .round()
                                        .toString(),
                                    onChanged: (double value) {
                                      var newDistance = value.toInt();
                                      clothingSearch.updateDistance(
                                          newDistance >= 100
                                              ? null
                                              : newDistance);
                                    },
                                  )
                                ],
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 15.0, bottom: 20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    var search = Provider.of<Search>(context,
                                        listen: false);

                                    search.setSearchParams(clothingSearch);

                                    Navigator.pushNamed(
                                      context,
                                      '/swipe',
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .floatingActionButtonTheme
                                        .backgroundColor,
                                  ),
                                  child: Text(
                                    "Save Changes",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: kIsWeb,
                    child: Expanded(
                      flex: 1,
                      child: Container(
                        color: Theme.of(context).canvasColor,
                      ),
                    ),
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
