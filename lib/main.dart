import 'package:clothing_swap/features/clothing/presentation/advanced_search.dart';
import 'package:clothing_swap/features/clothing/presentation/clothing_detail.dart';
import 'package:clothing_swap/features/community/event_class.dart';
import 'package:clothing_swap/features/community/eventlist.dart';
import 'package:clothing_swap/features/messaging/chat_listing_class.dart';
import 'package:clothing_swap/features/messaging/messagechat.dart';
import 'package:clothing_swap/features/messaging/messageinbox.dart';
import 'package:clothing_swap/features/clothing/presentation/add_clothing_item.dart';
import 'package:clothing_swap/features/profile/presentation/profile_class.dart';
import 'package:clothing_swap/widgets/comment.dart';
import 'package:flutter/material.dart';
import 'package:clothing_swap/features/signup/presentation/startpage.dart';
import 'package:clothing_swap/features/signup/presentation/signup.dart';
import 'package:clothing_swap/features/profile/presentation/personal_profile.dart';
import 'package:clothing_swap/features/clothing/presentation/search_main.dart';
import 'package:clothing_swap/features/clothing/presentation/swipe.dart';
import 'package:clothing_swap/features/signup/presentation/login.dart';
import 'package:provider/provider.dart';
import 'package:clothing_swap/theme/theme_switcher.dart';
import 'package:clothing_swap/features/profile/presentation/preferences.dart';
import 'features/profile/presentation/public_profile.dart';

void main() {
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
      theme: themeSwitcher.themeData,
      home: const StartPage(title: 'StartPage'),
      routes: {
        '/signup': (context) => const SignUp(title: 'SignUp'),
        '/startpage': (context) => const StartPage(title: 'StartPage'),
        '/personal_profile': (context) => const PersonalProfile(),
        '/public_profile': (context) => const PublicProfile(),
        '/search': (context) => const SearchPage(),
        '/advanced_search': (context) => const AdvancedSearch(),
        '/message': (context) => const Message(title: 'Message'),
        '/swipe': (context) => const SwipePage(),
        '/chat': (context) => const MessageChat(title: ''),
        '/comment': (context) => const Comments(),
        '/login': (context) => const Login(title: 'Login'),
        '/add_clothing_item': (context) => AddClothingItemPage(),
        '/clothing_detail': (context) => const ClothingDetail(),
        '/preferences': (context) => const Preferences(),
        '/events': (context) => EventPage(communityEvents: communityEvents),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
