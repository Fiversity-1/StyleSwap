// startpage.dart
import 'package:clothing_swap/features/clothing/util/cards.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/material.dart';

class SwipePage extends StatelessWidget {
  const SwipePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
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
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: SizedBox(
                height: 400,
                child: Stack(
                  children: [
                    CardSwipe(title: 'CardSwipe'),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: Text(
                      'Steve',
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.category),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              width: 380,
              child: Text(
                'Mount Cotton',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(
              height: 5,
              width: 250,
              child: ElevatedButton(
                child: const Text(''),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext content) {
                        return SizedBox(
                          height: 1000,
                          child: Center(
                            child: ElevatedButton(
                                child: const Text(''),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ),
                        );
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
