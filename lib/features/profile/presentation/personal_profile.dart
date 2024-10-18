import 'package:clothing_swap/features/profile/domain/profile_class.dart';
import 'package:clothing_swap/theme/gradient.dart';
import 'package:clothing_swap/widgets/browse_photos.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:clothing_swap/widgets/photo_modal.dart';
import 'package:flutter/foundation.dart' show Uint8List, kDebugMode, kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

//Personal profile page
class PersonalProfile extends StatefulWidget {
  const PersonalProfile({super.key});

  @override
  State<PersonalProfile> createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {
//https://medium.com/@kavyamistry0612/building-interactive-user-interfaces-with-alert-dialogs-in-flutter-81e268fb72f0
//Template used throughout app for creating dialog boxes in flutter
//Dialog used to confirm decision to delete personal listing
  void _showAlertDialogRemoveListing(
      BuildContext context, Profile personalProfile, index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: const Text('Remove Listings'),
          content: const Text('Are you sure you want to remove this listing?'),
          actions: [
            TextButton(
              onPressed: () async {
                var success = await personalProfile.removePersonalListing(
                    personalProfile.personalListings![index]);

                if (!success) {
                  // TODO popup
                }

                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              //GPT was used for the following reasons:
              //Prompt: "How to style a text button Flutter"
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              //GPT was used for the following reasons:
              //Prompt: "How to style a text button Flutter"
              style: TextButton.styleFrom(foregroundColor: Colors.white),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  bool edited = false;
  final _changeBio = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  Uint8List? _image;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final userManager = Provider.of<UserManager>(context);
    final personalProfile = userManager.currentUser;

    return ChangeNotifierProvider.value(
        value: personalProfile,
        child: Consumer<Profile>(builder: (context, profile, child) {
          return GradientBackground(
              child: Scaffold(
            backgroundColor: Colors.transparent,
            bottomNavigationBar: const CustomBottomNavBar(
              currentIndex: 3,
            ),
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: CustomTopAppBar(),
            ),
            //GPT was used for the following reasons:
            //Prompt: "How to scale grid element amount on flutter with layoutbuilder"
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
                              padding:
                                  const EdgeInsets.only(top: 5.0, bottom: 5),
                              child: SizedBox(
                                  height: 150,
                                  width: 200,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 25,
                                        child: CircleAvatar(
                                            radius: 75,
                                            backgroundImage: (_image == null)
                                                ? (personalProfile
                                                            .profilePicture !=
                                                        null
                                                    ? MemoryImage(
                                                        personalProfile
                                                            .profilePicture!)
                                                    : const AssetImage(
                                                        'lib/images/profile/noProfilePicture.png'))
                                                : Image.memory(_image!,
                                                        fit: BoxFit.cover)
                                                    .image),
                                      ),
                                      //If in edit mode, confirm changes, if not select edit mode
                                      Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: IconButton(
                                            icon: Icon(edited
                                                ? Icons.check
                                                : Icons.edit),
                                            onPressed: () {
                                              edited = !edited;
                                              setState(() {
                                                personalProfile.updateProfile(
                                                    newBio: _changeBio
                                                            .text.isNotEmpty
                                                        ? _changeBio.text
                                                        : personalProfile.bio);
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            //Option to replace photo when in edit mode
                            Visibility(
                              visible: edited,
                              child: IconButton(
                                  icon: const Icon(
                                    Icons.image,
                                  ),
                                  iconSize: 25,
                                  onPressed: () async {
                                    XFile? image = await photoOptionModal(
                                        context, _picker, 50, null, null);
                                    if (image == null) {
                                      return;
                                    }

                                    final bytes = await image.readAsBytes();

                                    setState(() {
                                      _image = bytes;
                                    });
                                  }),
                            ),
                          ],
                        ),
                        Stack(
                          children: [
                            SizedBox(
                              height: 50,
                              width: 375,
                              child: Text(
                                personalProfile.name,
                                style:
                                    Theme.of(context).textTheme.headlineLarge,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 15),
                            child: Stack(
                              children: [
                                Stack(children: [
                                  Visibility(
                                    visible: !edited,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 15),
                                      child: SizedBox(
                                        width: width * 0.85,
                                        child: Text(
                                          personalProfile.bio,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                          textAlign: TextAlign.center,
                                          softWrap: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                                //Option to change bio when in edit mode
                                Visibility(
                                  visible: edited,
                                  child: SizedBox(
                                    height: 75,
                                    width: 300,
                                    child: TextField(
                                      maxLines: 3,
                                      maxLength: 50,
                                      textAlignVertical: TextAlignVertical.top,
                                      controller: _changeBio,
                                      decoration: InputDecoration(
                                        contentPadding: kIsWeb
                                            ? const EdgeInsets.all(20.0)
                                            : const EdgeInsets.only(
                                                top: 10, left: 10),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        hintText: 'New Bio...',
                                        filled: true,
                                        //GPT for fill color
                                        fillColor:
                                            Theme.of(context).highlightColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        //Grid of images when in normal mode, images cannot be deleted or dragged
                        Padding(
                          padding: const EdgeInsets.only(top: kIsWeb ? 15 : 5),
                          child: personalProfile.personalListings == null
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Visibility(
                                  visible: !edited,
                                  child: GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: crossAxisCount,
                                      mainAxisSpacing: 1.5,
                                      crossAxisSpacing: 1.5,
                                    ),
                                    itemBuilder: (_, index) => GridTile(
                                      child: GestureDetector(
                                        onLongPress: () {
                                          edited = !edited;
                                          setState(() {});
                                        },
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BrowsePhoto(
                                                      title: "personal",
                                                      gridIndex: index,
                                                      photoListings: personalProfile
                                                          .personalListings!
                                                          .map((item) => item
                                                                  .images.isNotEmpty
                                                              ? MemoryImage(item
                                                                      .images[0])
                                                                  as ImageProvider
                                                              : const AssetImage(
                                                                  'lib/images/noImage.png'))
                                                          .toList(),
                                                    )),
                                          );
                                        },
                                        child: Image(
                                          image: personalProfile
                                                  .personalListings![index]
                                                  .images
                                                  .isNotEmpty
                                              ? MemoryImage(personalProfile
                                                  .personalListings![index]
                                                  .images[0])
                                              : const AssetImage(
                                                  'lib/images/noImage.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    itemCount: personalProfile
                                        .personalListings!.length,
                                  ),
                                ),
                        ),
                        //Grid of images when in edit mode, images can be deleted or dragged
                        Padding(
                            padding:
                                const EdgeInsets.only(top: kIsWeb ? 15 : 5),
                            child: personalProfile.personalListings == null
                                ? null
                                : Visibility(
                                    visible: edited,
                                    child: ReorderableGridView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      dragStartDelay: Duration.zero,
                                      onReorder: (oldIndex, newIndex) {
                                        setState(() {
                                          var val = personalProfile
                                              .personalListings!
                                              .removeAt(oldIndex);
                                          personalProfile.personalListings!
                                              .insert(newIndex, val);
                                        });
                                      },
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: crossAxisCount,
                                        mainAxisSpacing: 0,
                                        crossAxisSpacing: 0,
                                      ),
                                      itemBuilder: (_, index) => GridTile(
                                          key: ValueKey(personalProfile
                                              .personalListings![index]),
                                          child: Stack(
                                            children: [
                                              SizedBox(
                                                width: double.infinity,
                                                height: double.infinity,
                                                child: Image(
                                                  image: personalProfile
                                                          .personalListings![
                                                              index]
                                                          .images
                                                          .isNotEmpty
                                                      ? MemoryImage(
                                                          personalProfile
                                                              .personalListings![
                                                                  index]
                                                              .images[0])
                                                      : const AssetImage(
                                                          'lib/images/noImage.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons.remove_circle,
                                                      color: Colors.black,
                                                    ),
                                                    iconSize: 25,
                                                    onPressed: () async {
                                                      _showAlertDialogRemoveListing(
                                                          context,
                                                          personalProfile,
                                                          index);
                                                    },
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons.open_with,
                                                      color: Colors.black,
                                                    ),
                                                    iconSize: 25,
                                                    onPressed: () {},
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                      itemCount: personalProfile
                                          .personalListings!.length,
                                    ),
                                  )),
                      ],
                    ),
                  ),
                );
              },
            ),
          ));
        }));
  }
}
