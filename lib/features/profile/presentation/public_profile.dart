
import 'dart:io';

import 'package:clothing_swap/features/messaging/domain/chat_listing_class.dart';
import 'package:clothing_swap/features/profile/domain/profile_class.dart';
import 'package:clothing_swap/theme/gradient.dart';
import 'package:clothing_swap/theme/theme.dart';
import 'package:clothing_swap/theme/theme_switcher.dart';
import 'package:clothing_swap/widgets/browse_photos.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Public Profile
//Differences to personal: non-editable, can propose trades
class PublicProfile extends StatefulWidget {
  const PublicProfile({super.key});

  @override
  State<PublicProfile> createState() => PublicProfileState();
}

class PublicProfileState extends State<PublicProfile> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    final chatManager = Provider.of<ChatManager>(context);
    final chatUserId = chatManager.selectedChat?.otherUserId;

    return ChangeNotifierProvider(
        create: (_) => Profile(id: chatUserId!, name: "Loading...", bio: ""),
        child: Consumer<Profile>(builder: (context, profile, child)
    {
      return GradientBackground(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: const CustomBottomNavBar(
            currentIndex: 3,
          ),
          //Icon based on colour scheme
          appBar: AppBar(
            title: Image.asset(
              Provider
                  .of<ThemeSwitcher>(context)
                  .themeData == lightTheme
                  ? 'lib/images/logo/hanger.png'
                  : 'lib/images/logo/hanger_white.png',
              height: 65,
              width: 75,
            ),
            centerTitle: true,
          ),
          //GPT used for LayoutBuilder to scale grid element amount
          body: LayoutBuilder(
            builder: (context, constraints) {
              // Define grid column count based on available width
              int crossAxisCount = constraints.maxWidth > 600
                  ? 4
                  : constraints.maxWidth > 400
                  ? 2
                  : 2;
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                            child: SizedBox(
                              height: 150,
                              width: 150,
                              child: CircleAvatar(
                                  radius: 75,
                                  backgroundImage: profile.profilePicture !=
                                      null
                                      ? MemoryImage(profile.profilePicture!)
                                      : const AssetImage(
                                      'lib/images/profile/noProfilePicture.png')),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                        width: 375,
                        child: Text(
                          profile.name,
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 30),
                        child: SizedBox(
                          width: width * 0.85,
                          child: Text(
                            profile.bio,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge,
                            textAlign: TextAlign.center,
                            softWrap: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: profile.personalListings == null
                            ? const Center(child: CircularProgressIndicator(
                          color: Colors.white,))
                            : GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 2,
                          ),
                          itemBuilder: (_, index) =>
                              GridTile(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BrowsePhoto(
                                              title: "public",
                                              gridIndex: index,
                                              photoListings: profile
                                                  .personalListings!
                                                  .map((item) =>
                                              item.images.isNotEmpty
                                                  ? MemoryImage(item
                                                  .images[0]) as ImageProvider
                                                  : const AssetImage(
                                                  'lib/images/noImage.png'))
                                                  .toList(),
                                            ),
                                      ),
                                    );
                                  },
                                  child: Image(
                                    image: profile.personalListings![index]
                                        .images.isNotEmpty
                                        ? MemoryImage(
                                        profile.personalListings![index]
                                            .images[0])
                                        : const AssetImage(
                                        'lib/images/noImage.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                          itemCount: profile.personalListings!.length,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
    )
    );
  }
}
