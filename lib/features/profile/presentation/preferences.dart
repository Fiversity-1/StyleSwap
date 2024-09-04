
import 'package:clothing_swap/theme/theme.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:clothing_swap/theme/theme_switcher.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


class Preferences extends StatefulWidget {
  const Preferences({super.key});

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  late String chosenValue;

  @override
  void initState() {
    super.initState();
    chosenValue = Provider.of<ThemeSwitcher>(context, listen: false).themeData == lightTheme
        ? "Light"
        : "Dark";
  }

  Future<void> _logOutFunction() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (!kIsWeb) {
        await GoogleSignIn().signOut();
      }
      // Check if the context is still valid before navigating
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(context, '/startpage', (route) => false);
      }
    } catch (e) {
      debugPrint('Failed to sign out: $e');
    }
  }


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
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Preferences',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Colour Theme:',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    DropdownButton<String>(
                      value: chosenValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          chosenValue = newValue!;
                          Provider.of<ThemeSwitcher>(context, listen: false)
                              .toggleTheme(chosenValue, context);
                        });
                      },
                      items: const [
                        DropdownMenuItem<String>(
                            value: 'Light', child: Text('Light')),
                        DropdownMenuItem<String>(
                            value: 'Dark', child: Text('Dark')),
                        DropdownMenuItem<String>(
                            value: 'High Constrast',
                            child: Text('High Constrast')),
                        DropdownMenuItem<String>(
                            value: 'System', child: Text('System')),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: _logOutFunction,
                  child: const Text('Log Out'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
