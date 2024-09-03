import 'package:clothing_swap/features/clothing/presentation/search_provider.dart';
import 'package:clothing_swap/features/profile/presentation/profile_class.dart';
import 'package:clothing_swap/widgets/browse_photos.dart';
import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';

class ClothingDetail extends StatelessWidget {
  const ClothingDetail({super.key});
  //Need a matching algorithm - based on preferences/ latest search

  @override
  Widget build(BuildContext context) {
    final searchResults = Provider.of<Search>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomTopAppBar(),
      ),
      bottomNavigationBar: const CustomBottomNavBar(
        currentIndex: 1,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: (0.0)),
                  child: IconButton(
                      icon: const Icon(
                          kIsWeb ? Icons.arrow_upward : Icons.swipe_down),
                      iconSize: kIsWeb ? 35 : 30,
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ),
              ],
            ),
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
                  title: Text(
                    searchResults.getListing().toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  subtitle: Text(
                    searchResults.getListing()[0].item.details.type,
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
                    searchResults.getListing()[0].item.details.size.toString(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  leading: const Icon(Icons.numbers),
                ),
                ListTile(
                    selected: true,
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
                    trailing: const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    )),
                ListTile(
                    selected: true,
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
                    trailing: const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    )),
                ListTile(
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
                ),
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
    );
  }
}
