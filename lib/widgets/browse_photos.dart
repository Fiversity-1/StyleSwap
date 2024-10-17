import 'package:clothing_swap/features/messaging/domain/chat_listing_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';
import 'package:swipe/swipe.dart';

//Widget handles user swiping through photos on profile and clothing_detail pgs
//For example personal profile shows different icons than public, etc
class BrowsePhoto extends StatefulWidget {
  const BrowsePhoto(
      {super.key,
      required this.title,
      required this.gridIndex,
      this.photoListings});
  final List<ImageProvider>? photoListings;
  //personal
  //public
  //clothing detail
  final String title;
  final int gridIndex;
  @override
  State<BrowsePhoto> createState() => _BrowsePhotoState();
}

class _BrowsePhotoState extends State<BrowsePhoto> {
//https://medium.com/@kavyamistry0612/building-interactive-user-interfaces-with-alert-dialogs-in-flutter-81e268fb72f0
//Template used throughout app for creating dialog boxes in flutter
//Dialog used to confirm decision to include trade proposal in chat
  void _showAlertDialogProposeTrade(BuildContext context, chatManager, chat) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Text('Propose Trade'),
          content: const Text(
              'Would you like to add this item to the proposed trade?'),
          actions: [
            TextButton(
              onPressed: () {
                chatManager.addChatMessage(
                    chat!.id,
                    ChatMessage(
                        senderUserId: chat.currentUserId,
                        receiverUserId: chat.otherUserId,
                        messageContent: "New trade proposed",
                        messageType: "sender",
                        time: "5:45pm",
                        additionalListings:
                            widget.photoListings![widget.gridIndex],
                        type: "listing",
                        accepted: false,
                        declined: false));
                Navigator.pushNamedAndRemoveUntil(
                  // ignore: use_build_context_synchronously
                  context,
                  '/chat',
                  ModalRoute.withName('/message'),
                );
              },
              //GPT used for styling button
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white // Set the text color here
                  ),
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              //GPT used for styling button
              style: TextButton.styleFrom(
                  foregroundColor: Colors.white // Set the text color here
                  ),
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
  //Rowan implement this please
  //Dialog box when max of 3 items in trades exceeded
  // void _showAlertDialogMaxTrade(
  //   BuildContext context,
  // ) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         backgroundColor: Colors.blue,
  //         title: const Text('Oops'),
  //         content:
  //             const Text('Sorry there is a max of 3 items per proposed trade.'),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             //Gpt for styling button
  //             style: TextButton.styleFrom(
  //                 foregroundColor: Colors.white // Set the text color here
  //                 ),
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final chatManager = Provider.of<ChatManager>(context);
    final chat = chatManager.selectedChat;
    double height = MediaQuery.of(context).size.height;
    PageController pageController;
    return Scaffold(
      //Close image on swipe up/down
      body: Swipe(
          onSwipeDown: () {
            Navigator.pop(context);
          },
          onSwipeUp: () {
            Navigator.pop(context);
          },
          child: Stack(
            children: [
              PhotoViewGallery.builder(
                itemCount: widget.photoListings!.length,
                builder: (context, index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: widget.photoListings![index],
                    minScale: PhotoViewComputedScale.contained * 0.8,
                    maxScale: PhotoViewComputedScale.covered * 2,
                  );
                },
                pageController: pageController =
                    PageController(initialPage: widget.gridIndex),
                scrollPhysics: const BouncingScrollPhysics(),
                enableRotation: true,
              ),
              Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        //On profile page show info icon and close icon
                        //Info for personal show listing stats=
                        visible: widget.title != "details",
                        child: widget.title == "personal" ?
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: kIsWeb ? 7.5 : 25, left: 5),
                              child: IconButton(
                                  icon: const Icon(
                                    Icons.info,
                                  ),
                                  iconSize: 25,
                                  onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return const Wrap(
                                              children: [
                                                ListTile(
                                                  tileColor: Colors.transparent,
                                                  leading:
                                                      Icon(Icons.date_range),
                                                  title: Text('Date Listed:'),
                                                  subtitle: Text('25/10/2024'),
                                                ),
                                                ListTile(
                                                    tileColor:
                                                        Colors.transparent,
                                                    leading: Icon(Icons.people),
                                                    title: Text('Views'),
                                                    subtitle: Text("15")),
                                                ListTile(
                                                  tileColor: Colors.transparent,
                                                  leading:
                                                      Icon(Icons.swap_horiz),
                                                  title:
                                                      Text('Interested People'),
                                                  subtitle: Text("8"),
                                                ),
                                              ],
                                            );
                                          });
                                  }),
                            ) :
                            //Public page provides trading option -> based on
                            //last chat opened.
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: kIsWeb ? 7.5 : 25),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.swap_horiz,
                                  ),
                                  iconSize: 25,
                                  onPressed: () {
                                    _showAlertDialogProposeTrade(
                                        context, chatManager, chat);
                                  },
                                ),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: kIsWeb ? 7.5 : 25, left: 5),
                        child: IconButton(
                            icon: const Icon(
                              Icons.close,
                            ),
                            iconSize: 25,
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ),
                    ]
                  ),
                ),
                SizedBox(height: height * 0.4),
                //For the web have arrow buttons. Buttons animate to start/end
                //when max/min page reached
                Visibility(
                    visible: kIsWeb,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: ElevatedButton(
                              child: const Icon(
                                Icons.arrow_back,
                                size: 35,
                              ),
                              onPressed: () {
                                if (pageController.page == 0) {
                                  pageController.animateToPage(
                                      widget.photoListings!.length - 1,
                                      duration:
                                          const Duration(milliseconds: 1000),
                                      curve: Curves.easeInOut);
                                } else {
                                  pageController.previousPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                }
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 50),
                          child: ElevatedButton(
                              child: const Icon(
                                Icons.arrow_forward,
                                size: 35,
                              ),
                              onPressed: () {
                                if (pageController.page ==
                                    widget.photoListings!.length - 1) {
                                  pageController.animateToPage(0,
                                      duration:
                                          const Duration(milliseconds: 1000),
                                      curve: Curves.easeInOut);
                                } else {
                                  pageController.nextPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                }
                              }),
                        ),
                      ],
                    ))
              ])
            ],
          )),
    );
  }
}
