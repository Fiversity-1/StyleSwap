import 'package:flutter/material.dart';

class Event {
  final String company;
  final String image;
  final String title;
  final String date;
  final String time;
  final String details;
  final String location;
  final String city;
  int attendance;
  Event(
      {required this.title,
      required this.company,
      required this.image,
      required this.details,
      required this.date,
      required this.time,
      required this.location,
      required this.attendance,
      required this.city});
}

List<Event> communityEvents = [
  Event(
      company: 'Jacob',
      image: 'lib/images/op.jpg',
      details: 'Bring hats!',
      title: 'Clothes Swap',
      date: '4/5/24',
      time: '5pm',
      location: '17 River Street, Brisbane',
      city: "Brisbane",
      attendance: 4),
  Event(
      company: 'Jacob',
      image: 'lib/images/op2.jpg',
      details: 'Bring hats!',
      title: 'Clothes Swap',
      date: '4/5/24',
      time: '5pm',
      location: '17 River Street, Brisbane',
      city: "Brisbane",
      attendance: 4),
  Event(
      company: 'Jacob',
      image: 'lib/images/op3.jpg',
      details: 'Bring hats!',
      title: 'Clothes Swap',
      date: '4/5/24',
      time: '5pm',
      location: '17 River Street, Brisbane',
      city: "Brisbane",
      attendance: 4),
  Event(
      company: 'Jacob',
      image: 'lib/images/op4.jpg',
      details: 'Bring hats!',
      title: 'Clothes Swap',
      date: '4/5/24',
      time: '5pm',
      location: '17 River Street, Brisbane',
      city: "Brisbane",
      attendance: 4),
];
