import 'dart:io';
import 'dart:typed_data';

import 'package:clothing_swap/features/clothing/data/matching_api.dart';
import 'package:clothing_swap/features/clothing/presentation/clothing_item_class.dart';
import 'package:clothing_swap/features/messaging/domain/chat_listing_class.dart';
import 'package:clothing_swap/features/messaging/presentation/messagechat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../../clothing/data/clothing_api.dart';
import '../../clothing/domain/clothing_info.dart';
import '../data/profile_api.dart';

//GPT used to learn and implement provider code for user state management.
//Mostly follows the same format as Theme Provider.
class Profile with ChangeNotifier {
  late final String id;
  late String name;
  late String bio;
  Uint8List? profilePicture;
  List<ClothingInfo>? personalListings;
  List<ChatListing> interestedListings;

  Profile({
    required this.id,
    required this.name,
    required this.bio,
    this.profilePicture,
    this.personalListings,
    List<ChatListing>? interestedListings,
    //user does not have to have personal or interested listings
  })  : interestedListings = interestedListings ?? [] {
    fetchUserDetails();
  }

  void fetchUserDetails() async {
    var futureClothes = getUsersClothes(userId: id);
    var userInfoFuture = getUser(userId: id);

    final currentUser = FirebaseAuth.instance.currentUser;

    var userInfo = await userInfoFuture;

    if (currentUser != null && currentUser.uid == id) {
      var usersMatchedFuture = getMatchedUsers();
      var matchedUsers = await usersMatchedFuture;

      int count = 0;
      for (var matchedUser in matchedUsers) {
        var messageHistory = messages[count];
        count = (count + 1) % messages.length;

        interestedListings.add(
            ChatListing(name: matchedUser.name, previewContent: messageHistory.last.messageContent,
                time: messageHistory.last.time, opened: messageHistory.last.messageType == "sender", image: MemoryImage(matchedUser.profilePicture),
                otherUserId: matchedUser.userId, currentUserId: id, messages: messageHistory)
        );
      }
    }

    if (userInfo != null) {
      bio = userInfo.bio;
      name = userInfo.name;
      profilePicture = userInfo.profilePicture;
    } else {
      bio = "";
      name = "Failed to retrieve name...";
    }

    personalListings = await futureClothes;
    notifyListeners();
  }

  Profile.fromUser(
      User user,{
        this.personalListings,
        List<ChatListing>? interestedListings,
        //user does not have to have personal or interested listings
      })  : interestedListings = interestedListings ?? []{
    id = user.uid;
    name = user.displayName ?? "Retrieving data...";
    bio = "";

    fetchUserDetails();
  }

  Future<bool> addPersonalListing(ClothingInfo listing) async {
    if (await addClothingItem(listing)) {
      personalListings ??= [];
      personalListings!.add(listing);
      notifyListeners();
      return true;
    }

    return false;
  }

  Future<bool> removePersonalListing(ClothingInfo listing) async {
    if (listing.id == null) {
      return false;
    }

    if (!(await deleteClothingItem(listing.id!))) {
      return false;
    }

    personalListings?.remove(listing);
    notifyListeners();
    return true;
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
    Uint8List? newProfilePicture,
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
    defaultProfile
  ]; // Ensure profiles are added here, currently using hardcoded profiles
  Profile _currentUser = defaultProfile;

  UserManager() {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return;
    }

    _currentUser = Profile.fromUser(currentUser);
  }

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
}

const uuid = Uuid(); //UUID generator

// Generate UUIDs for Profiles
String personalProfileUUID = uuid.v4();
String publicProfileUUID = uuid.v4();

// Generate UUIDs for ClothingItems
List<String> personalItemUUIDs = List.generate(5, (_) => uuid.v4());
List<String> publicItemUUIDs = List.generate(5, (_) => uuid.v4());

Profile defaultProfile = Profile(
  id: personalProfileUUID,
  bio: "",
  name: "Loading...",
  personalListings: [],
);

List<List<ChatMessage>> messages = [
  [
    ChatMessage(messageContent: "Hey, are you still looking to trade?", messageType: "receiver", time: "4:10pm", type: "message", senderUserId: "", receiverUserId: ""),
    ChatMessage(messageContent: "Yes, definitely! What do you have?", messageType: "sender", time: "4:12pm", type: "message", senderUserId: "", receiverUserId: ""),
    ChatMessage(messageContent: "I've got some great vintage tees.", messageType: "receiver", time: "4:15pm", type: "message", senderUserId: "", receiverUserId: ""),
  ],
  [
    ChatMessage(messageContent: "Interested in swapping sneakers?", messageType: "sender", time: "1:20pm", type: "message", senderUserId: "", receiverUserId: ""),
    ChatMessage(messageContent: "Absolutely! What size are you?", messageType: "receiver", time: "1:22pm", type: "message", senderUserId: "", receiverUserId: ""),
    ChatMessage(messageContent: "I'm a size 9.", messageType: "sender", time: "1:23pm", type: "message", senderUserId: "", receiverUserId: ""),
    ChatMessage(messageContent: "Perfect, me too. Let's see your collection!", messageType: "receiver", time: "1:25pm", type: "message", senderUserId: "", receiverUserId: ""),
  ],
  [
    ChatMessage(messageContent: "Hi there! What do you have up for trade?", messageType: "sender", time: "9:45am", type: "message", senderUserId: "", receiverUserId: ""),
    ChatMessage(messageContent: "Hi! I've got some designer jackets.", messageType: "receiver", time: "9:50am", type: "message", senderUserId: "", receiverUserId: ""),
    ChatMessage(messageContent: "Sounds interesting. Can you send some pics?", messageType: "sender", time: "9:52am", type: "message", senderUserId: "", receiverUserId: ""),
  ],
  [
    ChatMessage(messageContent: "Do you still have that leather jacket?", messageType: "receiver", time: "7:15pm", type: "message", senderUserId: "", receiverUserId: ""),
    ChatMessage(messageContent: "Yes! Are you interested?", messageType: "sender", time: "7:17pm", type: "message", senderUserId: "", receiverUserId: ""),
    ChatMessage(messageContent: "Definitely. What's your asking trade?", messageType: "receiver", time: "7:19pm", type: "message", senderUserId: "", receiverUserId: ""),
    ChatMessage(messageContent: "Looking for a good pair of boots.", messageType: "sender", time: "7:21pm", type: "message", senderUserId: "", receiverUserId: ""),
  ],
  [
    ChatMessage(messageContent: "Hey! Saw your ad, what’s still available?", messageType: "sender", time: "11:05am", type: "message", senderUserId: "", receiverUserId: ""),
    ChatMessage(messageContent: "Hi! Still have the jeans and the hoodie.", messageType: "receiver", time: "11:08am", type: "message", senderUserId: "", receiverUserId: ""),
    ChatMessage(messageContent: "Awesome, I'm interested in the jeans.", messageType: "sender", time: "11:10am", type: "message", senderUserId: "", receiverUserId: ""),
    ChatMessage(messageContent: "Cool, let's make a trade.", messageType: "receiver", time: "11:12am", type: "message", senderUserId: "", receiverUserId: ""),
  ]
];