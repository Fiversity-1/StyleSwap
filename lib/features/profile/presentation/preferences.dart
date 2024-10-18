import 'package:clothing_swap/theme/gradient.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

//Page for user settings and preferences (not search preferences)
class Preferences extends StatefulWidget {
  const Preferences({super.key});

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  //GPT was used for the following reasons:
  //Prompt: "Generate a safety guide for a clothing app where users
  //can message and trade in person. Include a point about hygiene"

  final String safetyGuide = '''
1. **Use the Platform’s Messaging for All Communication**
   - Always use the platform’s built-in messaging system to communicate. Avoid taking conversations to other apps to ensure your safety and privacy are protected by the platform’s security measures.

2. **Clearly Agree on Trade Terms**
   - Discuss all the details of the trade through the platform’s messaging system, including the item’s condition, the meeting location, and any other expectations. This helps to avoid misunderstandings.

3. **Keep Personal Information Private**
   - Never share your personal details (like home or work addresses) in messages. Use the platform’s privacy settings to keep your personal information secure.

4. **Meet in a Safe, Public Place**
   - Always meet in a busy, well-lit public area, such as a café, mall, or a police station’s “Safe Exchange Zone.” Avoid secluded locations.

5. **Bring a Companion**
   - If possible, bring someone along when meeting for a trade. Having a friend or family member with you provides extra safety and peace of mind.

6. **Inspect Items Before Completing the Trade**
   - Examine the item carefully to ensure it matches the description given in messages. Verify that the quality and condition are as agreed.

7. **No Money Involved – Stick to the Item Trade**
   - Since the platform is for item trading, not sales, no money should exchange hands. Make sure the agreed trade is strictly about the items and no one is requesting payment outside of the deal.

8. **Follow Proper Hygiene Practices**
   - Ensure the items you are trading, especially clothes, are clean and hygienic. Wash items beforehand and package them appropriately to maintain cleanliness. It's courteous and reassures both parties about the quality of the exchange.

9. **Walk Away if You Feel Uncomfortable**
   - If at any point during the exchange something feels off, trust your instincts. You can always leave the situation and report suspicious users to the platform.

10. **Notify a Friend or Family Member**
    - Inform someone you trust about where and when you’re meeting for the trade. Let them know the details of the person you’re trading with, and check in with them once the trade is completed.
''';

  late String chosenValue;

  //Firebase Implemented based on tutorial: https://firebase.google.com/codelabs/firebase-auth-in-flutter-apps#0
  //Log out via Firebase
  Future<void> _logOutFunction() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (!kIsWeb) {
        await GoogleSignIn().signOut();
      }
      // Check if the context is still valid before navigating
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/startpage', (route) => false);
      }
    } catch (e) {
      debugPrint('Failed to sign out: $e');
    }
  }

//Options for profile visibility
  final List<String> options = [
    'Public',
    'Private',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
        body: Center(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              child: Text("Settings",
                  style: Theme.of(context).textTheme.headlineMedium),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  Text("Safety Guide",
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child:
                  //GPT was used for the following reasons:
                  //Prompt: "How to create a container similar to one
                  //used for terms and conditions"

                  SizedBox(
                height: 250,
                width: width * 0.85,
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).listTileTheme.tileColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        topLeft: Radius.circular(8),
                      ),
                    ),
                    child: Text(
                      safetyGuide,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ),
              ), //End gpt
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 25),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 75),
                    child: Text("Profile Visibility",
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                  //Code example from following link used and modified:
                  //https://pub.dev/packages/dropdown_button2
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: Text(
                        'Public',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: options
                          .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 40,
                        width: 140,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 25),
              child: Row(
                children: [
                  Text("Account", style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _logOutFunction,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                      ),
                      child: const Text('Log Out'),
                    ),
                    ElevatedButton(
                        onPressed: _logOutFunction,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text('Delete Account')),
                  ],
                )),
          ]),
        ),
      ),
    );
  }
}
