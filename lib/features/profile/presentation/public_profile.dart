// profile.dart

import 'package:clothing_swap/features/messaging/chat_listing_class.dart';
import 'package:clothing_swap/features/profile/presentation/profile_class.dart';
import 'package:clothing_swap/widgets/browse_photos.dart';

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
                  crossAxisCount: kIsWeb ? 4 : 2,
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
                            builder: (context) => BrowsePhoto(
                                  title: "public",
                                  gridIndex: index,
                                  photoListings:
                                      publicProfileExample.personalListings!,
                                )),
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
