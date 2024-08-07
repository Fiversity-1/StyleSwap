import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class SwipePageTop extends StatefulWidget {
  const SwipePageTop({super.key});

  @override
  State<SwipePageTop> createState() => _SwipePageTopState();
}

class _SwipePageTopState extends State<SwipePageTop> {
  //use this for indexing queries/views
  int _counter = 0;
  List images = [
    Image.asset('lib/images/0.jpg', fit: BoxFit.fill),
    Image.asset('lib/images/1.jpg', fit: BoxFit.fill),
    Image.asset('lib/images/2.jpg', fit: BoxFit.fill),
  ];
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: (15.0)),
            child: SizedBox(
              height: height * 0.65,
              width: width * 0.97,
              child: CardSwiper(
                cardsCount: 3,
                numberOfCardsDisplayed: 3,
                onSwipe: (previousIndex, currentIndex, direction) {
                  _incrementCounter();
                  if (direction.name == 'right') {
                    Navigator.pushNamed(context, '/match_animation');
                  }
                  return true;
                },
                allowedSwipeDirection:
                    const AllowedSwipeDirection.only(left: true, right: true),
                cardBuilder:
                    (context, index, percentThresholdX, percentThresholdY) =>
                        images[index],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Steve$_counter',
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.left,
                ),
                IconButton(
                    icon: const Icon(Icons.more_horiz),
                    iconSize: 35,
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pushNamed(context, '/clothing_detail');
                    }),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mount Cotton',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.left,
                ),
                Text(
                  '',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
