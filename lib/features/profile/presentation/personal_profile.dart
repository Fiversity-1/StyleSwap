// profile.dart
import 'dart:io';
import 'package:clothing_swap/features/profile/presentation/profile_class.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:clothing_swap/widgets/photo_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.title});

  final String title;
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool edited = false;
  bool editedBio = false;

//List generate line from chatgpt
  final List<FlipCardController> _flipImage = List.generate(
      personalProfileExample.personalListings!.length,
      (index) => FlipCardController());

  final _changeBio = TextEditingController();

  //See DhiWise Flutter Image tutorial implementation
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  @override
  Widget build(BuildContext context) {
    PageController _pageController;
    double height = MediaQuery.of(context).size.height;
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
                        width: 200,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 25,
                              child: CircleAvatar(
                                radius: 75,
                                backgroundImage: (_image == null)
                                    ? personalProfileExample.profilePicture
                                    : kIsWeb
                                        ? Image.network(_image!.path,
                                                fit: BoxFit.cover)
                                            .image
                                        : FileImage(
                                            (File(
                                              _image!.path,
                                            )),
                                          ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: IconButton(
                                  icon: Icon(edited ? Icons.check : Icons.edit),
                                  onPressed: () {
                                    edited = !edited;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                  Visibility(
                    visible: edited,
                    child: IconButton(
                        icon: const Icon(
                          Icons.image,
                        ),
                        iconSize: 25,
                        //ChatGPT suggested use of async, wait with Future returns
                        onPressed: () async {
                          XFile? image = await photoOptionModal(
                              context, _picker, 50, null, null);
                          setState(() {
                            _image = image;
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
                      personalProfileExample.name,
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
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
                              color: editedBio
                                  ? Colors.transparent
                                  : Theme.of(context).highlightColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Stack(
                            children: [
                              Visibility(
                                visible: editedBio,
                                child: SizedBox(
                                  height: 75,
                                  width: 300,
                                  child: TextField(
                                    maxLines: 3,
                                    textAlignVertical: TextAlignVertical.top,
                                    controller: _changeBio,
                                    decoration: InputDecoration(
                                      //contentPadding from chatgpt
                                      contentPadding: kIsWeb
                                          ? const EdgeInsets.all(20.0)
                                          : const EdgeInsets.only(
                                              top: 10, left: 10),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      hintText: 'New Bio...',
                                      filled: true,
                                      suffix: IconButton(
                                        icon: const Icon(Icons.done,
                                            size: kIsWeb ? 24 : 18),
                                        onPressed: () {
                                          //Idea from chatgpt to handle both enter and icon
                                          personalProfileExample.bio =
                                              _changeBio.text;
                                          editedBio = !editedBio;
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: !editedBio,
                                child: Text(
                                  personalProfileExample.bio,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          )),
                      Visibility(
                        visible: edited,
                        child: IconButton(
                            icon: const Icon(
                              Icons.edit,
                            ),
                            iconSize: 25,
                            //pubdev confirm dialog
                            onPressed: () {
                              editedBio = !editedBio;
                              setState(() {});
                            }),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(top: kIsWeb ? 15 : 5),
                child: Visibility(
                  visible: !edited,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: kIsWeb ? 4 : 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
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
                            //PhotoViewGallery Code from pubdev photo_view modified with ChatGPT to stack icon on top
                            MaterialPageRoute(
                                builder: (context) => Scaffold(
                                        body: Stack(
                                      children: [
                                        PhotoViewGallery.builder(
                                          itemCount: personalProfileExample
                                              .personalListings!.length,
                                          builder: (context, index) {
                                            return PhotoViewGalleryPageOptions(
                                              imageProvider:
                                                  personalProfileExample
                                                      .personalListings![index],
                                              minScale: PhotoViewComputedScale
                                                      .contained *
                                                  0.8,
                                              maxScale: PhotoViewComputedScale
                                                      .covered *
                                                  2,
                                            );
                                          },
                                          pageController: _pageController =
                                              PageController(
                                                  initialPage: index),
                                          scrollPhysics:
                                              const BouncingScrollPhysics(),
                                          enableRotation: true,
                                        ),
                                        Column(children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: kIsWeb ? 0 : 25),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, left: 5),
                                                  child: IconButton(
                                                      icon: const Icon(
                                                        Icons.info,
                                                      ),
                                                      iconSize: 25,
                                                      onPressed: () {
                                                        showModalBottomSheet(
                                                            context: context,
                                                            builder: (context) {
                                                              return Wrap(
                                                                children: [
                                                                  const ListTile(
                                                                    leading: Icon(
                                                                        Icons
                                                                            .date_range),
                                                                    title: Text(
                                                                        'Date Listed:'),
                                                                    subtitle: Text(
                                                                        '27/08/2024'),
                                                                  ),
                                                                  const ListTile(
                                                                      leading: Icon(
                                                                          Icons
                                                                              .people),
                                                                      title: Text(
                                                                          'Views'),
                                                                      subtitle:
                                                                          Text(
                                                                              "15")),
                                                                  const ListTile(
                                                                    leading: Icon(
                                                                        Icons
                                                                            .swap_horiz),
                                                                    title: Text(
                                                                        'Interested People'),
                                                                    subtitle:
                                                                        Text(
                                                                            "15"),
                                                                  ),
                                                                  Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          bottom:
                                                                              5),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          ElevatedButton(
                                                                            onPressed:
                                                                                () async {
                                                                              if (await confirm(
                                                                                context,
                                                                                title: const Text('Confirm'),
                                                                                content: const Text('Would you like to remove?'),
                                                                                textOK: Text('Yes', style: Theme.of(context).textTheme.bodyLarge),
                                                                                textCancel: Text('No', style: Theme.of(context).textTheme.bodyLarge),
                                                                              )) {
                                                                                setState(() {
                                                                                  personalProfileExample.personalListings!.removeAt(index);
                                                                                });
                                                                              }
                                                                            },
                                                                            child:
                                                                                const Text("Delete Listing"),
                                                                          )
                                                                        ],
                                                                      ))
                                                                ],
                                                              );
                                                            });
                                                      }),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5, left: 5),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                              curve: Curves
                                                                  .easeInOut);
                                                        }),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
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
                                                              curve: Curves
                                                                  .easeInOut);
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
                          image:
                              personalProfileExample.personalListings![index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    itemCount: personalProfileExample.personalListings!.length,
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: kIsWeb ? 15 : 5),
                  child: Visibility(
                    visible: edited,
                    child: ReorderableGridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      dragStartDelay: Duration.zero,
                      onReorder: (oldIndex, newIndex) {
                        setState(() {
                          var val = personalProfileExample.personalListings!
                              .removeAt(oldIndex);
                          personalProfileExample.personalListings!
                              .insert(newIndex, val);
                        });
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: kIsWeb ? 4 : 2,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                      ),
                      itemBuilder: (_, index) => GridTile(
                          key: ValueKey(
                              personalProfileExample.personalListings![index]),
                          child: Stack(
                            children: [
                              //3 lines from chatgpt, suggested to use infinity with sized box
                              //as having weird format when added icon on top
                              SizedBox(
                                  width: double.infinity,
                                  height: double.infinity,
                                  //end chatgpt
                                  child: Image(
                                      image: personalProfileExample
                                          .personalListings![index],
                                      fit: BoxFit.cover)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.remove_circle,
                                      color: Colors.black,
                                    ),
                                    iconSize: 25,
                                    //pubdev confirm dialog
                                    onPressed: () async {
                                      if (await confirm(
                                        context,
                                        title: const Text('Confirm'),
                                        content: const Text(
                                            'Would you like to remove?'),
                                        textOK: Text('Yes',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge),
                                        textCancel: Text('No',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge),
                                      )) {
                                        setState(() {
                                          personalProfileExample
                                              .personalListings!
                                              .removeAt(index);
                                        });
                                      }
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
                              )
                            ],
                          )),
                      itemCount:
                          personalProfileExample.personalListings!.length,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
