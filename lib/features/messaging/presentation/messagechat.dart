import 'dart:io';
import 'dart:math';

import 'package:clothing_swap/features/clothing/domain/clothing_info.dart';
import 'package:clothing_swap/features/messaging/domain/chat_listing_class.dart';
import 'package:clothing_swap/features/profile/domain/profile_class.dart';
import 'package:clothing_swap/theme/gradient.dart';
import 'package:clothing_swap/theme/theme.dart';
import 'package:clothing_swap/theme/theme_switcher.dart';
import 'package:clothing_swap/widgets/photo_modal.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

import '../../clothing/data/matching_api.dart';
import '../../profile/data/profile_api.dart';

//Individual Chat UI
class MessageChat extends StatefulWidget {
  const MessageChat({super.key});

  @override
  State<MessageChat> createState() => _MessageChatState();
}

class _MessageChatState extends State<MessageChat> {
  final _sendText = TextEditingController();
  final _scroller = ScrollController();

  @override
  // GPT for scrolling if new listing added to chat
  void didChangeDependencies() {
    super.didChangeDependencies();

    final chatManager = Provider.of<ChatManager>(context);
    final chat = chatManager.selectedChat;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (chat!.messages[chat.messages.length].type == "listing") {
        _scroller.animateTo(_scroller.position.maxScrollExtent,
            curve: Curves.easeOut, duration: const Duration(milliseconds: 500));
      }
    });
  }

