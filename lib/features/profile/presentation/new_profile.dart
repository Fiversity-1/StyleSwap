import 'package:clothing_swap/features/profile/data/profile_api.dart';
import 'package:clothing_swap/features/profile/presentation/profile_class.dart';
import 'package:clothing_swap/theme/gradient.dart';
import 'package:clothing_swap/theme/theme.dart';
import 'package:clothing_swap/theme/theme_switcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

//Complete new profile registration (after google sign-up)
class NewProfile extends StatefulWidget {
  const NewProfile({super.key});

  @override
  State<NewProfile> createState() => NewProfileState();
}

class NewProfileState extends State<NewProfile> {
  final FocusNode myFocusNodeLocation = FocusNode();
  final FocusNode myFocusNodeAgreement = FocusNode();
  final FocusNode myFocusNodeBio = FocusNode();
  final _controllerMap = TextEditingController();
  final _controllerBio = TextEditingController();
  String lat = "";
  String long = "";

//GPT used for terms and condition generation
//GPT used for checkValue logic for terms and condition validation
  bool checkedValue = false;
  bool isLoading = false;
  final String termsAndConditions = '''
Terms and Conditions for Trading Practices

1. Introduction
Welcome to StyleSwap! By using our platform for trading clothes and messaging, you agree to abide by the following Terms and Conditions. These terms are designed to ensure a positive and secure trading experience for all users.

2. General Conduct
- Respect and Courtesy: Treat all users with respect and courtesy. Harassment, discrimination, or abusive language will not be tolerated.
- Accuracy of Listings: Ensure that all items listed for trade are accurately described, including condition, size, and any defects. Misrepresentation of items is prohibited.
- Honest Communication: Communicate honestly and clearly. Misleading or deceptive messages are not allowed.

3. Trading Guidelines
- Trade Agreements: Once a trade agreement is reached, honor your commitment to complete the trade as agreed upon. This includes sending the agreed-upon item and following through with any agreed-upon conditions.
- Item Condition: The condition of the item should match the description provided. If the item is not in the promised condition, the trade may be subject to cancellation or resolution.
- Shipping and Handling: Follow any shipping or delivery guidelines provided in the trade agreement. Ensure that items are packaged securely to prevent damage during transit.

4. Messaging Rules
- Appropriate Content: All messages exchanged through the platform should be respectful and related to the trade. Avoid sending spam, irrelevant content, or personal contact information.
- Privacy: Do not share personal contact details, addresses, or other sensitive information through messages. Use the platform’s messaging system to communicate securely.
- Reporting Issues: If you encounter any issues or inappropriate behavior in messages, report it to the platform’s support team immediately.

5. Dispute Resolution
- Dispute Resolution Process: In the event of a dispute, contact the platform’s support team for assistance. The support team will work with both parties to resolve the issue fairly and promptly.
- Compliance: Both parties are required to cooperate with the platform’s resolution process and adhere to any decisions made by the support team.

6. User Responsibilities
- Account Security: Maintain the security of your account information and credentials. Do not share your account details with others.
- Compliance with Laws: Ensure that all trades comply with applicable local laws and regulations.

7. Platform Rights
- Modification of Terms: The platform reserves the right to modify these terms and conditions at any time. Users will be notified of any significant changes.
- Suspension or Termination: The platform may suspend or terminate accounts that violate these terms or engage in unethical practices.

8. Limitation of Liability
- Platform Liability: The platform is not liable for any disputes, damages, or losses resulting from trades between users. Users trade at their own risk and are responsible for resolving any issues that arise.

9. Contact Information
For any questions or concerns about these terms and conditions, please contact our support team at [support email/contact information].
''';

