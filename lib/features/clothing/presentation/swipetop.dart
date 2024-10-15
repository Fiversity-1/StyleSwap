import 'package:clothing_swap/features/clothing/application/search_provider.dart';
import 'package:clothing_swap/features/clothing/data/matching_api.dart';
import 'package:clothing_swap/features/clothing/domain/clothing_info.dart';
import 'package:clothing_swap/features/clothing/presentation/clothing_item_class.dart';
import 'package:clothing_swap/features/messaging/chat_listing_class.dart';
import 'package:clothing_swap/features/profile/presentation/profile_class.dart';
import 'package:clothing_swap/theme/gradient.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:clothing_swap/widgets/fun_fact.dart';
import 'package:clothing_swap/widgets/loading_card.dart';
import 'package:clothing_swap/widgets/no_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:toastification/toastification.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'clothing_item_build.dart';

//Page for swiping through public listings
class SwipePageTop extends StatefulWidget {
  const SwipePageTop({super.key});

  @override
  State<SwipePageTop> createState() => _SwipePageTopState();
}

class _SwipePageTopState extends State<SwipePageTop> {
  //use this for indexing queries/views
  late TutorialCoachMark explainer;
  int _cardsSwiped = 0;
  List<TargetFocus> listTargets = [];
  bool _hasRun = false;
//Start GPT, tutorial runs once per device, delay searchResult init
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final searchResults = Provider.of<Search>(context, listen: false);

      if (searchResults.getListing(update: false).isEmpty) {
        searchResults.resetSearch();
      }

      setState(() {
        _cardsSwiped = 0;
      });
    });
  }

  Future<void> _checkIfRun() async {
    final prefs = await SharedPreferences.getInstance();
    _hasRun = prefs.getBool('hasRun') ?? false;
  }
