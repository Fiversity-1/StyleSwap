import 'package:clothing_swap/features/clothing/domain/clothing_info.dart';
import 'package:clothing_swap/features/clothing/presentation/select_preferences.dart';
import 'package:clothing_swap/theme/gradient.dart';
import 'package:clothing_swap/widgets/image_selection.dart';
import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:string_extensions/string_extensions.dart';
import 'package:toastification/toastification.dart';

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
  final FocusNode myFocusNodeDescription = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _controllerDescription = TextEditingController();

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

    void save() {
      Navigator.pushNamed(context, '/personal_profile');
    }

    void next(int index) {
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
      } else {
        activeStep++;
      }
      setState(() {});
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
      } else {
        save();
      }
    }

    void imageMissing(List<XFile>? images) {
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

    return GradientBackground(
        child: Scaffold(
      backgroundColor: Colors.transparent,
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
              GestureDetector(
                onTap: () {
                  myFocusNodeDescription.unfocus();
                },
                child: SingleChildScrollView(
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
                          //Not visible for images and description
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
                                      color: selectedColours.contains(
                                        getText(category, index),
                                      )
                                          ? Theme.of(context).hoverColor
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(
                                              0.25), // Shadow color and opacity
                                          spreadRadius:
                                              2, // Shadow spread radius
                                          blurRadius: 6, // Shadow blur radius
                                          offset: const Offset(
                                              0, 4), // Shadow offset
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
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
                        Visibility(
                          visible: activeStep == 9,
                          child: SizedBox(
                            width: width * 0.85,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 20),
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
                                  // Define the border style for both enabled and focused states
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).hoverColor,
                                        width: 1), // Border color and width
                                    borderRadius: BorderRadius.circular(
                                        15), // Customize the border radius
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).hoverColor,
                                        width:
                                            1), // Same border for focused state
                                    borderRadius: BorderRadius.circular(
                                        8), // Customize the border radius
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                            visible: activeStep == 8,
                            child: SizedBox(
                              height: height * 0.9,
                              width: width * 0.9,
                              child: Form(
                                key: _formKey,
                                child: ImageSelectionField(
                                    initialValue: clothingInfo.images,
                                    onSaved: (List<XFile>? images) =>
                                        clothingInfo = clothingInfo.copyWith(
                                            images: images),
                                    validator: (List<XFile>? images) {
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
              //Chat GPT for floating action button, modified
              Visibility(
                visible: !isFirstStep(),
                child: Positioned(
                  left: 15,
                  bottom:
                      25, // Adjust this value to place it higher from the bottom
                  child: FloatingActionButton(
                      onPressed: () {
                        isFirstStep() ? null : previous();
                      },
                      child: const Icon(Icons.arrow_back_ios)),
                ),
              ),
              Visibility(
                visible: activeStep == 6 || activeStep == 8 || activeStep == 9,
                child: Positioned(
                  right: 15,
                  bottom:
                      25, // Adjust this value to place it higher from the bottom
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

                        if (imagePresent && activeStep == 8) {
                          next(0);
                        }
                      },
                      child: const Icon(Icons.arrow_forward_ios)),
                ),
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
