import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatListing {
  String name;
  String previewContent;
  String time;
  bool opened;
  AssetImage image;
  List<ChatMessage>? messages;

  ChatListing(
      {required this.name,
      required this.previewContent,
      required this.time,
      required this.opened,
      required this.image,
      this.messages});
}

List<ChatListing> inbox = [
  ChatListing(
      name: "Shaq",
      previewContent: "New Clothing Match!",
      time: "5:45pm",
      opened: true,
      messages: messages,
      image: const AssetImage('lib/images/1.jpg')),
  ChatListing(
      name: "Shaq",
      previewContent: "New Clothing Match!",
      time: "5:45pm",
      opened: true,
      messages: messages,
      image: const AssetImage('lib/images/4.jpg')),
  ChatListing(
      name: "Shaq",
      previewContent: "New Clothing Match!",
      time: "5:45pm",
      opened: false,
      messages: messages,
      image: const AssetImage('lib/images/2.jpg')),
  ChatListing(
      name: "Shaq",
      previewContent: "New Clothing Match!",
      time: "5:45pm",
      opened: true,
      messages: messages,
      image: const AssetImage('lib/images/3.jpg')),
];

class ChatMessage {
  final String messageContent;
  final String messageType;
  final String time;
  XFile? images;
  //Image
  ChatMessage(
      {required this.messageContent,
      required this.messageType,
      required this.time,
      this.images});
}

List<ChatMessage> messages = [
  ChatMessage(
      messageContent: "Hey are you keen on trading?",
      messageType: "receiver",
      time: "5:45pm"),
];
