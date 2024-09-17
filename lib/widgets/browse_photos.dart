import 'package:clothing_swap/features/messaging/chat_listing_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:provider/provider.dart';
import 'package:swipe/swipe.dart';

class BrowsePhoto extends StatefulWidget {
  const BrowsePhoto(
      {super.key,
      required this.title,
      required this.gridIndex,
      this.photoListings});
  final List<ImageProvider>? photoListings;
  final String title;
  //personal
  //public
  //clothing detail
  final int gridIndex;
  @override
  State<BrowsePhoto> createState() => _BrowsePhotoState();
}

class _BrowsePhotoState extends State<BrowsePhoto> {
//List generate line from chatgpt

  @override
  Widget build(BuildContext context) {
    final chatManager = Provider.of<ChatManager>(context);
    final chat = chatManager.selectedChat;
    double height = MediaQuery.of(context).size.height;
    PageController pageController;
    return Scaffold(
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
                        visible: widget.title != "details",
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: kIsWeb ? 7.5 : 25, left: 5),
                              child: IconButton(
                                  icon: const Icon(
                                    Icons.info,
                                  ),
                                  iconSize: 25,
                                  onPressed: () {
                                    if (widget.title == "personal") {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return const Wrap(
                                              children: [
                                                ListTile(
                                                  tileColor: Colors.blue,
                                                  leading:
                                                      Icon(Icons.date_range),
                                                  title: Text('Date Listed:'),
                                                  subtitle: Text('27/08/2024'),
                                                ),
                                                ListTile(
                                                    tileColor: Colors.blue,
                                                    leading: Icon(Icons.people),
                                                    title: Text('Views'),
                                                    subtitle: Text("15")),
                                                ListTile(
                                                  tileColor: Colors.blue,
                                                  leading:
                                                      Icon(Icons.swap_horiz),
                                                  title:
                                                      Text('Interested People'),
                                                  subtitle: Text("15"),
                                                ),
                                              ],
                                            );
                                          });
                                    } else if (widget.title == "public") {
                                      Navigator.pushNamed(
                                          context, '/clothing_detail');
                                    } else if (widget.title == "details") {
                                      Navigator.pushNamed(
                                          context, '/clothing_detail');
                                    }
                                  }),
                            ),
                            Visibility(
                              visible: widget.title == "public",
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: kIsWeb ? 7.5 : 25),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.swap_horiz,
                                  ),
                                  iconSize: 25,
                                  onPressed: () async {
                                    if (await confirm(
                                      context,
                                      title: const Text('Trade'),
                                      content: const Text(
                                          'Would you like to propose a trade on this item as well?'),
                                      textCancel: Text('No',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
                                      textOK: Text('Yes',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
                                    )) {
                                      chatManager.addChatMessage(
                                          chat!.id,
                                          ChatMessage(
                                              senderUserId: chat.currentUserId,
                                              receiverUserId: chat.otherUserId,
                                              messageContent:
                                                  "New trade proposed",
                                              messageType: "sender",
                                              time: "5:45pm",
                                              additionalListings:
                                                  widget.photoListings![
                                                      widget.gridIndex],
                                              type: "listing",
                                              accepted: false,
                                              declined: false));
                                      Navigator.pushNamed(
                                        // ignore: use_build_context_synchronously
                                        context,
                                        '/chat',
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
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
                    ],
                  ),
                ),
                SizedBox(height: height * 0.4),
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
