import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flip_card/flip_card.dart';

class SwipePageTop extends StatefulWidget {
  const SwipePageTop({super.key});

  @override
  State<SwipePageTop> createState() => _SwipePageTopState();
}

class _SwipePageTopState extends State<SwipePageTop> {
  //use this for indexing queries/views
  int _counter = 0;
  int _currentSide = 0;
  List images = [
    Image.asset('lib/images/0.jpg', fit: BoxFit.fill),
    Image.asset('lib/images/1.jpg', fit: BoxFit.fill),
    Image.asset('lib/images/2.jpg', fit: BoxFit.fill),
  ];

  List images2 = [
    Image.asset('lib/images/watermelon.png', fit: BoxFit.fill),
    Image.asset('lib/images/person.png', fit: BoxFit.fill)
  ];
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _flipCard() {
    setState(() {
      if ((_currentSide + 1) >= images2.length) {
        _currentSide = 0;
      } else {
        _currentSide = _currentSide + 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
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
            padding: const EdgeInsets.only(top: (10.0)),
            child: SizedBox(
              height: (kIsWeb) ? height * 0.65 : height * 0.6,
              width: (kIsWeb) ? width * 0.6 : width * 0.925,
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
                        FlipCard(
                            onFlip: _flipCard,
                            key: Key('flip$index'),
                            direction: FlipDirection.HORIZONTAL,
                            front: images[index],
                            back: images2[_currentSide]),
              ),
            ),
          ),
          SizedBox(
            height: !(kIsWeb) ? height * 0.004 : null,
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
                const Text(
                  '',
                ),
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
                const Text(
                  '',
                ),
              ],
            ),
          ),
          IconButton(
              icon: const Icon(Icons.arrow_circle_up),
              iconSize: 35,
              color: Colors.white,
              onPressed: () {
                Navigator.pushNamed(context, '/clothing_detail');
              }),
        ],
      ),
    );
  }
}
