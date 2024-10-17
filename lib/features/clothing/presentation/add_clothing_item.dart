import 'dart:typed_data';

import 'package:clothing_swap/features/clothing/data/clothing_api.dart';
import 'package:clothing_swap/features/clothing/domain/clothing_info.dart';
import 'package:clothing_swap/features/preferences/presentation/select_preferences.dart';
import 'package:clothing_swap/theme/gradient.dart';
import 'package:clothing_swap/widgets/image_selection.dart';
import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:toastification/toastification.dart';

import '../../profile/domain/profile_class.dart';

//GPT to change to statefulwidget instead of hook
//GPT to then implement setState for dynamic changes (as no longer hook),
//GPT then used to make sure to use "setState()" instead of "setState"
class AddClothingItemPage extends StatefulWidget {
  const AddClothingItemPage({super.key});

  @override
  State<AddClothingItemPage> createState() => _AddClothingItemPageState();
}

//Determine which mapping of enums, FaIcon to use
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
  ClothingInfo clothingInfo = ClothingInfo();
  int activeStep = 0;
  int typeIndex = 0;
  bool imagePresent = false;
  List<ClothingColour> selectedColours = [];
  final FocusNode myFocusNodeDescription = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _controllerDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userManager = Provider.of<UserManager>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Map<Enum, FaIcon> category = _pickCategory(activeStep);
    //Title for each stage in adding new item
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

    int numSteps = 9;

    bool isMaxStep() {
      return activeStep == numSteps;
    }

    //active 1,2,3 are specific to which clothing type category is picked
    //therefore need to skip over these pages.
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

    void save() async {
      if (await userManager.currentUser.addPersonalListing(clothingInfo)) {
        Navigator.pushNamed(context, '/personal_profile');
        return;
      }

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
                Text("An internal error occurred. Please try again shortly.",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
              ],
            ),
          );
        },
      );
    }

    // updates the clothing info with the selection made by the user
    void saveSelection(int index) {
      switch (activeStep) {
        case 1:
        case 2:
        case 3: // clothing type
          clothingInfo = clothingInfo.copyWith(type: (category.keys.toList()[index] as ClothingType));
          break;
        case 4: // size
          clothingInfo = clothingInfo.copyWith(size: LetteredSizing(category.keys.toList()[index] as LetteredSize));
          break;
        case 5: // condition
          clothingInfo = clothingInfo.copyWith(condition: (category.keys.toList()[index] as ClothingCondition));
          break;
        case 6: // colours
          clothingInfo = clothingInfo.copyWith(colours: selectedColours);
          break;
        case 7: // gender
          clothingInfo = clothingInfo.copyWith(gender: (category.keys.toList()[index] as ClothingGender));
          break;
        case 8: // images
          _formKey.currentState!.save();
          break;
        case 9: // description
          clothingInfo =  clothingInfo.copyWith(description: _controllerDescription.text);
          break;
      }
    }

    void next(int index) {
      saveSelection(index);

      //active 1,2,3 are specific to which clothing type category is picked
      //Skip other sub type categories after picked
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
      } else if (activeStep == 9) {
        save();
      } else {
        activeStep++;
      }
      setState(() {});
    }

    //GPT suggest custom validation when not using form key
    //Function shows toast when no colours are given and user clicks next
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

    //Function shows toast when no description given
    void descriptionValidation() {
      if (_controllerDescription.text == "") {
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
                  Text("Please provide a description",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      }
    }

    //Function shows toaster when no images are given
    void imageMissing(List<Uint8List>? images) {
      if (images!.isEmpty) {
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
        imagePresent = false;
      } else {
        imagePresent = true;
      }
    }

    //GPT generated function for extracting and formatting names of enums from a map
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

    //Handle adding/removing colours for displaying purposes
    void handleColour(int index) {
      var colour = category.keys.toList()[index] as ClothingColour;

      if (selectedColours.contains(colour)) {
        selectedColours.remove(colour);
      } else {
        selectedColours.add(colour);
      }
      setState(() {});
    }

    return GradientBackground(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      //GPT used for LayoutBuilder
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
              GestureDetector(
                onTap: () {
                  myFocusNodeDescription.unfocus();
                },
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 5),
                          child: Text(
                            instructions[activeStep],
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        Visibility(
                          //Grid of icons not visible for images and description steps
                          visible: activeStep != 8 && activeStep != 9,
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
                                      color: activeStep == 6 && selectedColours.contains(
                                        category.keys.toList()[index] as ClothingColour,
                                      )
                                          ? Theme.of(context).hoverColor
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        //GPT used for BoxShadow styling
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.25),
                                          spreadRadius: 2,
                                          blurRadius: 6,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        //Text handling for condition strings
                                        //These enums contain multiple strings
                                        Text(
                                            getText(category, index) ==
                                                    "Newwithtags"
                                                ? "New with tags"
                                                : getText(category, index) ==
                                                        "Newnotags"
                                                    ? "New no tags"
                                                    : getText(category,
                                                                index) ==
                                                            "Likenew"
                                                        ? "Like new"
                                                        : getText(category,
                                                                    index) ==
                                                                "Wellworn"
                                                            ? "Well worn"
                                                            : getText(category,
                                                                index),
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
                        //Only display when up to description step
                        Visibility(
                          visible: activeStep == 9,
                          child: SizedBox(
                            width: width * 0.85,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              //GPT used for aid in styling textfield
                              child: TextField(
                                focusNode: myFocusNodeDescription,
                                textInputAction: TextInputAction.done,
                                onSubmitted: (text) {},
                                textAlignVertical: TextAlignVertical.top,
                                controller: _controllerDescription,
                                maxLines: 4,
                                maxLength: 150,
                                decoration: InputDecoration(
                                  fillColor: Colors.transparent,
                                  contentPadding: const EdgeInsets.only(
                                      top: 10, left: 12, right: 0),
                                  hintText: 'Aa',
                                  hintStyle:
                                      Theme.of(context).textTheme.bodyLarge,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).hoverColor,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).hoverColor,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //Show image selection field only when up to step 8
                        Visibility(
                            visible: activeStep == 8,
                            child: SizedBox(
                              height: height * 0.9,
                              width: width * 0.9,
                              child: Form(
                                key: _formKey,
                                child: ImageSelectionField(
                                    initialValue: clothingInfo.images,
                                    onSaved: (List<Uint8List>? images) {
                                        clothingInfo = clothingInfo.copyWith(
                                            images: images);
                                    },
                                    validator: (List<Uint8List>? images) {
                                      imageMissing((images ?? []));
                                      return null;
                                    }),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              //GPT for floating action button (previous), modified for our usage
              //Show except when on 1st step
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 25, bottom: 25, right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          visible: !isFirstStep(),
                          child: FloatingActionButton(
                              onPressed: () {
                                isFirstStep() ? null : previous();
                              },
                              child: const Icon(Icons.arrow_back_ios)),
                        ),
                        //GPT for floating action button (next), modified for our usage
                        //Only show on pages that require validation (colours, image, description)
                        Visibility(
                          visible: activeStep == 6 ||
                              activeStep == 8 ||
                              activeStep == 9,
                          child: FloatingActionButton(
                              onPressed: () {
                                //index doesn't matter here
                                isMaxStep()
                                    ? descriptionValidation()
                                    : activeStep == 6
                                        ? colourValidation()
                                        : activeStep == 8
                                            ? _formKey.currentState!.validate()
                                            : activeStep == 9;

                                if (imagePresent) {
                                  next(0);
                                }
                              },
                              child: const Icon(Icons.arrow_forward_ios)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 1,
      ),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomTopAppBar(),
      ),
    ));
  }
}
