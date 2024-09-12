import 'package:clothing_swap/features/clothing/domain/clothing_info.dart';
import 'package:clothing_swap/features/clothing/domain/clothing_type.dart';
import 'package:clothing_swap/features/clothing/presentation/select_preferences.dart';
import 'package:clothing_swap/widgets/image_selection.dart';
import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:string_extensions/string_extensions.dart';

import '../../../widgets/selection_tree_grid.dart';

//GPT to change to statefulwidget instead of hook, use setState for dynamic changes, make sure to use () not just reference other setState won't work lol
class AddClothingItemPage extends StatefulWidget {
  const AddClothingItemPage({super.key});

  @override
  State<AddClothingItemPage> createState() => _AddClothingItemPageState();
}

Map<Enum, FaIcon> _pickCategory(int order) {
  switch (order) {
    case 0:
      return clothingCategoryIcons;
    case 1:
      return clothingTypeIcons;
    case 2:
      return clothingTypeIcons;
    case 3:
      return clothingTypeIcons;
    case 4:
      return letteredSizeIcons;
    case 5:
      return clothingConditionIcons;
    case 6:
      return clothingColourIcons;
    case 7:
      return clothingGenderIcons;
  }
  return clothingColourIcons;
}

class _AddClothingItemPageState extends State<AddClothingItemPage> {
  //final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ClothingInfo clothingInfo = ClothingInfo();
  int activeStep = 0;
  @override
  Widget build(BuildContext context) {
    Map<Enum, FaIcon> category = _pickCategory(activeStep);
    List<String> instructions = [
      "Select Clothing Category",
      "Select Type",
      "Select Type",
      "Select Type",
      "Select Size",
      "Select Condition",
      "Select Colours",
      "Select Gender",
    ];

    // List<Widget> steps = <Widget>[
    //   TreeSelection(ClothingType.getTree()),
    //   ImageSelectionField(
    //     initialValue: clothingInfo.images,
    //     onSaved: (List<XFile>? images) {
    //       setState(() {
    //         clothingInfo = clothingInfo.copyWith(images: images);
    //       });
    //     },
    //     validator: (List<XFile>? images) =>
    //         (images ?? []).isEmpty ? "Image required" : null,
    //   ),
    //   SingleChildScrollView(
    //       padding: const EdgeInsets.all(16),
    //       child: Column(
    //         children: [
    //           TextFormField(
    //             initialValue: clothingInfo.brand,
    //             decoration: const InputDecoration(
    //               border: OutlineInputBorder(),
    //               labelText: 'Brand',
    //             ),
    //             validator: (String? text) =>
    //                 (text?.length ?? 0) < 1 ? "Brand must be provided" : null,
    //             onChanged: (String? text) {
    //               setState(() {
    //                 clothingInfo = clothingInfo.copyWith(brand: text);
    //               });
    //             },
    //           ),
    //           const SizedBox(height: 10),
    //           SizedBox(
    //               height: 300,
    //               child: TextFormField(
    //                   initialValue: clothingInfo.description,
    //                   expands: true,
    //                   textAlignVertical: TextAlignVertical.top,
    //                   decoration: const InputDecoration(
    //                     border: OutlineInputBorder(),
    //                     labelText: 'Description',
    //                   ),
    //                   onChanged: (String? text) {
    //                     setState(() {
    //                       clothingInfo =
    //                           clothingInfo.copyWith(description: text);
    //                     });
    //                   },
    //                   keyboardType: TextInputType.multiline,
    //                   maxLines: null)),
    //         ],
    //       )),
    // ];

    int numSteps = 7;
    //Widget currentWidget = steps[activeStep];

    bool isMaxStep() {
      return activeStep == numSteps;
    }

    void previous() {
      setState(() {
        activeStep--;
      });
    }

    bool isFirstStep() {
      return activeStep == 0;
    }

    void next(int index) {
      setState(() {
        if (activeStep == 0) {
          if (index == 0) {
            activeStep == 1;
          } else if (index == 1) {
            activeStep == 2;
          } else if (index == 2) {
            activeStep == 3;
          }
        } else {
          activeStep++;
        }
      });
    }

    String getText(Map<Enum, FaIcon> category, int index) {
      return category == letteredSizeIcons
          ? category.keys
              .toList()[index]
              .toString()
              .split('.')
              .last
              .toUpperCase()
          : category.keys.toList()[index].toString().split('.').last.capitalize;
    }

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
                    image: AssetImage('lib/images/backdrop3.jpg'),
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
                          instructions[activeStep],
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
                                isMaxStep() ? null : next(index);
                              },
                              onTap: () {
                                isMaxStep() ? null : next(index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        getText(category, index) ==
                                                "Newwithtags"
                                            ? "New with tags"
                                            : getText(category, index) ==
                                                    "Newnotags"
                                                ? "New no tags"
                                                : getText(category, index) ==
                                                        "Likenew"
                                                    ? "Like new"
                                                    : getText(category,
                                                                index) ==
                                                            "Wellworn"
                                                        ? "Well worn"
                                                        : getText(
                                                            category, index),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                    IconButton(
                                      icon: category.values.toList()[index],
                                      onPressed: () {
                                        isMaxStep() ? null : next(index);
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
                      Visibility(
                        visible: !isFirstStep(),
                        child: Padding(
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
                                isFirstStep() ? null : previous();
                              });
                            },
                            child: const Text('Back'),
                          ),
                        ),
                      )
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




// Visibility(
//                                 visible: !isFirstStep(),
//                                 child: ElevatedButton(
//                                   onPressed: isFirstStep() ? null : previous,
//                                   child: const Text("Previous"),
//                                 ),
//                               ),
//                               // ElevatedButton(
//                               //   onPressed: isMaxStep() ? save : next,
//                               //   style: ElevatedButton.styleFrom(
//                               //     backgroundColor:
//                               //         Theme.of(context).colorScheme.primary,
//                               //     foregroundColor:
//                               //         Theme.of(context).colorScheme.onPrimary,
//                               //   ),
//                               //   child: Text(isMaxStep() ? "Save" : "Next"),
//                               // ),