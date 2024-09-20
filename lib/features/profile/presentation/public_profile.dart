import 'package:clothing_swap/features/messaging/chat_listing_class.dart';
import 'package:clothing_swap/features/profile/presentation/profile_class.dart';
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
    final chatManager = Provider.of<ChatManager>(context);
    final userManager = Provider.of<UserManager>(context);
    final chatUserId = chatManager.selectedChat?.otherUserId;
    final publicUser = userManager.getUserById(chatUserId!);
    double width = MediaQuery.of(context).size.width;
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: const CustomBottomNavBar(
          currentIndex: 3,
        ),
        //Icon based on colour scheme
        appBar: AppBar(
          title: Image.asset(
            Provider.of<ThemeSwitcher>(context).themeData == lightTheme
                ? 'lib/images/hanger.png'
                : 'lib/images/hanger_white.png',
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
                                backgroundImage: publicUser.profilePicture),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                      width: 375,
                      child: Text(
                        publicUser.name,
                        style: Theme.of(context).textTheme.headlineLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 30),
                      child: SizedBox(
                        width: width * 0.85,
                        child: Text(
                          publicUser.bio,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                        ),
                        itemBuilder: (_, index) => GridTile(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                //PhotoViewGallery Code from https://pub.dev/packages/photo_view
                                //see it used in browse_photos widget
                                //GPT used to stack icons on top of images
                                MaterialPageRoute(
                                    builder: (context) => BrowsePhoto(
                                          title: "public",
                                          gridIndex: index,
                                          photoListings: publicUser
                                              .personalListings
                                              .map((item) => item
                                                      .images.isNotEmpty
                                                  ? item.images[0]
                                                  : const AssetImage(
                                                      'lib/images/noImage.png'))
                                              .toList(),
                                        )),
                              );
                            },
                            child: Image(
                              image: publicUser
                                      .personalListings[index].images.isNotEmpty
                                  ? publicUser.personalListings[index].images[0]
                                  : const AssetImage('lib/images/noImage.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        itemCount: publicUser.personalListings.length,
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
}
