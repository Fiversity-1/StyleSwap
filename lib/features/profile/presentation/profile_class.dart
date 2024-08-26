import 'package:flutter/material.dart';

class Profile {
  String name;
  String bio;
  AssetImage profilePicture;
  List<AssetImage>? listings;

  Profile({
    required this.name,
    required this.bio,
    required this.profilePicture,
    this.listings,
  });
}

Profile personalProfileExample = Profile(
    bio: "Keen for some trades!",
    name: "Jacob",
    listings: [
      const AssetImage(
        'lib/images/0.jpg',
      ),
      const AssetImage('lib/images/1.jpg'),
      const AssetImage('lib/images/3.jpg'),
      const AssetImage('lib/images/5.jpg'),
    ],
    profilePicture: const AssetImage('lib/images/jacob.jpg'));

Profile publicProfileExample = Profile(
    bio: "I love food and sustainability!",
    name: "Steve",
    listings: [
      const AssetImage('lib/images/2.jpg'),
      const AssetImage('lib/images/3.jpg'),
      const AssetImage('lib/images/4.jpg'),
    ],
    profilePicture: const AssetImage('lib/images/profilepicture.jpg'));
