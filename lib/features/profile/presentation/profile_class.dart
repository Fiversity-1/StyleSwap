import 'package:clothing_swap/features/clothing/presentation/clothing_item_class.dart';
import 'package:clothing_swap/features/clothing/presentation/preferences_provider.dart';
import 'package:clothing_swap/features/messaging/chat_listing_class.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

//GPT used to learn and implement provider code for user state management.
//Mostly follows the same format as Theme Provider.
class Profile with ChangeNotifier {
  final String id;
  final String name;
  String bio;
  AssetImage profilePicture;
  List<ClothingItem> personalListings;
  List<ChatListing> interestedListings;
  PreferencesNotifier preferences;

  Profile({
    required this.id,
    required this.name,
    required this.bio,
    required this.profilePicture,
    List<ClothingItem>? personalListings,
    List<ChatListing>? interestedListings,
    PreferencesNotifier? preferences,
    //user does not have to have personal or interested listings
  })  : personalListings = personalListings ?? [],
        interestedListings = interestedListings ?? [],
        preferences = preferences ?? PreferencesNotifier();

  void addPersonalListing(ClothingItem listing) {
    personalListings.add(listing);
    notifyListeners();
  }

  void removePersonalListing(ClothingItem listing) {
    personalListings.remove(listing);
    notifyListeners();
  }

  void addInterestedListing(ChatListing listing) {
    interestedListings.add(listing);
    notifyListeners();
  }

  void removeInterestedListing(ChatListing listing) {
    interestedListings.remove(listing);
    notifyListeners();
  }

  // Update bio or profile picture
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

//User manager handles user profiles
class UserManager with ChangeNotifier {
  final List<Profile> _users = [
    personal,
    public
  ]; // Ensure profiles are added here, currently using hardcoded profiles
  Profile _currentUser;

  UserManager() : _currentUser = personal;

  List<Profile> get users => _users;
  Profile get currentUser => _currentUser;

  //switch to current User
  void switchUser(Profile user) {
    _currentUser = user;
    notifyListeners();
  }

  void addUser(Profile user) {
    _users.add(user);
    notifyListeners();
  }

  //search for user based on ID
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

const uuid = Uuid(); //UUID generator

// Generate UUIDs for Profiles
String personalProfileUUID = uuid.v4();
String publicProfileUUID = uuid.v4();

// Generate UUIDs for ClothingItems
List<String> personalItemUUIDs = List.generate(5, (_) => uuid.v4());
List<String> publicItemUUIDs = List.generate(5, (_) => uuid.v4());

//Peronsal and public profiles instances used for testing purposes
List<ClothingItem> personalListings = [
  ClothingItem(
    id: personalItemUUIDs[0],
    userId: personalProfileUUID,
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
    id: personalItemUUIDs[1],
    userId: personalProfileUUID,
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
    id: personalItemUUIDs[2],
    userId: personalProfileUUID,
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
    id: personalItemUUIDs[3],
    userId: personalProfileUUID,
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
    id: publicItemUUIDs[0],
    userId: publicProfileUUID,
    name: 'Striped Shirt',
    location: 'Gold Coast',
    images: [const AssetImage('lib/images/0.jpg')],
    details: ClothingItemDetail(
      bio: 'Description for Clothing A',
      type: 'Shirt',
      size: "S",
      gender: 'Male',
      condition: 'Good',
      colours: ['ColorA'],
      images: [
        const AssetImage('lib/images/0.jpg'),
      ],
    ),
  ),
  ClothingItem(
    id: publicItemUUIDs[1],
    userId: publicProfileUUID,
    name: 'White Shirt',
    location: 'Mount Cotton',
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
    id: publicItemUUIDs[2],
    userId: publicProfileUUID,
    name: 'Red Shirt',
    location: 'Brisbane City',
    images: [const AssetImage('lib/images/3.jpg')],
    details: ClothingItemDetail(
      bio: 'Red Shirt bought from cotton-on',
      type: 'Shirt',
      size: "S",
      gender: 'Male',
      condition: 'Like new',
      colours: ['Red'],
      images: [const AssetImage('lib/images/3.jpg')],
    ),
  ),
  ClothingItem(
    id: publicItemUUIDs[3],
    userId: publicProfileUUID,
    name: 'Bucket Hat',
    location: 'Capalaba',
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
    id: publicItemUUIDs[4],
    userId: publicProfileUUID,
    name: 'Black Shirt',
    location: 'Windaroo',
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

Profile personal = Profile(
  id: personalProfileUUID,
  bio: "Keen for some trades!",
  name: "Jacob",
  personalListings: personalListings,
  profilePicture: const AssetImage('lib/images/jacob.jpg'),
);

Profile public = Profile(
  id: publicProfileUUID,
  bio: "Keen for vintage clothes!",
  name: "Steve",
  personalListings: publicListings,
  profilePicture: const AssetImage('lib/images/profilepicture.jpg'),
);
