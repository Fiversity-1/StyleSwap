import 'package:clothing_swap/widgets/image_selection.dart';
import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:im_stepper/stepper.dart';

class AddClothingItemPage extends StatefulWidget {
  const AddClothingItemPage({super.key});


  @override
  State<StatefulWidget> createState() => _AddClothingItemPageState();


}

class _AddClothingItemPageState extends State<AddClothingItemPage> {
  int activeStep = 0;

  bool isMaxStep() {
    return activeStep >= (getSteps().length - 1);
  }

  void nextStep() {
    if (isMaxStep()) {
      return;
    }

    setState(() {
      activeStep++;
    });
  }

  bool isFirstStep() {
    return activeStep <= 0;
  }

  void previousStep() {
    if (isFirstStep()) {
      return;
    }

    setState(() {
      activeStep--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1,),
      appBar: AppBar(
        title: const Text('Add Item'),
        backgroundColor: const Color.fromRGBO(255, 87, 87, 1),
      ),
      body: Padding(

        padding: EdgeInsets.all(32),
        child: Column(
    children: [DotStepper(
        dotCount: getSteps().length,
        dotRadius: 10,
        activeStep: activeStep,
        shape: Shape.circle,
        spacing: 10,
        indicator: Indicator.shift,
        /// TAPPING WILL NOT FUNCTION PROPERLY WITHOUT THIS PIECE OF CODE.
        onDotTapped: (tappedDotIndex) {
          setState(() {
            activeStep = tappedDotIndex;
          });
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
    child: Padding(padding: const EdgeInsets.all(18.0), child: getSteps()[activeStep])
    ),

    // Next and Previous buttons.
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      ElevatedButton(onPressed: isFirstStep() ? null : previousStep, child: const Text("Previous")),
    ElevatedButton(onPressed: isMaxStep() ? null : nextStep, child: const Text("Next")),
    ],
    )])));
  }


  static List<Widget> getSteps() {
    return <Widget>[
      const ImageSelection(),
      const Center(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Brand',
              ),
            ),
          ],
        )
      )
    ];
  }
}