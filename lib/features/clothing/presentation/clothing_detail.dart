import 'package:clothing_swap/features/clothing/application/search_provider.dart';
import 'package:clothing_swap/features/profile/presentation/profile_class.dart';
import 'package:clothing_swap/theme/gradient.dart';
import 'package:clothing_swap/theme/theme.dart';
import 'package:clothing_swap/theme/theme_switcher.dart';
import 'package:clothing_swap/widgets/browse_photos.dart';
import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

//Page for displaying clothing detail for a listing
//Page accessible from either swipe_top or public_profile when
//browsing a person's listings
class ClothingDetail extends StatelessWidget {
  final String? location;
  const ClothingDetail({super.key, this.location});

  @override
  Widget build(BuildContext context) {
    final searchResults = Provider.of<Search>(context);
    //GPT for modal route to collect argument
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
                      ? 'lib/images/hanger.png'
                      : 'lib/images/hanger_white.png',
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
                      ),),
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
                  //Colour has been modified by GPT to highlight tiles containing
                  //any colour from list of preferred colours.
                  ListTile(

                    title: Text(
                      "Colour",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    subtitle: Text(
                      searchResults
                          .getListing()[0]
                          .colours
                          .join(", "),
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
                        //modified with GPT to stack icon on top
                        //see browse_photos widget
                        MaterialPageRoute(
                            builder: (context) => BrowsePhoto(
                                  title: "details",
                                  gridIndex: index,
                                  photoListings: searchResults
                                      .getListing()[0]
                                      .images,
                                )),
                      );
                    },
                    child: Image(
                        fit: BoxFit.cover,
                        image: MemoryImage(searchResults
                            .getListing()[0]
                            .images[index])),
                  ),
                ),
                itemCount:
                    searchResults.getListing()[0].images.length,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                    onPressed: () {},
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
