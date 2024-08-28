// signup.dart

import 'dart:io';
import 'package:clothing_swap/features/messaging/chat_listing_class.dart';
import 'package:clothing_swap/features/profile/presentation/profile_class.dart';
import 'package:clothing_swap/theme/theme.dart';
import 'package:clothing_swap/theme/theme_switcher.dart';
import 'package:clothing_swap/widgets/photo_modal.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:image_picker/image_picker.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class MessageChat extends StatefulWidget {
  const MessageChat({super.key, required this.title});

  final String title;
  @override
  State<MessageChat> createState() => _MessageChatState();
}

class _MessageChatState extends State<MessageChat> {
  final _sendText = TextEditingController();
  final _scroller = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // You can use didChangeDependencies to restore scroll position if necessary
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scroller.animateTo(_scroller.position.maxScrollExtent + 500,
          curve: Curves.easeOut, duration: const Duration(milliseconds: 500));
    });
  }

//Void function idea to handle  both onSubmitted: and onPressed (icon) from chatGPT
//code modified for personal implementation
  void _handleSend(String value) {
    setState(() => _sendText.text.isNotEmpty
        ? messages.add(ChatMessage(
            messageContent: _sendText.text,
            messageType: "sender",
            time: "5:45pm",
            type: "message"))
        : null);
    _sendText.clear();
    _scroller.animateTo(
      _scroller.position.maxScrollExtent + 100,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
    );
    myFocusNode.requestFocus();
    // //ChatGpt to unfocus keyboard
    // FocusScope.of(context).unfocus();
  }

  void _handleImage(XFile image) {
    setState(() => messages.add(ChatMessage(
        messageContent: "",
        messageType: "sender",
        time: "5:45pm",
        images: image,
        type: "image")));
    _scroller.animateTo(
      //scroll image size
      _scroller.position.maxScrollExtent + 350,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
    );
  }

