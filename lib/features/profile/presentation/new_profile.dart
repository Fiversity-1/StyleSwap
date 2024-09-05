// profile.dart
import 'package:clothing_swap/theme/theme.dart';
import 'package:clothing_swap/theme/theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/place_type.dart';
import 'package:google_places_flutter/model/prediction.dart';
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
  final _controller = TextEditingController();
  late GoogleMapController mapController;
  String lat = "";
  String long = "";

  final LatLng _center = const LatLng(-33.86, 151.20);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: true,
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
                  //https://pub.dev/packages/google_places_flutter slightly modified for australia
                  GooglePlaceAutoCompleteTextField(
                    textEditingController: _controller,
                    googleAPIKey: "AIzaSyB1h8eTsCt1ykA4awlzGB0nQ9eYewHXB88",
                    inputDecoration: const InputDecoration(),
                    debounceTime: 600, // default 600 ms,
                    countries: const ["aus"], // optional by default null is set
                    isLatLngRequired:
                        true, // if you required coordinates from place detail
                    getPlaceDetailWithLatLng: (Prediction prediction) {
                      //Chat GPT update lat,long, delete later

                      setState(() {
                        lat = prediction.lat.toString();
                        long = prediction.lng.toString();
                      });
                      // this method will return latlng with place detail
                    }, // this callback is called when isLatLngRequired is true
                    itemClick: (Prediction prediction) {
                      _controller.text = prediction.description!;
                      _controller.selection = TextSelection.fromPosition(
                          TextPosition(offset: prediction.description!.length));
                    },
                    // if we want to make custom list item builder
                    itemBuilder: (context, index, Prediction prediction) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const Icon(Icons.location_on),
                            const SizedBox(
                              width: 7,
                            ),
                            Expanded(child: Text(prediction.description ?? ""))
                          ],
                        ),
                      );
                    },

                    // if you want to add seperator between list items
                    seperatedBuilder: const Divider(),
                    // want to show close icon
                    isCrossBtnShown: true,
                    // optional container padding
                    containerHorizontalPadding: 10,
                    // place type
                    placeType: PlaceType.geocode,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 25, bottom: 25),
                  //   child: SizedBox(
                  //     height: width * 0.5,
                  //     width: 250,
                  //     child: GoogleMap(
                  //       onMapCreated: _onMapCreated,
                  //       initialCameraPosition: CameraPosition(
                  //         target: _center,
                  //         zoom: 11.0,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Text("latitude $lat"),

                  Text("longitude $long")
                ],
              ),
            ],
          ),
        ));
  }
}
