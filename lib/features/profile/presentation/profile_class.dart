import 'package:clothing_swap/features/messaging/chat_listing_class.dart';
import 'package:flutter/material.dart';

class Profile {
  String name;
  String bio;
  AssetImage profilePicture;
  List<ImageProvider>? personalListings;
  List<ChatListing>? interestedListings;

  Profile({
    required this.name,
    required this.bio,
    required this.profilePicture,
    this.personalListings,
  });
}

Profile personalProfileExample = Profile(
    bio: "Keen for some trades!",
    name: "Jacob",
    personalListings: [
      const AssetImage(
        'lib/images/4.jpg',
      ),
      const AssetImage('lib/images/1.jpg'),
      const AssetImage('lib/images/3.jpg'),
      const AssetImage('lib/images/5.jpg'),
    ],
    profilePicture: const AssetImage('lib/images/jacob.jpg'));

Profile publicProfileExample = Profile(
    bio: "I love food and sustainability!",
    name: "Steve",
    personalListings: [
      const AssetImage('lib/images/2.jpg'),
      const AssetImage('lib/images/3.jpg'),
      const AssetImage('lib/images/4.jpg'),
    ],
    profilePicture: const AssetImage('lib/images/profilepicture.jpg'));
