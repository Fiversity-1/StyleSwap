import 'package:clothing_swap/features/clothing/application/search_provider.dart';
import 'package:clothing_swap/theme/gradient.dart';
import 'package:clothing_swap/theme/theme.dart';
import 'package:clothing_swap/theme/theme_switcher.dart';
import 'package:clothing_swap/widgets/browse_photos.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../profile/data/profile_api.dart';

//Page for displaying clothing detail for a listing
//Page accessible from either swipe_top or public_profile when
//browsing a person's listings
class ClothingDetail extends StatelessWidget {
  final String? location;

  const ClothingDetail({super.key, this.location});

//https://medium.com/@kavyamistry0612/building-interactive-user-interfaces-with-alert-dialogs-in-flutter-81e268fb72f0
//Template used throughout app for creating dialog boxes in flutter
//Dialog used to report listing and potentially block a user
  void _showAlertDialogReportListing(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Text('Report Listing'),
          content: const Text(
              'Thank you for your report. A member of our moderation team will conduct an investigation shortly.\n\nWould you like to block the user?'),
          actions: [
            TextButton(
              onPressed: () async {
                final searchResults =
                    Provider.of<Search>(context, listen: false);
                await blockUser(searchResults
                    .getListing(update: false)[0]
                    .userId); // block the user

                if (context.mounted) {
                  Navigator.of(context).pop();
                  searchResults.resetSearch();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/swipe', (route) => false);
                }
              },
              //GPT was used for the following reasons:
              //Prompt: "How to style text button in flutter"
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              //GPT was used for the following reasons:
              //Prompt: "How to style text button in flutter"
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = Provider.of<Search>(context);
    //GPT was used for the following reasons:
    //Prompt: "How to collect argument push in Navigator.pushNamed"
    final String? location =
        ModalRoute.of(context)!.settings.arguments as String?;
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        //Include appbar if the user is coming from public_page
        appBar: location == "trade"
            ? AppBar(
                title: Image.asset(
                  Provider.of<ThemeSwitcher>(context).themeData == lightTheme
                      ? 'lib/images/logo/hanger.png'
                      : 'lib/images/logo/hanger_white.png',
                  height: 65,
                  width: 75,
                ),
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/message');
                      },
                      icon: const Icon(Icons.messenger_rounded))
                ],
              )
            : null,
        bottomNavigationBar: const CustomBottomNavBar(
          currentIndex: 1,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(children: [
              //Each list tile checks user preferences, if matched
              //highlight the tile and add a star
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(16),
                children: [
                  ListTile(
                    title: Text(
                      searchResults.getListing()[0].description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    leading: const Icon(Icons.info),
                  ),
                  ListTile(
                    title: Text(
                      "Type",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    subtitle: Text(
                      searchResults.getListing()[0].type.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    leading: const Icon(Icons.category),
                  ),
                  ListTile(
                    title: Text(
                      "Size",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    subtitle: Text(
                      searchResults.getListing()[0].size.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    leading: const Icon(Icons.numbers),
                  ),
                  ListTile(
                    title: Text(
                      "Gender",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    subtitle: Text(
                      searchResults.getListing()[0].gender.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    leading: const Icon(
                      Icons.person,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Condition",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    subtitle: Text(
                      searchResults.getListing()[0].condition.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    leading: const Icon(
                      Icons.gpp_good_outlined,
                    ),
                  ),
                  //GPT was used for the following reasons:
                  //Prompt: "(Provided code) How to handle when there is a list
                  //of colours, and want it to highlight if at least 1 is present"
                  ListTile(
                    title: Text(
                      "Colour",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    subtitle: Text(
                      searchResults.getListing()[0].colours.join(", "),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    leading: const Icon(Icons.palette),
                  ),
                ],
              ),
              //Display extra images for listing
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                ),
                itemBuilder: (_, index) => GridTile(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        //PhotoViewGallery Code from pubdev photo_view https://pub.dev/packages/photo_view
                        //GPT was used for the following reasons:
                        //Prompt: "(Provided code for photo_view)How would I stack a icon on top
                        //of the photo_view package in flutter" **see browse_photo widget
                        MaterialPageRoute(
                            builder: (context) => BrowsePhoto(
                                  title: "details",
                                  gridIndex: index,
                                  photoListings: searchResults
                                      .getListing()[0]
                                      .images
                                      .map<ImageProvider<Object>>(
                                          (image) => MemoryImage(image))
                                      .toList(),
                                )),
                      );
                    },
                    child: Image(
                        fit: BoxFit.cover,
                        image: MemoryImage(
                            searchResults.getListing()[0].images[index])),
                  ),
                ),
                itemCount: searchResults.getListing()[0].images.length,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                    onPressed: () {
                      _showAlertDialogReportListing(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Report Listing')),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
