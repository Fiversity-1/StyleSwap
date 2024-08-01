// startpage.dart
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/material.dart';

class SwipePage extends StatefulWidget {
  const SwipePage({super.key, required this.title});

  final String title;
  @override
  State<SwipePage> createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  //use this for indexing queries/views
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 87, 87, 1),
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 1,
      ),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomTopAppBar(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: (15.0)),
              child: SizedBox(
                height: height * 0.6,
                width: width * 0.97,
                child: GestureDetector(
                  onHorizontalDragEnd: (dragEndDetails) {
                    if (dragEndDetails.primaryVelocity! < 0) {
                      //left swipe
                      _incrementCounter();
                    } else if (dragEndDetails.primaryVelocity! > 0) {
                      _incrementCounter();
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Image.asset('lib/images/$_counter.jpg',
                        fit: BoxFit.fill),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: height * 0.07,
                    width: width * 0.35,
                    child: Text(
                      'Steve$_counter',
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.05,
                    width: width * 0.477,
                    child: Text(
                      '3',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.sell_outlined),
                    iconSize: 35,
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.06,
              width: width * 0.93,
              child: Text(
                'Mount Cotton$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: height * 0.0425,
              width: width * 0.285,
              child: ElevatedButton(
                child: const Text('Details'),
                onPressed: () {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext content) {
                        return SizedBox(
                            height: height * 0.6,
                            width: width,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: ElevatedButton(
                                      child: const Text('Back'),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: SizedBox(
                                    height: height * 0.06,
                                    width: width,
                                    child: Text(
                                      'Description',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child: SizedBox(
                                    height: height * 0.080,
                                    width: width,
                                    child: Text(
                                      'This is random filler text for the sake of showing what it may look like and yeah yeah yeah',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 15),
                                  child: SizedBox(
                                    height: height * 0.06,
                                    width: width,
                                    child: Text(
                                      'Item Breakdown!',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: SizedBox(
                                    height: height * 0.25,
                                    width: width,
                                    child: Text(
                                      'Type:        Placement\nSize:         Placement\nColour:       Placement\nBrand:       Placement\nFit:          Placement\nMaterial:    Placement\nCondition:  Placement',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                              ],
                            ));
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
