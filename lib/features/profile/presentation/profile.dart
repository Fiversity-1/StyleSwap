// profile.dart
import 'dart:io';
import 'package:clothing_swap/widgets/clipOval.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_flip_card/flutter_flip_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

class Profile extends StatefulWidget {
  const Profile({super.key, required this.title});

  final String title;
  @override
  State<Profile> createState() => _ProfileState();
}

List<String> images = [
  'lib/images/0.jpg',
  'lib/images/1.jpg',
  'lib/images/2.jpg',
  'lib/images/watermelon.png',
  'lib/images/watermelon2.jpg'
];

class _ProfileState extends State<Profile> {
  bool edited = false;
  bool editedBio = false;
  String bio = 'I love food and sustainability! Keen to trade some clothes!';

//List generate line from chatgpt
  final List<FlipCardController> _flipImage =
      List.generate(images.length, (index) => FlipCardController());

  final _changeBio = TextEditingController();

  //DhiWise Fluter Image tutorial implementation
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  @override
  Widget build(BuildContext context) {
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
                      child: ClipOval(
                        clipper: OvalShapeClipper(),
                        child: (_image == null)
                            //Chatgpt recommended using Image.asset instead of Asset Image
                            ? Image.asset('lib/images/profilepicture.jpg',
                                fit: BoxFit.cover)
                            : kIsWeb
                                ? Image.network(_image!.path)
                                : Image.file(
                                    File(_image!.path),
                                  ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: edited,
                    child: IconButton(
                        icon: const Icon(
                          Icons.image,
                        ),
                        iconSize: 25,
                        onPressed: () async {
                          final XFile? image = await _picker.pickImage(
                              source: ImageSource.gallery);

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
                      'Steve',
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 65,
                    bottom: 10,
                    child: ElevatedButton(
                      onPressed: () {
                        edited = !edited;
                        setState(() {});
                      },
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(7)),
                      child: Text(
                        !edited ? 'Edit Profile' : 'Done',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  )
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
                                          bio = _changeBio.text;
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
                                  bio,
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
              Visibility(
                visible: !edited,
                child: GridView.builder(
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
                        setState(() {
                          _flipImage[index].flipcard();
                        });
                      },
                      child: FlipCard(
                        frontWidget: Image.asset(
                          images[index],
                          fit: BoxFit.cover,
                        ),
                        backWidget: Container(
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              border: Border.all(
                                  color: Theme.of(context).hoverColor,
                                  width: 5)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Date Listed: 22/08/24",
                                  style: Theme.of(context).textTheme.bodyLarge),
                              Text(" Total Views: 56",
                                  style: Theme.of(context).textTheme.bodyLarge),
                              Text(" Total Interested: 5",
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ],
                          ),
                        ),
                        controller: _flipImage[index],
                        rotateSide: RotateSide.right,
                      ),
                    ),
                  ),

                  //End modified code
                  itemCount: images.length,
                ),
              ),
              Visibility(
                visible: edited,
                child: ReorderableGridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  dragStartDelay: Duration.zero,
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      var val = images.removeAt(oldIndex);
                      images.insert(newIndex, val);
                    });
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: kIsWeb ? 3 : 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                  ),
                  itemBuilder: (_, index) => GridTile(
                      key: ValueKey(images[index]),
                      child: Stack(
                        children: [
                          //3 lines from chatgpt, suggested to use infinity with sized box
                          //as having weird format when added icon on top
                          SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            //end chatgpt
                            child: Image.asset(
                              images[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    content:
                                        const Text('Would you like to remove?'),
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
                                      images.removeAt(index);
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
                  itemCount: images.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
