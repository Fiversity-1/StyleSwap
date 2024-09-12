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
import 'package:toastification/toastification.dart';

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
      return clothingTopIcons;
    case 2:
      return clothingBottomIcons;
    case 3:
      return clothingAccessoriesIcons;
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
  int typeIndex = 0;
  bool imagePresent = false;
  List<String> selectedColours = [];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
      "Add Images",
      "Add Description"
    ];

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

    int numSteps = 9;

    bool isMaxStep() {
      return activeStep == numSteps;
    }

    void previous() {
      setState(() {
        if (activeStep == 4) {
          activeStep = typeIndex;
        } else if (activeStep == 1 || activeStep == 2 || activeStep == 3) {
          activeStep = 0;
        } else {
          activeStep--;
        }
      });
    }

    bool isFirstStep() {
      return activeStep == 0;
    }

    void next(int index) {
      setState(() {
        if (activeStep == 0) {
          if (index == 0) {
            typeIndex = 1;
            activeStep = 1;
          } else if (index == 1) {
            typeIndex = 2;
            activeStep = 2;
          } else if (index == 2) {
            typeIndex = 3;
            activeStep = 3;
          }
        } else if (activeStep == 1 || activeStep == 2 || activeStep == 3) {
          activeStep = 4;
        } else {
          activeStep++;
        }
      });
    }

//GPT suggest custom validation when not using form key
    void colourValidation() {
      if (selectedColours.isEmpty)
      //End
      {
        toastification.showCustom(
          context: context,
          autoCloseDuration: const Duration(seconds: 3),
          alignment: Alignment.topCenter,
          builder: (BuildContext context, ToastificationItem holder) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).hoverColor,
              ),
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(8),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Please select at least 1 colour",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      } else {
        next(0);
      }
    }

    void imageValidation() {
      if (!imagePresent)
      //End
      {
        toastification.showCustom(
          context: context,
          autoCloseDuration: const Duration(seconds: 3),
          alignment: Alignment.topCenter,
          builder: (BuildContext context, ToastificationItem holder) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).hoverColor,
              ),
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(8),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Please select at least 1 image",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      } else {
        next(0);
      }
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

    void handleColour(int index) {
      if (selectedColours.contains(getText(category, index))) {
        selectedColours.remove(getText(category, index));
      } else {
        selectedColours.add(getText(category, index));
      }
      setState(() {});
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
                      Visibility(
                        visible: activeStep != 8,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10, right: 10),
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
                                  activeStep != 6
                                      ? (isMaxStep() ? null : next(index))
                                      : handleColour(index);
                                },
                                onTap: () {
                                  activeStep != 6
                                      ? (isMaxStep() ? null : next(index))
                                      : handleColour(index);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: selectedColours.contains(
                                      getText(category, index),
                                    )
                                        ? Theme.of(context).hoverColor
                                        : Colors.transparent,
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
                                          activeStep != 6
                                              ? (isMaxStep()
                                                  ? null
                                                  : next(index))
                                              : handleColour(index);
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
                      ),
                      Visibility(
                          visible: activeStep == 8,
                          child: SizedBox(
                            height: height * 0.775,
                            width: width,
                            child: ImageSelectionField(
                              initialValue: clothingInfo.images,
                              onSaved: (List<XFile>? images) {
                                setState(() {
                                  imagePresent = !imagePresent;
                                  clothingInfo =
                                      clothingInfo.copyWith(images: images);
                                });
                              },
                            ),
                          )),
                      Row(
                        mainAxisAlignment: activeStep == 6 || activeStep == 8
                            ? MainAxisAlignment.spaceBetween
                            : MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: !isFirstStep(),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: 20,
                                  left: activeStep == 6 || activeStep == 8
                                      ? 20
                                      : 0),
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
                          ),
                          Visibility(
                            visible: activeStep == 6 || activeStep == 8,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 20, right: 20),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).hoverColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    //index doesn't matter here
                                    isMaxStep()
                                        ? null
                                        : activeStep == 6
                                            ? colourValidation()
                                            : activeStep == 8
                                                ? imageValidation()
                                                : null;
                                  });
                                },
                                child: const Text('Next'),
                              ),
                            ),
                          )
                        ],
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
