import 'package:clothing_swap/features/clothing/application/search_provider.dart';
import 'package:clothing_swap/features/profile/presentation/profile_class.dart';
import 'package:clothing_swap/theme/gradient.dart';
import 'package:clothing_swap/theme/theme.dart';
import 'package:clothing_swap/theme/theme_switcher.dart';
import 'package:clothing_swap/widgets/browse_photos.dart';
import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class ClothingDetail extends StatelessWidget {
  final String? location;
  const ClothingDetail({super.key, this.location});
  //Need a matching algorithm - based on preferences/ latest search

  @override
  Widget build(BuildContext context) {
    final userManager = context.watch<UserManager>();
    final preferencesNotifier = userManager.currentUser.preferences;
    final searchResults = Provider.of<Search>(context);
    //GPT for modal route to collect argument
    final String? location =
        ModalRoute.of(context)!.settings.arguments as String?;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
        body: Padding(
          padding: EdgeInsets.only(top: location == "trade" ? 0 : 15),
          child: Center(
            child: SingleChildScrollView(
              child: Column(children: [
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  children: [
                    ListTile(
                      title: Text(
                        searchResults.getListing()[0].item.details.bio,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      leading: const Icon(Icons.info),
                    ),
                    ListTile(
                        selected: preferencesNotifier
                            .getPreferences("Type")
                            .contains(searchResults
                                .getListing()[0]
                                .item
                                .details
                                .type),
                        title: Text(
                          "Type",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        subtitle: Text(
                          searchResults.getListing()[0].item.details.type,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        leading: const Icon(Icons.category),
                        trailing: preferencesNotifier
                                .getPreferences("Type")
                                .contains(searchResults
                                    .getListing()[0]
                                    .item
                                    .details
                                    .type)
                            ? const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )
                            : null),
                    ListTile(
                        selected: preferencesNotifier
                            .getPreferences("Size")
                            .contains(searchResults
                                .getListing()[0]
                                .item
                                .details
                                .size),
                        title: Text(
                          "Size",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        subtitle: Text(
                          searchResults.getListing()[0].item.details.size,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        leading: const Icon(Icons.numbers),
                        trailing: preferencesNotifier
                                .getPreferences("Size")
                                .contains(searchResults
                                    .getListing()[0]
                                    .item
                                    .details
                                    .size)
                            ? const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )
                            : null),
                    ListTile(
                        selected: preferencesNotifier
                            .getPreferences("Gender")
                            .contains(searchResults
                                .getListing()[0]
                                .item
                                .details
                                .gender),
                        title: Text(
                          "Gender",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        subtitle: Text(
                          searchResults.getListing()[0].item.details.gender,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        leading: const Icon(
                          Icons.person,
                        ),
                        trailing: preferencesNotifier
                                .getPreferences("Gender")
                                .contains(searchResults
                                    .getListing()[0]
                                    .item
                                    .details
                                    .gender)
                            ? const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )
                            : null),
                    ListTile(
                        selected: preferencesNotifier
                            .getPreferences("Condition")
                            .contains(searchResults
                                .getListing()[0]
                                .item
                                .details
                                .condition),
                        title: Text(
                          "Condition",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        subtitle: Text(
                          searchResults.getListing()[0].item.details.condition,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        leading: const Icon(
                          Icons.gpp_good_outlined,
                        ),
                        trailing: preferencesNotifier
                                .getPreferences("Condition")
                                .contains(searchResults
                                    .getListing()[0]
                                    .item
                                    .details
                                    .condition)
                            ? const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )
                            : null),
                    ListTile(
                        selected: preferencesNotifier
                            .getPreferences("Colour")
                            .contains(searchResults
                                .getListing()[0]
                                .item
                                .details
                                .colours),
                        title: Text(
                          "Colour",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        subtitle: Text(
                          searchResults
                              .getListing()[0]
                              .item
                              .details
                              .colours
                              .join(", "),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        leading: const Icon(Icons.palette),
                        trailing: preferencesNotifier
                                .getPreferences("Colour")
                                .contains(searchResults
                                    .getListing()[0]
                                    .item
                                    .details
                                    .colours)
                            ? const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )
                            : null),
                  ],
                ),
                SizedBox(height: height * 0.025, width: width),
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
                          //PhotoViewGallery Code from pubdev photo_view modified with ChatGPT to stack icon on top
                          MaterialPageRoute(
                              builder: (context) => BrowsePhoto(
                                    title: "details",
                                    gridIndex: index,
                                    photoListings: searchResults
                                        .getListing()[0]
                                        .item
                                        .details
                                        .images,
                                  )),
                        );
                      },
                      child: Image(
                          fit: BoxFit.cover,
                          image: searchResults
                              .getListing()[0]
                              .item
                              .details
                              .images[index]),
                    ),
                  ),
                  itemCount:
                      searchResults.getListing()[0].item.details.images.length,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