  @override
  Widget build(BuildContext context) {
    final userManager = Provider.of<UserManager>(context, listen: false);

    double width = MediaQuery.of(context).size.width;
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        //GPT used for fixing overflow pixels (resizeToAvoidBottomInset)
        resizeToAvoidBottomInset: false,
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
        body: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: GestureDetector(
            onTap: () {
              // Unfocus any active input field
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              // Adjusts padding to prevent overflow when the keyboard is shown
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    onLongPress: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          bottom: 16, left: 16, right: 16, top: 8),
                      child: SizedBox(
                        width: width * 0.9,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("Register",
                                style:
                                    Theme.of(context).textTheme.headlineMedium),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 1, left: 4),
                                  child: Text("Profile Bio",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                ),
                              ],
                            ),
                            TextField(
                              focusNode: myFocusNodeBio,
                              textInputAction: TextInputAction.done,
                              onSubmitted: (text) {
                                myFocusNodeLocation.requestFocus();
                              },
                              textAlignVertical: TextAlignVertical.top,
                              controller: _controllerBio,
                              maxLines: 3,
                              maxLength: 50,
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                contentPadding: const EdgeInsets.only(
                                    top: 10, left: 12, right: 0),
                                hintText: 'Aa',
                                hintStyle:
                                    Theme.of(context).textTheme.bodyLarge,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).hoverColor,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).hoverColor,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 1, left: 4),
                                  child: Text("Location",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                ),
                              ],
                            ),
                            _placesAutoCompleteTextField(),
                            const SizedBox(height: 15),
                            //GPT used for styling scrollable box for terms and conditions
                            SizedBox(
                              height: 150,
                              child: SingleChildScrollView(
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .listTileTheme
                                        .tileColor,
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(8),
                                      topLeft: Radius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    termsAndConditions,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                              ),
                            ),
                            //End modified by chatgpt
                            CheckboxListTile(
                              focusNode: myFocusNodeAgreement,
                              title: const Text(
                                  "I have read and accept all terms and conditions."),
                              value: checkedValue,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  checkedValue = newValue!;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(),
                                onPressed: () async {
                                  //Validation; only accept when bio, location is not null
                                  //Make sure terms and condition box ticked
                                  if ((checkedValue == false) ||
                                      (lat == "" || long == "") ||
                                      (_controllerBio.text == "")) {
                                    toastification.showCustom(
                                      context: context,
                                      autoCloseDuration:
                                          const Duration(seconds: 3),
                                      alignment: Alignment.topCenter,
                                      builder: (BuildContext context,
                                          ToastificationItem holder) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: Theme.of(context).hoverColor,
                                          ),
                                          padding: const EdgeInsets.all(16),
                                          margin: const EdgeInsets.all(8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                  (_controllerBio.text == "")
                                                      ? "Please enter a bio"
                                                      : (lat == "" ||
                                                              long == "")
                                                          ? "Please enter a valid location"
                                                          : "Please read and accept the terms and conditions",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              const SizedBox(height: 16),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                              setState(() {
                                isLoading = true;
                              });

                              try {
                                var isRegistered = await isUserRegistered();

                                if (!isRegistered) {
                                  var success = await addUser(lat, long, _controllerBio.text);

                                  if (!success) {
                                    throw "User not registered";
                                  }
                                }

                                // switch the user to reflect new user.
                                userManager.switchUser(Profile.fromUser(FirebaseAuth.instance.currentUser!));

                                Navigator.pushNamedAndRemoveUntil(context, '/personal_profile', (route) => false);
                              } finally {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          },
                          child: isLoading
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : const Text('Complete', style: TextStyle(fontSize: 20)),
                        )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//https://pub.dev/packages/google_places_flutter package used for determining location
//This template was modified by GPT to handle decoration changes.
  Widget _placesAutoCompleteTextField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: GooglePlaceAutoCompleteTextField(
        focusNode: myFocusNodeLocation,
        textEditingController: _controllerMap,
        boxDecoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).hoverColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        googleAPIKey: "AIzaSyB1h8eTsCt1ykA4awlzGB0nQ9eYewHXB88",
        inputDecoration: InputDecoration(
          hintText: "Enter your location",
          hintStyle: Theme.of(context).textTheme.bodyLarge,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              _controllerMap.text = "";
            },
          ),
        ),
        debounceTime: 400,
        countries: const ["au"],
        isLatLngRequired: true,

        getPlaceDetailWithLatLng: (Prediction prediction) {
          lat = prediction.lat!;
          long = prediction.lng!;
        },
        itemClick: (Prediction prediction) {
          setState(() {
            _controllerMap.text = prediction.description ?? "";
            _controllerMap.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description?.length ?? 0),
            );
          });
        },

        seperatedBuilder: const Divider(),
        itemBuilder: (context, index, Prediction prediction) {
          return Row(
            children: [
              const Icon(Icons.location_on),
              const SizedBox(width: 7),
              Expanded(child: Text(prediction.description ?? "")),
            ],
          );
        },
        isCrossBtnShown: false, // Disable default cross button
      ),
    );
  }
}