//Void function idea to handle  both onSubmitted: and onPressed (icon) from GPT
//code modified for personal implementation
  void _handleSend(String value, ChatManager chatManager, ChatListing chat) {
    _sendText.text.isNotEmpty
        ? chatManager.addChatMessage(
            chat.id,
            (ChatMessage(
                senderUserId: chat.currentUserId,
                receiverUserId: chat.otherUserId,
                messageContent: _sendText.text,
                messageType: "sender",
                time: "5:45pm",
                type: "message")))
        : null;
    //scroll to latest message, due to message container size need to add to maxScrollExtend
    _sendText.clear();
    _scroller.animateTo(
      _scroller.position.maxScrollExtent + 100,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
    setState(() {});
    //make sure keyboard stays open
    myFocusNode.requestFocus();
  }

  //same as sending text, with slightly larger scrolling to handle image size
  void _handleImage(XFile image, ChatManager chatManager, ChatListing chat) {
    chatManager.addChatMessage(
        chat.id,
        ChatMessage(
            senderUserId: chat.currentUserId,
            receiverUserId: chat.otherUserId,
            messageContent: "Sent an image",
            messageType: "sender",
            time: "5:45pm",
            images: image,
            type: "image"));
    _scroller.animateTo(
      //scroll image size
      _scroller.position.maxScrollExtent + 350,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
    setState(() {});
  }

//https://medium.com/@kavyamistry0612/building-interactive-user-interfaces-with-alert-dialogs-in-flutter-81e268fb72f0
//Used for demonstrating how to implement flutter alert dialog
//Dialog to show Chat Guide
  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Text('Chat Guide'),
          content: const Text(
              'Press the menu button for 4 options:\n\n1. View other person\'s profile and select an image to add to the trade\n\n 2. View your personal proposed listings\n\n 3.Remove personal listing/s from the propsed trade\n\n 4. Check out our safety tips for messaging and trading'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              //Gpt for styling button
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white // Set the text color here
                  ),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

//https://medium.com/@kavyamistry0612/building-interactive-user-interfaces-with-alert-dialogs-in-flutter-81e268fb72f0
//Used for demonstrating how to implement flutter alert dialog
//Dialog for user to rate another user
  void _showRatingDialog(BuildContext context) {
    double rating = 0.0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            // GPT used to Make the dialog stateful by using StatefulBuilder
            return AlertDialog(
              backgroundColor: Colors.blue,
              title: const Text('Rate User'),
              content: PannableRatingBar(
                rate: rating,
                items: List.generate(
                  5,
                  (index) => const RatingWidget(
                    selectedColor: Colors.yellow,
                    unSelectedColor: Colors.grey,
                    child: Icon(
                      Icons.star,
                      size: 48,
                    ),
                  ),
                ),
                onChanged: (value) {
                  // The rating value is updated on tap or drag.
                  setState(() {
                    rating = value;
                  });
                },
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  // GPT for Styling button
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white, // Set the text color here
                  ),
                  child: const Text('Done'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  final List<Widget> _empty = [
    ClipOval(
      //GPT used for transform scale - changes image scale
      child: Transform.scale(
        scale: 0.6, // Adjust the scale factor as needed
        child: Image.asset(
          'lib/images/noImage.png',
          width: 100,
          height: 100,
          fit: BoxFit.none,
        ),
      ),
    )
  ];

//Dialog to report another user
  void _showReportDialog(context, String userId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Text('Report User'),
          content: const Text(
              'Thank you for your report. A member of our moderation team will conduct an investigation shortly.\n\nWould you like to block the user?'),
          actions: [
            TextButton(
              onPressed: () async {
                await blockUser(userId); // block the user

                if (context.mounted) {
                  final userManager =
                      Provider.of<UserManager>(context, listen: false);
                  var listing = userManager.currentUser.interestedListings
                      .firstWhere((listing) {
                    return listing.otherUserId == userId;
                  });
                  userManager.currentUser.removeInterestedListing(listing);
                  Navigator.pushNamedAndRemoveUntil(
                      context, "/message", ModalRoute.withName('/profile'));
                }
              },
              //GPT used for styling button
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              //GPT used for styling button
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  final FocusNode myFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final chatManager = Provider.of<ChatManager>(context);
    final chatNotifier = chatManager.selectedChat;
    chatManager.setChatOpened(
        chatNotifier!.id, true, chatNotifier.previewContent, "5:45pm");
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ChangeNotifierProvider.value(
        value: chatNotifier,
        child: Consumer<ChatListing>(builder: (context, chat, child) {
          return GradientBackground(
            child: chat.trades == null
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white))
                : Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      title: Image.asset(
                        Provider.of<ThemeSwitcher>(context).themeData ==
                                lightTheme
                            ? 'lib/images/logo/hanger.png'
                            : 'lib/images/logo/hanger_white.png',
                        height: 65,
                        width: 75,
                      ),
                      centerTitle: true,
                      actions: [
                        IconButton(
                            onPressed: () {
                              _showAlertDialog(context);
                            },
                            icon: const Icon(Icons.help)),
                        //Based on https://www.youtube.com/watch?v=YHNCYfqGrBY for speed dial
                        SpeedDial(
                            //GPT for speed dial direction
                            direction: SpeedDialDirection.down,
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            animatedIcon: AnimatedIcons.menu_close,
                            buttonSize: const Size(60, 60),
                            children: [
                              SpeedDialChild(
                                  child: const Icon(Icons.person),
                                  label: "${chat.name}'s other Listings",
                                  backgroundColor: Colors.blue,
                                  labelBackgroundColor: Colors.blue,
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/public_profile');
                                  }),
                              SpeedDialChild(
                                  child: const Icon(Icons.manage_accounts),
                                  label: "My Proposed Listings",
                                  backgroundColor: Colors.green,
                                  labelBackgroundColor: Colors.green,
                                  onTap: () {
                                    //give user option to view and remove their proposed listings
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return ChangeNotifierProvider.value(
                                            value: chatNotifier,
                                            child: Consumer<ChatListing>(
                                                builder:
                                                    (context, chat, child) {
                                              return StatefulBuilder(
                                                builder: (BuildContext context,
                                                    StateSetter
                                                        setBottomState) {
                                                  return SizedBox(
                                                    width: kIsWeb
                                                        ? width * 0.25
                                                        : width * 0.5,
                                                    child: ListView.builder(
                                                        shrinkWrap: true,
                                                        itemCount: min(
                                                            chat
                                                                .trades!
                                                                .ourTrades
                                                                .length,
                                                            5),
                                                        itemBuilder:
                                                            (context, index) {
                                                          return ListTile(
                                                            tileColor: Colors
                                                                .transparent,
                                                            minLeadingWidth: 0,
                                                            title: CircleAvatar(
                                                              radius: 50,
                                                              child: ClipOval(
                                                                child:
                                                                    AspectRatio(
                                                                  aspectRatio:
                                                                      1.0,
                                                                  // Ensures a 1:1 ratio
                                                                  child: Image
                                                                      .memory(
                                                                    chat
                                                                        .trades!
                                                                        .ourTrades[
                                                                            index]
                                                                        .images
                                                                        .first,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            trailing:
                                                                IconButton(
                                                              icon: const Icon(Icons
                                                                  .remove_circle_outline),
                                                              onPressed: () {
                                                                var ourTradesCopy =
                                                                    List<ClothingInfo>.from(chat
                                                                        .trades!
                                                                        .ourTrades);

                                                                ourTradesCopy
                                                                    .removeAt(
                                                                        index);
                                                                chat.trades = MatchedClothing(
                                                                    chat.trades!
                                                                        .othersTrades,
                                                                    ourTradesCopy);
                                                                if (ourTradesCopy
                                                                    .isEmpty) {
                                                                  Navigator.pop(
                                                                      context);
                                                                }
                                                              },
                                                            ),
                                                          );
                                                        }),
                                                  );
                                                },
                                              );
                                            }),
                                          );
                                        });
                                  }),
                              SpeedDialChild(
                                  child: const Icon(Icons.manage_accounts),
                                  label: "${chat.name}'s Proposed Listings",
                                  backgroundColor: Colors.deepOrange,
                                  labelBackgroundColor: Colors.deepOrange,
                                  onTap: () {
                                    //give user option to view other user's listings
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return StatefulBuilder(
                                            builder: (BuildContext context,
                                                StateSetter setBottomState) {
                                              return SizedBox(
                                                width: kIsWeb
                                                    ? width * 0.25
                                                    : width * 0.5,
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: min(
                                                        chat
                                                            .trades!
                                                            .othersTrades
                                                            .length,
                                                        5),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return ListTile(
                                                        tileColor:
                                                            Colors.transparent,
                                                        minLeadingWidth: 0,
                                                        title: CircleAvatar(
                                                          radius: 50,
                                                          child: ClipOval(
                                                            child: AspectRatio(
                                                              aspectRatio: 1.0,
                                                              // Ensures a 1:1 ratio
                                                              child:
                                                                  Image.memory(
                                                                chat
                                                                    .trades!
                                                                    .othersTrades[
                                                                        index]
                                                                    .images
                                                                    .first,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              );
                                            },
                                          );
                                        });
                                  }),
                              SpeedDialChild(
                                  child: const Icon(Icons.safety_check),
                                  label: "Safety Tips",
                                  backgroundColor: Colors.purple,
                                  labelBackgroundColor: Colors.purple,
                                  onTap: () {
                                    Navigator.pushNamed(context, '/settings');
                                  }),
                              SpeedDialChild(
                                  child: const Icon(Icons.report),
                                  label: "Report User",
                                  backgroundColor: Colors.red,
                                  labelBackgroundColor: Colors.red,
                                  onTap: () {
                                    _showReportDialog(
                                        context, chat.otherUserId);
                                  }),
                              SpeedDialChild(
                                  child: const Icon(Icons.favorite),
                                  label: "Rate User",
                                  backgroundColor: Colors.pink,
                                  labelBackgroundColor: Colors.pink,
                                  onTap: () {
                                    _showRatingDialog(context);
                                  }),
                            ]),
                      ],
                    ),
                    body: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //Show listings users swiped right on separated by swap icon
                                  FlutterImageStack.widgets(
                                      showTotalCount: true,
                                      totalCount:
                                          chat.trades!.othersTrades.length,
                                      itemRadius: 70,
                                      itemCount:
                                          chat.trades!.othersTrades.isNotEmpty
                                              ? chat.trades!.othersTrades.length
                                              : _empty.length,
                                      itemBorderWidth: 3,
                                      children:
                                          chat.trades!.othersTrades.isNotEmpty
                                              ? chat.trades!.othersTrades
                                                  .take(2)
                                                  .map((item) {
                                                  return ClipOval(
                                                    child: Image.memory(
                                                      item.images.first,
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  );
                                                }).toList()
                                              : _empty),
                                  const Icon(Icons.swap_horiz, size: 30),
                                  FlutterImageStack.widgets(
                                    showTotalCount: true,
                                    totalCount: chat.trades!.ourTrades.length,
                                    itemRadius: 70,
                                    itemCount: chat.trades!.ourTrades.isNotEmpty
                                        ? chat.trades!.ourTrades.length
                                        : _empty.length,
                                    itemBorderWidth: 3,
                                    children: chat.trades!.ourTrades.isNotEmpty
                                        ? chat.trades!.ourTrades
                                            .take(2)
                                            .map((item) {
                                            return ClipOval(
                                              child: Image.memory(
                                                item.images.first,
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          }).toList()
                                        : _empty,
                                  ),
                                ],
                              ),
                            ),

                            //Used https://www.freecodecamp.org/news/build-a-chat-app-ui-with-flutter/
                            //for chat UI template, modified for our application

                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: height * 0.08),
                                child: GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                  },
                                  onLongPress: () {
                                    FocusScope.of(context).unfocus();
                                  },
                                  child: ListView.builder(
                                      itemCount: chat.messages.length,
                                      shrinkWrap: true,
                                      controller: _scroller,
                                      padding: const EdgeInsets.only(
                                          top: 10, bottom: 10),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: const EdgeInsets.only(
                                              left: 24,
                                              right: 24,
                                              top: kIsWeb ? 30 : 20,
                                              bottom: 10),
                                          //Alternate left and right for messages based
                                          //on who sent it
                                          child: Align(
                                              alignment: (chat.messages[index]
                                                          .messageType ==
                                                      "receiver"
                                                  ? Alignment.topLeft
                                                  : Alignment.topRight),
                                              child: Column(
                                                crossAxisAlignment: chat
                                                            .messages[index]
                                                            .messageType ==
                                                        "receiver"
                                                    ? CrossAxisAlignment.start
                                                    : CrossAxisAlignment.end,
                                                children: [
                                                  chat.messages[index].type ==
                                                          "message"
                                                      ? Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            color: Provider.of<ThemeSwitcher>(
                                                                            context)
                                                                        .themeData ==
                                                                    lightTheme
                                                                ? (chat.messages[index].messageType ==
                                                                        "receiver"
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .blue)
                                                                : (chat.messages[index].messageType ==
                                                                        "receiver"
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .purple),
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16),
                                                          child: Text(
                                                            chat.messages[index]
                                                                .messageContent,
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        15),
                                                          ))
                                                      : chat.messages[index]
                                                                  .type ==
                                                              "image"
                                                          ? SizedBox(
                                                              height: kIsWeb
                                                                  ? 300
                                                                  : 200,
                                                              width: kIsWeb
                                                                  ? 300
                                                                  : 200,
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child: kIsWeb
                                                                    //Stack overflow - "Show fullscreen image onTap in Flutter"
                                                                    //https://stackoverflow.com/questions/54055187/show-fullscreen-image-ontap-in-flutter
                                                                    ? GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          showImageViewer(
                                                                              context,
                                                                              Image.network(chat.messages[index].images!.path).image,
                                                                              swipeDismissible: true);
                                                                        },
                                                                        child: Image.network(
                                                                            chat.messages[index].images!.path,
                                                                            fit: BoxFit.cover),
                                                                      )
                                                                    : GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          showImageViewer(
                                                                              context,
                                                                              //GPT suggested using FileImage instead of Image.File
                                                                              FileImage(
                                                                                File(chat.messages[index].images!.path),
                                                                              ),
                                                                              swipeDismissible: true);
                                                                        },
                                                                        child: Image.file(
                                                                            File(chat.messages[index].images!.path),
                                                                            fit: BoxFit.cover),
                                                                      ),
                                                              ),
                                                            )
                                                          : SizedBox(
                                                              height: kIsWeb
                                                                  ? 300
                                                                  : 200,
                                                              width: kIsWeb
                                                                  ? 300
                                                                  : 200,
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child: kIsWeb
                                                                    //Stack overflow - "Show fullscreen image onTap in Flutter"
                                                                    //https://stackoverflow.com/questions/54055187/show-fullscreen-image-ontap-in-flutter
                                                                    ? GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          showImageViewer(
                                                                              context,
                                                                              chat.messages[index].additionalListings!,
                                                                              swipeDismissible: true);
                                                                        },
                                                                        child: Image(
                                                                            image:
                                                                                chat.messages[index].additionalListings!,
                                                                            fit: BoxFit.cover),
                                                                      )
                                                                    : GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          showImageViewer(
                                                                              context,
                                                                              chat.messages[index].additionalListings!,
                                                                              swipeDismissible: true);
                                                                        },
                                                                        child: Image(
                                                                            image:
                                                                                chat.messages[index].additionalListings!,
                                                                            fit: BoxFit.cover),
                                                                      ),
                                                              ),
                                                            ),
                                                  const SizedBox(height: 5),
                                                  //display trades - handle accept/decline
                                                  chat.messages[index]
                                                              .messageType ==
                                                          "receiver"
                                                      ? Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Visibility(
                                                                  visible: chat
                                                                          .messages[
                                                                              index]
                                                                          .type !=
                                                                      "listing",
                                                                  child: Text(
                                                                    chat
                                                                        .messages[
                                                                            index]
                                                                        .time,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            10),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              20),
                                                                  child:
                                                                      Visibility(
                                                                    visible: chat
                                                                            .messages[index]
                                                                            .type ==
                                                                        "listing",
                                                                    child: const Text(
                                                                        "Accept item into trade?"),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              80),
                                                                  child:
                                                                      Visibility(
                                                                    visible: chat
                                                                            .messages[index]
                                                                            .type ==
                                                                        "listing",
                                                                    //https://pub.dev/packages/like_button
                                                                    //Inspired by like button example, used throughout
                                                                    child:
                                                                        LikeButton(
                                                                      size: 20,
                                                                      isLiked: chat
                                                                          .messages[
                                                                              index]
                                                                          .accepted,
                                                                      likeCountPadding:
                                                                          const EdgeInsets
                                                                              .all(
                                                                              10),
                                                                      likeBuilder:
                                                                          (isLiked) {
                                                                        final colour = isLiked
                                                                            ? Colors.greenAccent
                                                                            : null;
                                                                        return Icon(
                                                                            Icons
                                                                                .check_circle_outline,
                                                                            color:
                                                                                colour);
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                                Visibility(
                                                                  visible: chat
                                                                          .messages[
                                                                              index]
                                                                          .type ==
                                                                      "listing",
                                                                  child:
                                                                      LikeButton(
                                                                    size: 20,
                                                                    isLiked: chat
                                                                        .messages[
                                                                            index]
                                                                        .declined,
                                                                    likeCountPadding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                    likeBuilder:
                                                                        (isLiked) {
                                                                      final colour = isLiked
                                                                          ? Colors
                                                                              .red
                                                                          : null;
                                                                      return Icon(
                                                                          Icons
                                                                              .remove_circle_outline,
                                                                          color:
                                                                              colour);
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        )
                                                      : Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              20),
                                                                  child:
                                                                      Visibility(
                                                                    visible: chat
                                                                            .messages[index]
                                                                            .type ==
                                                                        "listing",
                                                                    child: const Text(
                                                                        "Accept item into trade?"),
                                                                  ),
                                                                ),
                                                                Visibility(
                                                                  visible: chat
                                                                          .messages[
                                                                              index]
                                                                          .type !=
                                                                      "listing",
                                                                  child: Text(
                                                                    chat
                                                                        .messages[
                                                                            index]
                                                                        .time,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            10),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Visibility(
                                                                  visible: chat
                                                                          .messages[
                                                                              index]
                                                                          .type ==
                                                                      "listing",
                                                                  child:
                                                                      LikeButton(
                                                                    size: 20,
                                                                    isLiked: chat
                                                                        .messages[
                                                                            index]
                                                                        .accepted,
                                                                    likeCountPadding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                    likeBuilder:
                                                                        (isLiked) {
                                                                      final colour = isLiked
                                                                          ? Theme.of(context)
                                                                              .hoverColor
                                                                          : null;
                                                                      return Icon(
                                                                          Icons
                                                                              .check_circle_outline,
                                                                          color:
                                                                              colour);
                                                                    },
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      right: kIsWeb
                                                                          ? 60
                                                                          : 50),
                                                                  child:
                                                                      Visibility(
                                                                    visible: chat
                                                                            .messages[index]
                                                                            .type ==
                                                                        "listing",
                                                                    child:
                                                                        LikeButton(
                                                                      size: 20,
                                                                      isLiked: chat
                                                                          .messages[
                                                                              index]
                                                                          .declined,
                                                                      likeCountPadding:
                                                                          const EdgeInsets
                                                                              .all(
                                                                              10),
                                                                      likeBuilder:
                                                                          (isLiked) {
                                                                        final colour = isLiked
                                                                            ? Colors.red
                                                                            : null;
                                                                        return Icon(
                                                                            Icons
                                                                                .remove_circle_outline,
                                                                            color:
                                                                                colour);
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        )
                                                ],
                                              )),
                                        );
                                      }),
                                ),
                              ),
                            ),
                          ],
                        ),
                        //End code retrieved from
                        //https://www.freecodecamp.org/news/build-a-chat-app-ui-with-flutter/
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 10, left: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: IconButton(
                                        icon: const Icon(Icons.image),
                                        iconSize: 25,
                                        onPressed: () async {
                                          XFile? image = await photoOptionModal(
                                              context, _picker, 50, null, null);

                                          _image = image;
                                          _handleImage(
                                              _image!, chatManager, chat);
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                      left: 10,
                                      right: 10,
                                      child: SizedBox(
                                        height: kIsWeb
                                            ? height * 0.075
                                            : height * 0.055,
                                        width: width * 0.8,
                                        child: TextField(
                                          focusNode: myFocusNode,
                                          onSubmitted: (text) {
                                            _handleSend(_sendText.text,
                                                chatManager, chat);
                                          },
                                          onTap: () {},
                                          textAlignVertical:
                                              TextAlignVertical.top,
                                          controller: _sendText,
                                          decoration: InputDecoration(
                                            //fill color from GPT
                                            fillColor:
                                                Theme.of(context).primaryColor,
                                            //contentPadding from GPT
                                            contentPadding: kIsWeb
                                                ? const EdgeInsets.all(20.0)
                                                : const EdgeInsets.only(
                                                    top: 10, left: 10),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            hintText: 'Aa',
                                            filled: true,
                                            suffix: IconButton(
                                              icon: const Icon(Icons.send,
                                                  size: kIsWeb ? 24 : 18),
                                              onPressed: () {
                                                //Idea from GPT to user _handleSend (onPressed/submitted)
                                                //to handle both keyboard enter and send icon press
                                                _handleSend(_sendText.text,
                                                    chatManager, chat);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          );
        }));
  }
}
