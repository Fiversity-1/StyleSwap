import 'package:clothing_swap/features/clothing/presentation/clothing_item_class.dart';
import 'package:clothing_swap/features/clothing/presentation/preferences_provider.dart';
import 'package:clothing_swap/features/messaging/chat_listing_class.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

//Learnt how to use provider code from Chat GPT, found in main and will be used throughout project
//Mostly follows the same format as Theme Provider.
class Profile with ChangeNotifier {
  final String id;
  final String name;
  String bio;
  AssetImage profilePicture;
  List<ClothingItem> personalListings;
  List<ChatListing> interestedListings;
  PreferencesNotifier preferences; // Added PreferencesNotifier

  Profile({
    required this.id,
    required this.name,
    required this.bio,
    required this.profilePicture,
    List<ClothingItem>? personalListings,
    List<ChatListing>? interestedListings,
    PreferencesNotifier? preferences, // Added PreferencesNotifier
  })  : personalListings = personalListings ?? [],
        interestedListings = interestedListings ?? [],
        preferences = preferences ??
            PreferencesNotifier(); // Initialize PreferencesNotifier

  // Method to add a personal listing
  void addPersonalListing(ClothingItem listing) {
    personalListings.add(listing);
    notifyListeners();
  }

  // Method to remove a personal listing
  void removePersonalListing(ClothingItem listing) {
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

  // A method to update bio or profile picture
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
    personal,
    public
  ]; // Ensure profiles are added here
  Profile _currentUser;

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

  Profile getUserById(String userId) {
    return _users.firstWhere(
      (user) => user.id == userId,
      orElse: () => throw StateError('No user found with id $userId'),
    );
  }

  List<String> getPreferences(String category) {
    return _currentUser.preferences.getPreferences(category);
  }

  void addPreference(String category, String preference) {
    _currentUser.preferences.addPreference(category, preference);
    notifyListeners();
  }

  void removePreference(String category, String preference) {
    _currentUser.preferences.removePreference(category, preference);
    notifyListeners();
  }
}

const uuid = Uuid(); // Create a UUID generator

// Generate UUIDs for Profiles
String personalProfileUUID = uuid.v4();
String publicProfileUUID = uuid.v4();

// Generate UUIDs for ClothingItems
List<String> personalItemUUIDs = List.generate(5, (_) => uuid.v4());
List<String> publicItemUUIDs = List.generate(5, (_) => uuid.v4());

// Update Profiles and ClothingItems with UUIDs
List<ClothingItem> personalListings = [
  ClothingItem(
    id: personalItemUUIDs[0], // Use generated UUID
    userId: personalProfileUUID, // Assign Profile UUID
    name: 'Clothing 1',
    location: 'Location 1',
    images: [const AssetImage('lib/images/4.jpg')],
    details: ClothingItemDetail(
      bio: 'Description for Clothing 1',
      type: 'Shirt',
      size: "S",
      gender: 'Male',
      condition: 'Good',
      colours: ['Color1'],
      images: [const AssetImage('lib/images/4.jpg')],
    ),
  ),
  ClothingItem(
    id: personalItemUUIDs[1], // Use generated UUID
    userId: personalProfileUUID, // Assign Profile UUID
    name: 'Clothing 2',
    location: 'Location 2',
    images: [const AssetImage('lib/images/1.jpg')],
    details: ClothingItemDetail(
      bio: 'Description for Clothing 2',
      type: 'Type 2',
      size: "S",
      gender: 'Male',
      condition: 'Good',
      colours: ['Color2'],
      images: [const AssetImage('lib/images/1.jpg')],
    ),
  ),
  ClothingItem(
    id: personalItemUUIDs[2], // Use generated UUID
    userId: personalProfileUUID, // Assign Profile UUID
    name: 'Clothing 3',
    location: 'Location 3',
    images: [const AssetImage('lib/images/3.jpg')],
    details: ClothingItemDetail(
      bio: 'Description for Clothing 3',
      type: 'Type 3',
      size: "S",
      gender: 'Male',
      condition: 'Good',
      colours: ['Color3'],
      images: [const AssetImage('lib/images/3.jpg')],
    ),
  ),
  ClothingItem(
    id: personalItemUUIDs[3], // Use generated UUID
    userId: personalProfileUUID, // Assign Profile UUID
    name: 'Clothing 4',
    location: 'Location 4',
    images: [const AssetImage('lib/images/5.jpg')],
    details: ClothingItemDetail(
      bio: 'Description for Clothing 4',
      type: 'Type 4',
      size: "S",
      gender: 'Male',
      condition: 'Good',
      colours: ['Color4'],
      images: [const AssetImage('lib/images/5.jpg')],
    ),
  ),
];

