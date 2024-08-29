import 'package:clothing_swap/features/profile/presentation/profile_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

//Original code modified to implement provider ChatGPT
class ChatListing {
  final String id; // Unique identifier for each chat
  String name;
  String previewContent;
  String time;
  bool opened;
  AssetImage image;
  List<ChatMessage> messages;

  ChatListing({
    required this.id, // Initialize the id field
    required this.name,
    required this.previewContent,
    required this.time,
    required this.opened,
    required this.image,
    List<ChatMessage>? messages,
  }) : messages = messages ?? [];
}

class ChatManager with ChangeNotifier {
  final UserManager userManager; // Reference to UserManager

  List<ChatListing> _chats =
      []; // This list should be derived from the current user

  ChatManager(this.userManager) {
    // Initialize _chats with the current user's chat listings
    _initializeChats();
  }

  List<ChatListing> get chats => _chats;

  void _initializeChats() {
    final currentUser = userManager.currentUser;
    _chats = currentUser.interestedListings;
    notifyListeners();
  }

  void addChat(ChatListing chat) {
    _chats.add(chat);
    notifyListeners();
  }

  void removeChat(ChatListing chat) {
    _chats.remove(chat);
    notifyListeners();
  }

  void updateChatMessage(String chatId, ChatMessage message) {
    final chat = _chats.firstWhere((chat) => chat.id == chatId);
    chat.messages.add(message);
    chat.previewContent = message.messageContent.substring(0, 5);
    chat.time = message.time;
    notifyListeners();
  }

  void setChatOpened(String chatId, bool opened) {
    final chat = _chats.firstWhere((chat) => chat.id == chatId);
    chat.opened = opened;
    notifyListeners();
  }
}

class ChatMessage {
  final String messageContent;
  final String messageType;
  final String time;
  XFile? images;
  //can be XFile later on but for sake of testing other listings
  ImageProvider? additionalListings;
  bool? accepted;
  bool? declined;
  final String type;
  //Image
  ChatMessage(
      {required this.messageContent,
      required this.messageType,
      required this.time,
      required this.type,
      this.images,
      this.additionalListings,
      this.accepted,
      this.declined});
}

List<ChatMessage> messages = [
  ChatMessage(
      messageContent: "Hey are you keen on trading?",
      messageType: "receiver",
      type: "message",
      time: "5:45pm"),
];
