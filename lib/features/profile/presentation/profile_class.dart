import 'package:clothing_swap/features/messaging/chat_listing_class.dart';
import 'package:flutter/material.dart';

//Learnt how to use provider code from Chat GPT, found in main and will be used throughout project
//Mostly follows the same format as Theme Provider.
class Profile with ChangeNotifier {
  final String name;
  String bio;
  AssetImage profilePicture;
  List<ImageProvider> personalListings;
  List<ChatListing> interestedListings;

  Profile({
    required this.name,
    required this.bio,
    required this.profilePicture,
    List<ImageProvider>? personalListings,
    List<ChatListing>? interestedListings,
  })  : personalListings = personalListings ?? [],
        interestedListings = interestedListings ?? [];

  // Method to add a personal listing
  void addPersonalListing(ImageProvider listing) {
    personalListings.add(listing);
    notifyListeners();
  }

  // Method to remove a personal listing
  void removePersonalListing(ImageProvider listing) {
    personalListings.remove(listing);
    notifyListeners();
  }

  // Method to add an interested listing
  void addInterestedListing(ChatListing listing) {
    interestedListings.add(listing);
    notifyListeners();
  }

  // Method to remove an interested listing
  void removeInterestedListing(ChatListing listing) {
    interestedListings.remove(listing);
    notifyListeners();
  }

  //A method to update bio or profile picture
  //NOTE need to modify for to handle whatever format from backend not assetimage likely

  void updateProfile({
    String? newBio,
    AssetImage? newProfilePicture,
  }) {
    if (newBio != null) {
      bio = newBio;
    }
    if (newProfilePicture != null) {
      profilePicture = newProfilePicture;
    }
    notifyListeners();
  }
}

// Define the UserManager class with ChangeNotifier
class UserManager with ChangeNotifier {
  final List<Profile> _users = [
    // Add more users as needed
  ];

  Profile _currentUser;
  Profile? _lastViewedUser;
  ChatListing? _lastClickedListing;
  UserManager() : _currentUser = personal;

  List<Profile> get users => _users;
  Profile get currentUser => _currentUser;

  void switchUser(Profile user) {
    _currentUser = user;
    notifyListeners();
  }

  void addUser(Profile user) {
    _users.add(user);
    notifyListeners();
  }

  void selectUserBasedOnCondition(bool Function(Profile) condition) {
    final user = _users.firstWhere(condition, orElse: () => _currentUser);
    switchUser(user);
  }

  void updateLastViewedUser(Profile user) {
    _lastViewedUser = user;
    notifyListeners();
  }

  void selectUserBasedOnLastViewed() {
    if (_lastViewedUser != null) {
      switchUser(_lastViewedUser!);
    }
  }

  void updateLastChatListingUser(Profile user) {
    _lastViewedUser = user;
    notifyListeners();
  }

  void selectUserBasedOnLastChatListing() {
    if (_lastViewedUser != null) {
      switchUser(_lastViewedUser!);
    }
  }
}

Profile personal = Profile(
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
Profile public = Profile(
    bio: "Keen for vintage clothes!",
    name: "Steve",
    personalListings: [
      const AssetImage(
        'lib/images/backdrop.jpg',
      ),
      const AssetImage('lib/images/2.jpg'),
      const AssetImage('lib/images/3.jpg'),
      const AssetImage('lib/images/5.jpg'),
    ],
    profilePicture: const AssetImage('lib/images/profilepicture.jpg'));