List<ClothingItem> publicListings = [
  ClothingItem(
    id: publicItemUUIDs[0], // Use generated UUID
    userId: publicProfileUUID, // Assign Profile UUID
    name: 'Clothing A',
    location: 'Location A',
    images: [const AssetImage('lib/images/backdrop.jpg')],
    details: ClothingItemDetail(
      bio: 'Description for Clothing A',
      type: 'Shirt',
      size: "S",
      gender: 'Male',
      condition: 'Good',
      colours: ['ColorA'],
      images: [
        const AssetImage('lib/images/backdrop.jpg'),
      ],
    ),
  ),
  ClothingItem(
    id: publicItemUUIDs[1], // Use generated UUID
    userId: publicProfileUUID, // Assign Profile UUID
    name: 'Clothing B',
    location: 'Location B',
    images: [const AssetImage('lib/images/2.jpg')],
    details: ClothingItemDetail(
      bio: 'Description for Clothing B',
      type: 'Type B',
      size: "S",
      gender: 'Male',
      condition: 'Good',
      colours: ['ColorB'],
      images: [const AssetImage('lib/images/2.jpg')],
    ),
  ),
  ClothingItem(
    id: publicItemUUIDs[2], // Use generated UUID
    userId: publicProfileUUID, // Assign Profile UUID
    name: 'Clothing C',
    location: 'Location C',
    images: [const AssetImage('lib/images/3.jpg')],
    details: ClothingItemDetail(
      bio: 'Description for Clothing C',
      type: 'Type C',
      size: "S",
      gender: 'Male',
      condition: 'Good',
      colours: ['ColorC'],
      images: [const AssetImage('lib/images/3.jpg')],
    ),
  ),
  ClothingItem(
    id: publicItemUUIDs[3], // Use generated UUID
    userId: publicProfileUUID, // Assign Profile UUID
    name: 'Clothing D',
    location: 'Location D',
    images: [const AssetImage('lib/images/5.jpg')],
    details: ClothingItemDetail(
      bio: 'Description for Clothing D',
      type: 'Type D',
      size: "S",
      gender: 'Male',
      condition: 'Good',
      colours: ['ColorD'],
      images: [const AssetImage('lib/images/5.jpg')],
    ),
  ),
  ClothingItem(
    id: publicItemUUIDs[4], // Use generated UUID
    userId: publicProfileUUID, // Assign Profile UUID
    name: 'Clothing E',
    location: 'Location E',
    images: [
      const AssetImage('lib/images/1.jpg'),
      const AssetImage('lib/images/1-extra.jpg')
    ],
    details: ClothingItemDetail(
      bio: 'Description for Clothing E',
      type: 'Type E',
      size: "S",
      gender: 'Male',
      condition: 'Good',
      colours: ['ColorE'],
      images: [
        const AssetImage('lib/images/1.jpg'),
        const AssetImage('lib/images/1-extra.jpg')
      ],
    ),
  ),
];

// Update Profiles with UUIDs
Profile personal = Profile(
  id: personalProfileUUID, // Use generated UUID
  bio: "Keen for some trades!",
  name: "Jacob",
  personalListings: personalListings,
  profilePicture: const AssetImage('lib/images/jacob.jpg'),
);

Profile public = Profile(
  id: publicProfileUUID, // Use generated UUID
  bio: "Keen for vintage clothes!",
  name: "Steve",
  personalListings: publicListings,
  profilePicture: const AssetImage('lib/images/profilepicture.jpg'),
);
