import 'package:clothing_swap/features/clothing/presentation/clothing_detail.dart';
import 'package:clothing_swap/features/clothing/presentation/preferences_provider.dart';
import 'package:clothing_swap/features/clothing/presentation/search_provider.dart';
import 'package:clothing_swap/features/clothing/presentation/select_preferences.dart';
import 'package:clothing_swap/features/community/event_class.dart';
import 'package:clothing_swap/features/community/eventlist.dart';
import 'package:clothing_swap/features/messaging/chat_listing_class.dart';
import 'package:clothing_swap/features/messaging/messagechat.dart';
import 'package:clothing_swap/features/messaging/messageinbox.dart';
import 'package:clothing_swap/features/clothing/presentation/add_clothing_item.dart';
import 'package:clothing_swap/features/profile/presentation/new_profile.dart';
import 'package:clothing_swap/features/profile/presentation/profile_class.dart';
import 'package:clothing_swap/widgets/comment.dart';
import 'package:flutter/material.dart';
import 'package:clothing_swap/features/signup/presentation/startpage.dart';
import 'package:clothing_swap/features/profile/presentation/personal_profile.dart';
import 'package:clothing_swap/features/clothing/presentation/view_pref.dart';
import 'package:clothing_swap/features/clothing/presentation/swipe.dart';
import 'package:provider/provider.dart';
import 'package:clothing_swap/theme/theme_switcher.dart';
import 'package:clothing_swap/features/profile/presentation/preferences.dart';
import 'features/profile/presentation/public_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Provider code modified by GPT to include multiple instaces
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeSwitcher(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserManager(),
        ),
        ChangeNotifierProvider(create: (context) => Search()),
        ChangeNotifierProvider(create: (context) => PreferencesNotifier()),
        ChangeNotifierProxyProvider<UserManager, ChatManager>(
          create: (context) => ChatManager(context.read<UserManager>()),
          update: (context, userManager, previousChatManager) {
            return ChatManager(userManager);
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtain the ThemeSwitcher instance
    final themeSwitcher = Provider.of<ThemeSwitcher>(context);

    return MaterialApp(
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("lalalallalalalalallalaala");
            return const CircularProgressIndicator();
          } else if (snapshot.hasData) {
            print("SUCESSSSSSSSSSSSSSS ROUTE TO PERSONAL");
            return const PersonalProfile();
          } else {
            print("start paaaaaaaaaaaaaaaaaaaaaaaaaaagggggggggeeee");
            return const StartPage(title: 'StartPage');
          }
        },
      ),
      theme: themeSwitcher.themeData,
      routes: {
        '/startpage': (context) => const StartPage(title: 'StartPage'),
        '/personal_profile': (context) => const PersonalProfile(),
        '/new_profile': (context) => const NewProfile(),
        '/public_profile': (context) => const PublicProfile(),
        '/view_clothes_preferences': (context) => const ViewPrefences(),
        '/message': (context) => const Message(title: 'Message'),
        '/swipe': (context) => const SwipePage(),
        '/chat': (context) => const MessageChat(),
        '/comment': (context) => const Comments(),
        '/add_clothing_item': (context) => const AddClothingItemPage(),
        '/clothing_detail': (context) => const ClothingDetail(),
        '/preferences': (context) => const Preferences(),
        '/add_clothes_preferences': (context) => const AddClothesPreferences(),
        '/events': (context) => EventPage(communityEvents: communityEvents),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
