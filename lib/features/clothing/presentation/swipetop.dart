import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/material.dart';

class SwipePageTop extends StatefulWidget {
  const SwipePageTop({super.key});

  @override
  State<SwipePageTop> createState() => _SwipePageTopState();
}

class _SwipePageTopState extends State<SwipePageTop> {
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
      backgroundColor: Theme.of(context).primaryColor,
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
                height: height * 0.7,
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
                        fit: BoxFit.cover),
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
                      onPressed: () {
                        Navigator.pushNamed(context, '/clothing_detail');
                      }),
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
          ],
        ),
      ),
    );
  }
}
