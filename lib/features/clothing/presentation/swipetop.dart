import 'package:clothing_swap/features/clothing/presentation/fun_fact.dart';
import 'package:clothing_swap/features/clothing/presentation/fun_fact_class.dart';
import 'package:clothing_swap/features/messaging/chat_listing_class.dart';
import 'package:clothing_swap/features/profile/presentation/profile_class.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:clothing_swap/features/clothing/presentation/clothing_item_build.dart';
import 'package:toastification/toastification.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SwipePageTop extends StatefulWidget {
  const SwipePageTop({super.key});

  @override
  State<SwipePageTop> createState() => _SwipePageTopState();
}

class _SwipePageTopState extends State<SwipePageTop> {
  //use this for indexing queries/views
  late TutorialCoachMark explainer;
  List<TargetFocus> listTargets = [];
  int _counter = 0;
  bool _hasRun = false;
//Start Chat GPT, tutorial runs once per device
  @override
  void initState() {
    super.initState();
    _checkIfRun().then((_) {
      if (!_hasRun) {
        createTutorial();
        showTutorial();
      }
    });
  }

  Future<void> _checkIfRun() async {
    final prefs = await SharedPreferences.getInstance();
    _hasRun = prefs.getBool('hasRun') ?? false;

    if (!_hasRun) {
      // Run your code here
      await prefs.setBool('hasRun', true);
    }
  }
//End ChatGPT

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    if (_counter == publicListings.length) {
      _counter = 0;
    }
  }

  bool _checkCount() {
    if (_counter % 3 == 0 && _counter != 0) {
      return false;
    }
    return true;
  }

  final GlobalKey _tapingKey = GlobalKey();
  final GlobalKey _moreDetailKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final chatManager = Provider.of<ChatManager>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 0,
      ),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomTopAppBar(),
      ),
      body: Row(
        children: [
          Visibility(
            visible: kIsWeb,
            child: Expanded(
                flex: 1,
                child: Container(
                  color: Theme.of(context).canvasColor,
                )),
          ),
          Expanded(
            flex: 4,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.10,
                    child: Image.asset('lib/images/backdrop3.jpg',
                        fit: BoxFit.cover),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: (10)),
                      child: Container(
                        key: _tapingKey,
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withOpacity(0.9),
                        width: (kIsWeb) ? width * 0.50625 : width * 0.9125,
                        height: (kIsWeb) ? height * 0.675 : height * 0.58,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(),
                      child: SizedBox(
                        height: (kIsWeb) ? height * 0.7 : height * 0.6,
                        width: (kIsWeb) ? width * 0.525 : width * 0.925,
                        child: CardSwiper(
                          cardsCount: publicListings.length +
                              funFactExample.length, // Total count of cards
                          scale: 0.6,
                          isLoop: true,
                          numberOfCardsDisplayed: 3,
                          onSwipe: (previousIndex, currentIndex, direction) {
                            _incrementCounter(); // Increment count on swipe
                            //Chat modified for provider logic
                            if (direction.name == 'right') {
                              final userManager = Provider.of<UserManager>(
                                  context,
                                  listen: false);

                              final currentUser = userManager.currentUser;
                              final listerProfile = userManager.getUserById(
                                  publicListings[previousIndex].userId);

                              currentUser.addInterestedListing(ChatListing(
                                currentUserId: currentUser.id,
                                otherUserId: listerProfile.id,
                                name: listerProfile.name,
                                previewContent: "New Match",
                                time: "Now",
                                opened: false,
                                image: publicListings[previousIndex].images[0],
                              ));
                              toastification.showCustom(
                                context: context,
                                autoCloseDuration: const Duration(seconds: 3),
                                alignment: Alignment.bottomRight,
                                builder: (BuildContext context,
                                    ToastificationItem holder) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Theme.of(context).hoverColor,
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    margin: const EdgeInsets.all(8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('You\'ve got a New Match!',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 16),
                                        Row(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                final chat = chatManager
                                                    .findChatByUserId(
                                                        listerProfile.id);
                                                chatManager
                                                    .selectChat(chat!.id);
                                                Navigator.pushNamed(
                                                    context, '/chat');
                                              },
                                              child: const Text('Message Now!'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                            return true;
                          },
                          allowedSwipeDirection:
                              const AllowedSwipeDirection.only(
                                  left: true, right: true),
                          cardBuilder: (context, index, percentThresholdX,
                              percentThresholdY) {
                            final cardIndex = index %
                                (publicListings.length + funFactExample.length);

                            //ChatGPT modified original code for switching logic
                            // Determine card type based on the cardIndex
                            if ((cardIndex + 1) % 6 == 0) {
                              final safeIndexFact =
                                  (cardIndex ~/ 6) % funFactExample.length;
                              return FunFactCard(
                                  funFact: funFactExample[safeIndexFact]);
                            } else {
                              final safeIndex =
                                  cardIndex % publicListings.length;
                              return ClothingCard(
                                  item: publicListings[safeIndex]);
                            }
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            publicListings[_counter].name,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          IconButton(
                              icon: const Icon(Icons.tune),
                              iconSize: 35,
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pushNamed(context, '/search');
                              }),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(publicListings[_counter].location,
                              style:
                                  Theme.of(context).textTheme.headlineMedium),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: (7.5)),
                      child: IconButton(
                          icon: const Icon(
                              kIsWeb ? Icons.arrow_downward : Icons.swipe_up),
                          iconSize: 35,
                          key: _moreDetailKey,
                          onPressed: () {
                            Navigator.pushNamed(context, '/clothing_detail');
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Visibility(
            visible: kIsWeb,
            child: Expanded(
                flex: 1,
                child: Container(
                  color: Theme.of(context).canvasColor,
                )),
          ),
        ],
      ),
    );
  }

//https://github.com/djshah17/Flutter-Tutorial-Coach-Mark-Sample/blob/master/lib/my_tutorial_coach_mark_screen.dart
//Tutorial Code modified for our application
  void createTutorial() {
    listTargets.add(
      TargetFocus(
        color: const Color.fromARGB(255, 69, 65, 65),
        identify: "Target 2",
        keyTarget: _tapingKey,
        contents: [
          TargetContent(
            child: const Column(children: [
              Padding(
                padding: EdgeInsets.only(bottom: (0.0)),
                child: Text(
                    "1. Swipe Left if you're not interested\n2. Swipe Right if you're interested\n3. Tap to view more images",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 22, color: Colors.white)),
              ),
            ]),
          )
        ],
        shape: ShapeLightFocus.RRect,
        radius: 5,
      ),
    );

    listTargets.add(TargetFocus(
      color: const Color.fromARGB(255, 69, 65, 65),
      identify: "Target 3",
      keyTarget: _moreDetailKey,
      contents: [
        TargetContent(
            child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Swipe or Tap up for more info",
              style: TextStyle(fontSize: 22, color: Colors.white),
              textAlign: TextAlign.end,
            ),
          ],
        )),
      ],
      shape: ShapeLightFocus.Circle,
    ));
  }

  void showTutorial() {
    explainer = TutorialCoachMark(
      targets: listTargets,
      colorShadow: Colors.white,
      hideSkip: true,
      paddingFocus: 1,
      opacityShadow: 0.95,
      onClickTarget: (target) {},
      onClickOverlay: (target) {},
    )..show(context: context);
  }
}
