// profile.dart

import 'package:clothing_swap/features/messaging/chat_listing_class.dart';
import 'package:clothing_swap/features/profile/presentation/profile_class.dart';

import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:image_picker/image_picker.dart';

import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:photo_view/photo_view_gallery.dart';

class PublicProfile extends StatefulWidget {
  const PublicProfile({super.key});

  @override
  State<PublicProfile> createState() => _PublicProfileState();
}

class _PublicProfileState extends State<PublicProfile> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    PageController _pageController;
    return Scaffold(
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 3,
      ),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomTopAppBar(),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 5),
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: CircleAvatar(
                          radius: 75,
                          backgroundImage: publicProfileExample.profilePicture),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
                width: 375,
                child: Text(
                  publicProfileExample.name,
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 75,
                        width: 300,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Theme.of(context).highlightColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          personalProfileExample.bio,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ),
                    ],
                  )),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: kIsWeb ? 3 : 2,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
                itemBuilder: (_, index) => GridTile(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        //PhotoViewGallery Code from pubdev photo_view modified with ChatGPT to stack icon on top
                        MaterialPageRoute(
                            builder: (context) => Scaffold(
                                    body: Stack(
                                  children: [
                                    PhotoViewGallery.builder(
                                      itemCount: publicProfileExample
                                          .personalListings!.length,
                                      builder: (context, index) {
                                        return PhotoViewGalleryPageOptions(
                                          imageProvider: publicProfileExample
                                              .personalListings![index],
                                          minScale:
                                              PhotoViewComputedScale.contained *
                                                  0.8,
                                          maxScale:
                                              PhotoViewComputedScale.covered *
                                                  2,
                                        );
                                      },
                                      pageController: _pageController =
                                          PageController(initialPage: index),
                                      scrollPhysics:
                                          const BouncingScrollPhysics(),
                                      enableRotation: true,
                                    ),
                                    Column(children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 7.5, left: 5),
                                                  child: IconButton(
                                                      icon: const Icon(
                                                        Icons.info,
                                                      ),
                                                      iconSize: 25,
                                                      onPressed: () {
                                                        Navigator.pushNamed(
                                                            context,
                                                            '/clothing_detail');
                                                      }),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 7.5),
                                                  child: IconButton(
                                                    icon: const Icon(
                                                      Icons.swap_horiz,
                                                    ),
                                                    iconSize: 25,
                                                    onPressed: () async {
                                                      if (await confirm(
                                                        context,
                                                        title:
                                                            const Text('Trade'),
                                                        content: const Text(
                                                            'Would you like to propose a trade on this item as well?'),
                                                        textCancel: Text('No',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge),
                                                        textOK: Text('Yes',
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyLarge),
                                                      )) {
                                                        Navigator.pushNamed(
                                                            // ignore: use_build_context_synchronously
                                                            context,
                                                            '/chat');

                                                        setState(() {
                                                          messages.add(ChatMessage(
                                                              messageContent:
                                                                  "",
                                                              messageType:
                                                                  "sender",
                                                              time: "5:45pm",
                                                              images: publicProfileExample
                                                                      .personalListings![
                                                                  _pageController
                                                                          .page
                                                                      as int]);
                                                        });
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 5.0, left: 5),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 50),
                                                child: ElevatedButton(
                                                    child: const Icon(
                                                      Icons.arrow_back,
                                                      size: 35,
                                                    ),
                                                    onPressed: () {
                                                      _pageController.previousPage(
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      500),
                                                          curve:
                                                              Curves.easeInOut);
                                                    }),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 50),
                                                child: ElevatedButton(
                                                    child: const Icon(
                                                      Icons.arrow_forward,
                                                      size: 35,
                                                    ),
                                                    onPressed: () {
                                                      _pageController.nextPage(
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      500),
                                                          curve:
                                                              Curves.easeInOut);
                                                    }),
                                              ),
                                            ],
                                          ))
                                    ])
                                  ],
                                ))),
                      );
                    },
                    child: Image(
                      image: publicProfileExample.personalListings![index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                itemCount: publicProfileExample.personalListings!.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
