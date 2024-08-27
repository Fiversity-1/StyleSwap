import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  //can be XFile later on but for sake of testing other listings
  ImageProvider? additionalListings;
  String type;
  //Image
  ChatMessage(
      {required this.messageContent,
      required this.messageType,
      required this.time,
      required this.type,
      this.images,
      this.additionalListings});
}

List<ChatMessage> messages = [
  ChatMessage(
      messageContent: "Hey are you keen on trading?",
      messageType: "receiver",
      type: "message",
      time: "5:45pm"),
];