//End ChatGPT

  Future<void> _tutorialRan() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _hasRun = true;
    });
    await prefs.setBool('hasRun', true);
  }

  void _handleRemove(Search searchResults, int previousIndex) {
    searchResults.removeListing(previousIndex);
  }

  final GlobalKey _tapingKey = GlobalKey();
  final GlobalKey _moreDetailKey = GlobalKey();
  final GlobalKey _preferenceKey = GlobalKey();
  late Search searchResults;
  late ChatManager chatManager;

  @override
  Widget build(BuildContext context) {
    //Need to update for whatever search returns, publicListing will be
    //replaced and need to be updated
    searchResults = Provider.of<Search>(context);
    chatManager = Provider.of<ChatManager>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    _checkIfRun().then((_) {
      if (!_hasRun && searchResults.getListing().isNotEmpty) {
        createTutorial();
        showTutorial();
      }
    });

    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: const CustomBottomNavBar(
          currentIndex: 0,
        ),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomTopAppBar(),
        ),
        //GPT used for LayoutBuilder
        body: LayoutBuilder(
          builder: (context, constraints) {
            // Define grid column count based on available width
            bool sideBars = constraints.maxWidth > 960;
            //Sidebars used for web version so image isn't strecthed out
            return Row(
              children: [
                Visibility(
                  visible: sideBars,
                  child: Expanded(
                      flex: 1,
                      child: Container(
                        color: Theme.of(context).canvasColor,
                      )),
                ),
                Expanded(
                  flex: 3,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //Handle Different Padding for when no listing left

                          Padding(
                            padding: EdgeInsets.only(
                                top: searchResults.checkCardType() == "Empty"
                                    ? 10
                                    : 0),
                            child: SizedBox(
                                height: searchResults.checkCardType() != "Empty"
                                    ? height * 0.7
                                    : height * 0.65,
                                width: searchResults.checkCardType() != "Empty"
                                    ? width * 0.925
                                    : width * 0.8,
                                child: searchResults.checkCardType() != "Empty"
                                    ? CardSwiper(
                                        key: _tapingKey,
                                        cardsCount: searchResults.getListing().length + 1 + _cardsSwiped,
                                        scale: 0.6,
                                        isLoop: false,
                                        numberOfCardsDisplayed: 2,
                                        onSwipe: handleSwipe,
                                        allowedSwipeDirection:
                                            const AllowedSwipeDirection.only(
                                                left: true, right: true),
                                        cardBuilder: (context,
                                            index,
                                            percentThresholdX,
                                            percentThresholdY) {
                                          index = index - _cardsSwiped;

                                          if (index < searchResults.getListing().length) {
                                            var item = searchResults.getListing()[index];

                                            if (item is ClothingInfo)
                                              return ClothingCard(item: (item as ClothingInfo));
                                            else if (item is FunFact)
                                              return FunFactCard(index: (item as FunFact).funFactId);
                                          }

                                          return const NoResultCard();
                                        },
                                      )
                                    //Show no result image once user has run
                                    //out of search results
                                    : (searchResults.searching ? const LoadingCard() : const NoResultCard())),

                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 60,
                        left: 17.5,
                        child: Text(
                          searchResults.checkCardType() == "Clothes"
                              ? searchResults.getListing()[0].user ?? "Anonymous"
                              : searchResults.checkCardType() == "Fact"
                                  ? "Fun Fact!"
                                  : "Sorry!",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      Positioned(
                        bottom: 60,
                        right: 5,
                        child: IconButton(
                            icon: const Icon(Icons.tune),
                            key: _preferenceKey,
                            iconSize: 30,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/view_clothes_preferences');
                            }),
                      ),
                      Positioned(
                        bottom: 20,
                        left: 17.5,
                        child: Text(
                            searchResults.checkCardType() == "Clothes"
                                ? searchResults.getListing()[0].distance ?? "Unknown"
                                : searchResults.checkCardType() == "Fact"
                                    ? ""
                                    : "No Cards left!",
                            style: Theme.of(context).textTheme.headlineSmall),
                      ),
                      Positioned(
                        bottom: 5,
                        //ony display swipe up icon for intial swipes otherwise
                        //the ui is too cluttered
                        child: Visibility(
                          visible: searchResults.checkCardType() == "Clothes",
                          child: FloatingActionButton(
                            key: _moreDetailKey,
                            onPressed: () {},
                            elevation: 0,
                            hoverColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            backgroundColor: Colors.transparent,
                            child: const Icon(Icons.swipe_up, size: 35),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: sideBars,
                  child: Expanded(
                      flex: 1,
                      child: Container(
                        color: Theme.of(context).canvasColor,
                      )),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<bool> handleSwipe(previousIndex, currentIndex,
      direction) async {
    //Keep track of interest listings on
    //non fun fact cards
    try {
      if (searchResults.getListing()[0]
        is FunFact) {
        setState(() {
          _cardsSwiped++;
        });

        _handleRemove(searchResults, 0);

        return true;
      }

      final userManager =
      Provider.of<UserManager>(
          context,
          listen: false);

      final currentUser =
          userManager.currentUser;

      final clothingItem = searchResults
          .getListing()[0];

      if (await likeDislikeItem(clothingItem.id, direction == CardSwiperDirection.right)) {
        currentUser.addInterestedListing(
            ChatListing(
              currentUserId: currentUser.id,
              otherUserId: clothingItem.userId,
              name: clothingItem.user ?? "Anonymous",
              previewContent: "New Match",
              time: "Now",
              opened: false,
              image: searchResults
                  .getListing()[0]
                  .images.length >= 1 ? MemoryImage(searchResults
                  .getListing()[0]
                  .images[0]) : const AssetImage('lib/images/noImage.png'),
            ));
        //Show toaster when match occurs
        //Rowan needs to move based on integration
        //Match doesn't occur on instant swipe right
        toastification.showCustom(
          context: context,
          autoCloseDuration:
          const Duration(seconds: 3),
          alignment: Alignment.topLeft,
          builder: (BuildContext context,
              ToastificationItem holder) {
            return Container(
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.circular(
                      8),
                  color: Theme
                      .of(context)
                      .hoverColor),
              padding:
              const EdgeInsets.all(16),
              margin:
              const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment
                    .center,
                children: [
                  const Text(
                      'You\'ve got a New Match!',
                      style: TextStyle(
                          fontWeight:
                          FontWeight
                              .bold)),
                  const SizedBox(
                      height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final chat = chatManager
                          .findChatByUserId(
                          clothingItem
                              .userId);
                      chatManager
                          .selectChat(
                          chat!.id);
                      Navigator.pushNamed(
                        context,
                        '/chat',
                      );
                    },
                    child: const Text(
                        'Send a Message!'),
                  ),
                ],
              ),
            );
          },
        );
      }
    } catch (e) {
      print(e);
      return false;
    }

    setState(() {
      _cardsSwiped++;
    });

    _handleRemove(searchResults, 0);
    return true;
  }

//https://github.com/djshah17/Flutter-Tutorial-Coach-Mark-Sample/blob/master/lib/my_tutorial_coach_mark_screen.dart
//Tutorial Code modified for our application, display brief tutorial
  void createTutorial() {
    listTargets.add(
      TargetFocus(
        color: Colors.blue,
        identify: "Target 1",
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
      color: Colors.blue,
      identify: "Target 2",
      keyTarget: _moreDetailKey,
      contents: [
        TargetContent(
            child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Swipe up for more info",
              style: TextStyle(fontSize: 22, color: Colors.white),
              textAlign: TextAlign.end,
            ),
          ],
        )),
      ],
      shape: ShapeLightFocus.Circle,
    ));

    listTargets.add(TargetFocus(
      color: Colors.blue,
      identify: "Target 3",
      keyTarget: _preferenceKey,
      contents: [
        TargetContent(
            child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Press to set search preferences",
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
      onFinish: _tutorialRan,
    )..show(context: context);
  }
}
