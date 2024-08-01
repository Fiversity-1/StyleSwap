import 'package:clothing_swap/features/clothing/domain/ClothingInfo.dart';
import 'package:clothing_swap/widgets/image_selection.dart';
import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';


class AddClothingItemPage extends HookWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final clothingInfo = useState<ClothingInfo>(ClothingInfo());
    final activeStep = useState<int>(0);

    List<Widget> steps = useMemoized(() =>  <Widget>[
        ImageSelectionField(initialValue: clothingInfo.value.image,
          onSaved: (XFile? file) => clothingInfo.value = ClothingInfo(image: file),
          validator: (XFile? file) => file == null ? "Must provide an image." : null,),
        Center(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Brand',
                  ),
                  validator: (String? text) => (text?.length ?? 0) < 1 ? "Brand must be provided" : null,
                  onSaved: (String? text) => clothingInfo.value = ClothingInfo(brand: text),
                ),
                const SizedBox(height: 10),
                Expanded(child: TextFormField(
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                  ),
                  validator: (String? text) => (text?.length ?? 0) < 1 ? "Brand must be provided" : null,
                  onSaved: (String? text) => clothingInfo.value = ClothingInfo(brand: text),
                  keyboardType: TextInputType.multiline,
                  maxLines: null
                  )
                )
              ],
            )
        )]
    , [clothingInfo.value]);

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
      if (_formKey.currentState!.validate()) {

      }
    }

    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1,),
      appBar: AppBar(
        title: const Text('Add Item'),
        backgroundColor: const Color.fromRGBO(255, 87, 87, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          child:Column(
              children: [DotStepper(
                dotCount: numSteps,
                dotRadius: 10,
                activeStep: activeStep.value,
                shape: Shape.circle,
                spacing: 10,
                indicator: Indicator.shift,
                /// TAPPING WILL NOT FUNCTION PROPERLY WITHOUT THIS PIECE OF CODE.
                onDotTapped: (tappedDotIndex) {
                  activeStep.value = tappedDotIndex;
                },

                fixedDotDecoration: const FixedDotDecoration(
                  color: Colors.grey,
                ),
                indicatorDecoration: const IndicatorDecoration(
                    color: Colors.redAccent,
                    strokeColor: Colors.redAccent,
                    strokeWidth: 0
                ),

              ),
                /// Jump buttons.
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                        child: currentWidget
                    )
                ),

                // Next and Previous buttons.
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(onPressed: isFirstStep() ? null : previousStep, child: const Text("Previous")),
                    ElevatedButton(onPressed: isMaxStep() ? save : validate, child: const Text("Next")),
                  ],
                )])
        )
        ));
  }
}