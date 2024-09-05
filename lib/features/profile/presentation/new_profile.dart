// profile.dart
import 'package:clothing_swap/theme/theme.dart';
import 'package:clothing_swap/theme/theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewProfile extends StatefulWidget {
  const NewProfile({super.key});

  @override
  State<NewProfile> createState() => NewProfileState();
}

class NewProfileState extends State<NewProfile> {
  void _handleField(String input) {}

  final FocusNode myFocusNode = FocusNode();
  final _sendField = TextEditingController();
  final _scroller = ScrollController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Image.asset(
              Provider.of<ThemeSwitcher>(context).themeData == lightTheme
                  ? 'lib/images/hanger.png'
                  : 'lib/images/hanger_white.png',
              height: 65,
              width: 75,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              SizedBox(
                height: height,
                width: width,
                child: Opacity(
                  opacity: 0.15,
                  child: Image.asset('lib/images/backdrop4.jpg',
                      fit: BoxFit.cover),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "User Registration",
                          style: Theme.of(context).textTheme.headlineLarge,
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _getCurrentLocation();
                      },
                      child: Text("location")),
                  Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "First Name:",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          SizedBox(
                            width: width * 0.45,
                            height: 50,
                            child: TextField(
                              focusNode: myFocusNode,
                              textAlignVertical: TextAlignVertical.top,
                              controller: _sendField,
                              onSubmitted: _handleField,
                              decoration: InputDecoration(
                                //contentPadding from chatgpt
                                contentPadding:
                                    const EdgeInsets.only(left: 10, top: 20.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),

                                hintText: 'Enter here',
                                filled: true,

                                suffix: IconButton(
                                  icon: const Icon(Icons.check, size: 24),
                                  onPressed: () {
                                    if (_sendField.text.isNotEmpty) {
                                      _handleField(_sendField.text);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Email:",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          SizedBox(
                            width: width * 0.45,
                            height: 50,
                            child: TextField(
                              focusNode: myFocusNode,
                              textAlignVertical: TextAlignVertical.top,
                              controller: _sendField,
                              onSubmitted: _handleField,
                              decoration: InputDecoration(
                                //contentPadding from chatgpt
                                contentPadding:
                                    const EdgeInsets.only(left: 10, top: 20.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),

                                hintText: 'Enter here',
                                filled: true,

                                suffix: IconButton(
                                  icon: const Icon(Icons.check, size: 24),
                                  onPressed: () {
                                    if (_sendField.text.isNotEmpty) {
                                      _handleField(_sendField.text);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Last Name:",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          SizedBox(
                            width: width * 0.45,
                            height: 50,
                            child: TextField(
                              focusNode: myFocusNode,
                              textAlignVertical: TextAlignVertical.top,
                              controller: _sendField,
                              onSubmitted: _handleField,
                              decoration: InputDecoration(
                                //contentPadding from chatgpt
                                contentPadding:
                                    const EdgeInsets.only(left: 10, top: 20.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),

                                hintText: 'Enter here',
                                filled: true,

                                suffix: IconButton(
                                  icon: const Icon(Icons.check, size: 24),
                                  onPressed: () {
                                    if (_sendField.text.isNotEmpty) {
                                      _handleField(_sendField.text);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Profile Bio:",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          SizedBox(
                            width: width * 0.45,
                            height: 100,
                            child: TextField(
                              focusNode: myFocusNode,
                              textAlignVertical: TextAlignVertical.top,
                              controller: _sendField,
                              onSubmitted: _handleField,
                              decoration: InputDecoration(
                                //contentPadding from chatgpt
                                contentPadding:
                                    const EdgeInsets.only(left: 10, top: 20.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),

                                hintText: 'Enter ',
                                filled: true,

                                suffix: IconButton(
                                  icon: const Icon(Icons.check, size: 24),
                                  onPressed: () {
                                    if (_sendField.text.isNotEmpty) {
                                      _handleField(_sendField.text);
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Profile Picture",
                              style: Theme.of(context).textTheme.headlineSmall),
                          const CircleAvatar(
                            radius: 50,
                          ),
                        ],
                      )),
                ],
              )
            ],
          ),
        ));
  }
}
