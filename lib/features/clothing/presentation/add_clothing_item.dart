import 'package:clothing_swap/features/clothing/domain/clothing_info.dart';
import 'package:clothing_swap/widgets/image_selection.dart';
import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';

class AddClothingItemPage extends HookWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AddClothingItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final clothingInfo = useState<ClothingInfo>(ClothingInfo());
    final activeStep = useState<int>(0);

    // the steps in the form to complete
    List<Widget> steps = <Widget>[
      ImageSelectionField(
        initialValue: clothingInfo.value.image,
        onChanged: (XFile? file) =>
        clothingInfo.value = clothingInfo.value.copyWith(image: file),
        validator: (XFile? file) =>
        file == null ? "Image required" : null,
      ),
      SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
        children: [
          TextFormField(
            initialValue: clothingInfo.value.brand,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Brand',
            ),
            validator: (String? text) => (text?.length ?? 0) < 1
                ? "Brand must be provided"
                : null,
            onChanged: (String? text) =>
            clothingInfo.value = clothingInfo.value.copyWith(brand: text),
          ),
          const SizedBox(height: 10),
          SizedBox(
              height: 300,
              child: TextFormField(
                  initialValue: clothingInfo.value.description,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                  onChanged: (String? text) =>
                  clothingInfo.value = clothingInfo.value
                      .copyWith(description: text),
                  keyboardType: TextInputType.multiline,
                  maxLines: null
              )
          ),
          const SizedBox(height: 10),
          SizedBox(
              height: 300,
              child: TextFormField(
                  initialValue: clothingInfo.value.description,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                  onChanged: (String? text) =>
                  clothingInfo.value = clothingInfo.value
                      .copyWith(description: text),
                  keyboardType: TextInputType.multiline,
                  maxLines: null
              )
          )
        ],
      )),
    ];

    int numSteps = steps.length;
    Widget currentWidget = steps[activeStep.value];

    bool isMaxStep() {
      return activeStep.value >= (numSteps - 1);
    }

    void nextStep() {
      if (isMaxStep()) {
        return;
      }

      activeStep.value++;
    }

    bool isFirstStep() {
      return activeStep.value <= 0;
    }

    void previousStep() {
      if (isFirstStep()) {
        return;
      }

      activeStep.value--;
    }

    void validate() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        nextStep();
      }
    }

    void save() {
      if (_formKey.currentState!.validate()) {}
    }

    return Scaffold(
      backgroundColor:  Colors.white,
        bottomNavigationBar: const CustomBottomNavBar(
          currentIndex: 1,
        ),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomTopAppBar(),
        ),
        body: Form(
                key: _formKey,
                child: Column(children: [
                  /// Jump buttons.
                  Expanded(child: currentWidget),
                  
                  // Next and Previous buttons.
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: isFirstStep() ? null : previousStep,
                              child: const Text("Previous")),
                          ElevatedButton(
                              onPressed: isMaxStep() ? save : validate,
                              child: const Text("Next")),
                        ],
                      )
                  )
                ])));
  }
}
