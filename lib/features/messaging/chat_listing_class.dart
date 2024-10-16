import 'package:clothing_swap/features/profile/presentation/profile_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../clothing/data/matching_api.dart';
import '../clothing/domain/clothing_info.dart';
//GPT used to this implement this page for state management of ChatListings
//ChatListings have a list of ChatMessages

class ChatListing extends ChangeNotifier {
  final String id;
  String name;
  String previewContent;
  String time;
  bool opened;
  ImageProvider image;
  List<ChatMessage> messages;
  final String otherUserId;
  final String currentUserId;
  bool _fetching = false;
  MatchedClothing? _trades;

  MatchedClothing? get trades {
    if (!_fetching && _trades == null) {
      fetchTradeItems();
    }

    return _trades;
  }
  set trades(MatchedClothing? value) {
    _trades = value;
    notifyListeners();
  }

    ChatListing({
    String? id,
    required this.name,
    required this.previewContent,
    required this.time,
    required this.opened,
    required this.image,
    required this.otherUserId,
    required this.currentUserId,
    List<ChatMessage>? messages,
  })  : id = id ?? const Uuid().v4(),
        messages = messages ?? [];

  Future<void> fetchTradeItems() async {
    _fetching = true;
    _trades = await getMatchedClothing(otherUserId);
    notifyListeners();
  }

  //Update whenever chat opened
  void updatePreview(String content, String timestamp) {
    previewContent = content;
    time = timestamp;
  }

  void addMessage(ChatMessage message) {
    messages.add(message);
    updatePreview(message.messageContent, message.time);
  }
}

class ChatManager with ChangeNotifier {
  final UserManager userManager;

  List<ChatListing> _chats = [];
  String? _selectedChatId;

  ChatManager(this.userManager) {
    _initializeChats();
  }
  //Determine id of current chat opened
  List<ChatListing> get chats => _chats;
  ChatListing? get selectedChat {
    if (_selectedChatId == null) return null;
    try {
      return _chats.firstWhere((chat) => chat.id == _selectedChatId!);
    } catch (e) {
      return null;
    }
  }

  ChatListing? findChatByUserId(String userId) {
    try {
      return _chats.firstWhere((chat) => chat.otherUserId == userId);
    } catch (e) {
      return null; // Return null if no match is found
    }
  }

  void _initializeChats() {
    final currentUser = userManager.currentUser;
    _chats = currentUser.interestedListings;
    notifyListeners();
  }

  void addChat(ChatListing chat) {
    _chats.add(chat);
    notifyListeners();
  }

  void removeChat(String chatId) {
    _chats.removeWhere((chat) => chat.id == chatId);
    notifyListeners();
  }

  void addChatMessage(String chatId, ChatMessage message) {
    final chat = _chats.firstWhere((chat) => chat.id == chatId);
    chat.addMessage(message);
    notifyListeners();
  }

  //Determine whether in-chat proposed trade is accepted
  void updateTradeAcceptance(String chatId, String messageId) {
    final chat = _chats.firstWhere((chat) => chat.id == chatId);
    final message = chat.messages.firstWhere((msg) => msg.id == messageId);
    message.accepted = !(message.accepted ?? false); // Toggle acceptance
    notifyListeners();
  }

  //Determine whether in-chat proposed trade is declined
  void updateTradeDecline(String chatId, String messageId) {
    final chat = _chats.firstWhere((chat) => chat.id == chatId);
    final message = chat.messages.firstWhere((msg) => msg.id == messageId);
    message.declined = !(message.declined ?? false); // Toggle decline
    notifyListeners();
  }

  //update time and string preview when chat opened
  void setChatOpened(
      String chatId, bool opened, String preview, String timestamp) {
    final chat = _chats.firstWhere((chat) => chat.id == chatId);
    chat.opened = opened;
    chat.updatePreview(preview, timestamp);
    notifyListeners();
  }

  void selectChat(String chatId) {
    _selectedChatId = chatId;
    notifyListeners();
  }
}

//Chat message class
class ChatMessage {
  final String id; // Unique identifier for each message
  final String messageContent;
  final String messageType;
  final String time;
  XFile? images;
  ImageProvider? additionalListings;
  bool? accepted;
  bool? declined;
  final String type;
  final String senderUserId; // ID of the user who sent the message
  final String receiverUserId; // ID of the user who received the message

  ChatMessage({
    String? id, // Optional id parameter
    required this.messageContent,
    required this.messageType,
    required this.time,
    required this.type,
    required this.senderUserId,
    required this.receiverUserId,
    this.images,
    this.additionalListings,
    this.accepted,
    this.declined,
  }) : id = id ?? const Uuid().v4(); // Generate a unique ID if not provided
}