//Chat modified
  void _handleTrade(String type, int index) async {
    setState(() {
      if (type == "accepted") {
        if (messages[index].accepted != null) {
          messages[index].accepted = !messages[index].accepted!;
        }

        if (messages[index].declined == true) {
          messages[index].declined = false;
        }
      } else {
        if (messages[index].declined != null) {
          messages[index].declined = !messages[index].declined!;
        }

        if (messages[index].accepted == true) {
          messages[index].accepted = false;
        }
      }
      //Now add/remove image right or left
      if (messages[index].accepted != null) {
        if (messages[index].accepted == true) {
          if (messages[index].messageType == "sender") {
            _imagesRight.add(
              ClipOval(
                child: Image(
                  image: messages[index].additionalListings!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            );
          } else {
            _imagesLeft.add(
              ClipOval(
                child: Image(
                  image: messages[index].additionalListings!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }
        }
      }
      if (messages[index].declined != null) {
        if (messages[index].declined == true ||
            messages[index].accepted == false) {
          if (messages[index].messageType == "sender") {
            _imagesRight.removeLast();
          } else {
            _imagesLeft.removeLast();
          }
        }
      }
    });
  }

  //https://pub.dev/packages/flutter_image_stack
  final List<Widget> _imagesLeft = [
    ClipOval(
      child: Image.asset(
        'lib/images/1.jpg',
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    ),
    ClipOval(
      child: Image.asset(
        'lib/images/5.jpg',
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    ),
  ];

  final List<Widget> _imagesRight = [
    ClipOval(
      child: Image.asset(
        'lib/images/2.jpg',
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    ),
    ClipOval(
      child: Image.asset(
        'lib/images/3.jpg',
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    ),
    ClipOval(
      child: Image.asset(
        'lib/images/4.jpg',
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
    ),
  ];

  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  final FocusNode myFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomTopAppBar(),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: (10.0), top: 5, bottom: 5),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      iconSize: 25,
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/message');
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/public_profile');
                      },
                      child: CircleAvatar(
                        radius: 18,
                        backgroundImage: publicProfileExample.profilePicture,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: (15), top: 5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/public_profile');
                      },
                      child: Text(publicProfileExample.name,
                          style: Theme.of(context).textTheme.headlineMedium,
                          textAlign: TextAlign.center),
                    ),
                  ),
                ],
              ),

              //https://www.freecodecamp.org/news/build-a-chat-app-ui-with-flutter/ retrieved from the following URL but modified for our application

              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: height * 0.074),
                  child: ListView.builder(
                      //item count + 1 from chatgpt
                      itemCount: messages.length + 1,
                      shrinkWrap: true,
                      controller: _scroller,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      itemBuilder: (context, index) {
                        //Chat Gpt code - the idea to include the picture in the list view
                        //and to increase index

                        if (index == 0) {
                          // Return the image as the first item
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: (BuildContext context,
                                              StateSetter
                                                  setState /*You can rename this!*/) {
                                            return ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: _imagesLeft.length,
                                                itemBuilder: (context, index) {
                                                  return ListTile(
                                                    minLeadingWidth: 150,
                                                    minTileHeight: 150,
                                                    leading: Text(
                                                        "Your item $index"),
                                                    trailing: IconButton(
                                                      icon: const Icon(Icons
                                                          .remove_circle_outline),
                                                      onPressed: () {
                                                        setState(() {
                                                          _imagesLeft
                                                              .removeAt(index);
                                                          if (_imagesLeft
                                                              .isEmpty) {
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        });
                                                      },
                                                    ),
                                                    title: _imagesLeft[index],
                                                  );
                                                });
                                          },
                                        );
                                      });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FlutterImageStack.widgets(
                                      showTotalCount: true,
                                      totalCount: _imagesLeft.length,
                                      itemRadius: 70, // Radius of each images
                                      itemCount: _imagesLeft
                                          .length, // Maximum number of images to be shown in stack
                                      itemBorderWidth: 3,
                                      children:
                                          _imagesLeft, // Border width around the images
                                    ),
                                    const Icon(Icons.swap_horiz, size: 30),
                                    FlutterImageStack.widgets(
                                      showTotalCount: true,
                                      totalCount: _imagesRight.length,
                                      itemRadius: 70, // Radius of each images
                                      itemCount: _imagesRight
                                          .length, // Maximum number of images to be shown in stack
                                      itemBorderWidth: 3,
                                      children:
                                          _imagesRight, // Border width around the images
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        } else {
                          //End chat GPT code
                          return Container(
                            padding: const EdgeInsets.only(
                                left: 24,
                                right: 24,
                                top: kIsWeb ? 30 : 20,
                                bottom: 10),
                            child: Align(
                                alignment: (messages[index - 1].messageType ==
                                        "receiver"
                                    ? Alignment.topLeft
                                    : Alignment.topRight),
                                child: Column(
                                  crossAxisAlignment:
                                      messages[index - 1].messageType ==
                                              "receiver"
                                          ? CrossAxisAlignment.start
                                          : CrossAxisAlignment.end,
                                  children: [
                                    messages[index - 1].type == "message"
                                        ? Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Provider.of<ThemeSwitcher>(
                                                              context)
                                                          .themeData ==
                                                      lightTheme
                                                  ? (messages[index - 1]
                                                              .messageType ==
                                                          "receiver"
                                                      ? Colors.green
                                                      : Colors.blue)
                                                  : (messages[index - 1]
                                                              .messageType ==
                                                          "receiver"
                                                      ? Colors.purple
                                                      : Colors.blue),
                                            ),
                                            padding: const EdgeInsets.all(16),
                                            child: Text(
                                              messages[index - 1]
                                                  .messageContent,
                                              style:
                                                  const TextStyle(fontSize: 15),
                                            ))
                                        : messages[index - 1].type == "image"
                                            ? SizedBox(
                                                height: kIsWeb ? 300 : 200,
                                                width: kIsWeb ? 300 : 200,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: kIsWeb
                                                      //Stack overflow - "Show fullscreen image onTap in Flutter"
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            showImageViewer(
                                                                context,
                                                                Image.network(messages[
                                                                            index -
                                                                                1]
                                                                        .images!
                                                                        .path)
                                                                    .image,
                                                                swipeDismissible:
                                                                    true);
                                                          },
                                                          child: Image.network(
                                                              messages[
                                                                      index - 1]
                                                                  .images!
                                                                  .path,
                                                              fit:
                                                                  BoxFit.cover),
                                                        )
                                                      : GestureDetector(
                                                          onTap: () {
                                                            showImageViewer(
                                                                context,
                                                                //ChatGPT suggested using FileImage instead of Image.File
                                                                FileImage(
                                                                  File(messages[
                                                                          index -
                                                                              1]
                                                                      .images!
                                                                      .path),
                                                                ),
                                                                swipeDismissible:
                                                                    true);
                                                          },
                                                          child: Image.file(
                                                              File(messages[
                                                                      index - 1]
                                                                  .images!
                                                                  .path),
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                ),
                                              )
                                            : SizedBox(
                                                height: kIsWeb ? 300 : 200,
                                                width: kIsWeb ? 300 : 200,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: kIsWeb
                                                      //Stack overflow - "Show fullscreen image onTap in Flutter"
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            showImageViewer(
                                                                context,
                                                                messages[index -
                                                                        1]
                                                                    .additionalListings!,
                                                                swipeDismissible:
                                                                    true);
                                                          },
                                                          child: Image(
                                                              image: messages[
                                                                      index - 1]
                                                                  .additionalListings!,
                                                              fit:
                                                                  BoxFit.cover),
                                                        )
                                                      : GestureDetector(
                                                          onTap: () {
                                                            showImageViewer(
                                                                context,
                                                                messages[index -
                                                                        1]
                                                                    .additionalListings!,
                                                                swipeDismissible:
                                                                    true);
                                                          },
                                                          child: Image(
                                                              image: messages[
                                                                      index - 1]
                                                                  .additionalListings!,
                                                              fit:
                                                                  BoxFit.cover),

                                                          // Handle tap event
                                                        ),
                                                ),
                                              ),
                                    const SizedBox(height: 5),
                                    messages[index - 1].messageType ==
                                            "receiver"
                                        ? Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Visibility(
                                                    visible: messages[index - 1]
                                                            .type !=
                                                        "listing",
                                                    child: Text(
                                                      messages[index - 1].time,
                                                      style: const TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20),
                                                    child: Visibility(
                                                      visible:
                                                          messages[index - 1]
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
                                                        const EdgeInsets.only(
                                                            left: 80),
                                                    child: Visibility(
                                                      visible:
                                                          messages[index - 1]
                                                                  .type ==
                                                              "listing",
                                                      child: LikeButton(
                                                        size: 20,
                                                        isLiked:
                                                            messages[index - 1]
                                                                .accepted,
                                                        onTap: (isLiked) async {
                                                          _handleTrade(
                                                              "accepted",
                                                              index - 1);

                                                          return messages[
                                                                  index - 1]
                                                              .accepted;
                                                        },
                                                        likeCountPadding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        likeBuilder: (isLiked) {
                                                          final colour = isLiked
                                                              ? Theme.of(
                                                                      context)
                                                                  .hoverColor
                                                              : null;
                                                          return Icon(
                                                              Icons
                                                                  .check_circle_outline,
                                                              color: colour);
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: messages[index - 1]
                                                            .type ==
                                                        "listing",
                                                    child: LikeButton(
                                                      size: 20,
                                                      isLiked:
                                                          messages[index - 1]
                                                              .declined,
                                                      onTap: (isLiked) async {
                                                        _handleTrade("declined",
                                                            index - 1);

                                                        return messages[
                                                                index - 1]
                                                            .declined;
                                                      },
                                                      likeCountPadding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      likeBuilder: (isLiked) {
                                                        final colour = isLiked
                                                            ? Colors.red
                                                            : null;
                                                        return Icon(
                                                            Icons
                                                                .remove_circle_outline,
                                                            color: colour);
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
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 20),
                                                    child: Visibility(
                                                      visible:
                                                          messages[index - 1]
                                                                  .type ==
                                                              "listing",
                                                      child: const Text(
                                                          "Accept item into trade?"),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: messages[index - 1]
                                                            .type !=
                                                        "listing",
                                                    child: Text(
                                                      messages[index - 1].time,
                                                      style: const TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Visibility(
                                                    visible: messages[index - 1]
                                                            .type ==
                                                        "listing",
                                                    child: LikeButton(
                                                      size: 20,
                                                      isLiked:
                                                          messages[index - 1]
                                                              .accepted,
                                                      onTap: (isLiked) async {
                                                        _handleTrade("accepted",
                                                            index - 1);

                                                        return messages[
                                                                index - 1]
                                                            .accepted;
                                                      },
                                                      likeCountPadding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      likeBuilder: (isLiked) {
                                                        final colour = isLiked
                                                            ? Theme.of(context)
                                                                .hoverColor
                                                            : null;
                                                        return Icon(
                                                            Icons
                                                                .check_circle_outline,
                                                            color: colour);
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: kIsWeb
                                                                ? 60
                                                                : 50),
                                                    child: Visibility(
                                                      visible:
                                                          messages[index - 1]
                                                                  .type ==
                                                              "listing",
                                                      child: LikeButton(
                                                        size: 20,
                                                        isLiked:
                                                            messages[index - 1]
                                                                .declined,
                                                        onTap: (isLiked) async {
                                                          _handleTrade(
                                                              "declined",
                                                              index - 1);

                                                          return messages[
                                                                  index - 1]
                                                              .declined;
                                                        },
                                                        likeCountPadding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        likeBuilder: (isLiked) {
                                                          final colour = isLiked
                                                              ? Colors.red
                                                              : null;
                                                          return Icon(
                                                              Icons
                                                                  .remove_circle_outline,
                                                              color: colour);
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
                        }
                      }),
                ),
              ),
            ],
          ),
          //End code retrieved
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, left: 10),
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
                            _handleImage(_image!);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SizedBox(
                          height: kIsWeb ? height * 0.075 : height * 0.055,
                          width: width * 0.8,
                          child: TextField(
                            focusNode: myFocusNode,
                            onSubmitted: _handleSend,
                            onTap: () {},
                            textAlignVertical: TextAlignVertical.top,
                            controller: _sendText,
                            decoration: InputDecoration(
                              //contentPadding from chatgpt
                              contentPadding: kIsWeb
                                  ? const EdgeInsets.all(20.0)
                                  : const EdgeInsets.only(top: 10, left: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              hintText: 'Aa',
                              filled: true,
                              suffix: IconButton(
                                icon: const Icon(Icons.send,
                                    size: kIsWeb ? 24 : 18),
                                onPressed: () {
                                  //Idea from chatgpt to handle both enter and icon
                                  _handleSend(_sendText.text);
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
    );
  }
}
