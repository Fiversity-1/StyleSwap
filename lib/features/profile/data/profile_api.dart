
import 'dart:convert';
import 'dart:typed_data';

import 'package:clothing_swap/features/clothing/data/clothing_api.dart';
import 'package:clothing_swap/features/preferences/domain/clothing_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../../clothing/presentation/clothing_item_class.dart';

Future<bool> addUser(String lat, String long, String bio, Uint8List profile) async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User ID
      String userId = user.uid;

      // API URL
      String url = 'https://deco3801-fiversityplus1.uqcloud.net/api/user/$userId';

      // Make the POST request
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "lat": lat,
          "lon": long,
          "bio": bio,
          "name": user.displayName ?? "Anonymous",
          "image": base64Encode(profile)
        }),
      );

      // Check the response status
      if (response.statusCode == 201) {
        print('Request successful: ${response.body}');
        return true;
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } else {
      print('No user is signed in.');
    }
  } catch (e) {
    print('Error: $e');
  }

  return false;
}


Future<bool> isUserRegistered() async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User ID
      String userId = user.uid;

      // API URL
      String url = 'https://deco3801-fiversityplus1.uqcloud.net/api/user/$userId';

      // Make the POST request
      http.Response response = await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
          }
      );

      // Check the response status
      if (response.statusCode == 200) {
        print('User exists');
        return true;
      } else {
        print('User does not exist or error: ${response.statusCode}');
      }
    } else {
      print('No user is signed in.');
    }
  } catch (e) {
    print('Error: $e');
  }

  return false;
}

class UserInfo {
  final String name;
  final String bio;
  final List<ClothingItem> matchedItems;
  final Uint8List profilePicture;

  UserInfo(this.name, this.bio, this.matchedItems, this.profilePicture);
}

Future<UserInfo?> getUser({String? userId}) async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null || userId != null) {
      // User ID
      userId ??= user!.uid;

      // API URL
      String url = 'https://deco3801-fiversityplus1.uqcloud.net/api/user/$userId';

      // Make the POST request
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        }
      );

      // Check the response status
      if (response.statusCode == 200) {
        print('Request successful: ${response.body}');
        var body = jsonDecode(response.body);
        return UserInfo(body['name'].toString(), body['bio'].toString(), [], base64Decode(body['image'].toString()));
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } else {
      print('No user is signed in.');
    }
  } catch (e) {
    print('Error: $e');
  }

  return null;
}


Future<void> blockUser(String userIdToBlock) async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User ID
      String userId = user.uid;

      // API URL
      String url = 'https://deco3801-fiversityplus1.uqcloud.net/api/user/block/$userId/$userIdToBlock';

      // Make the POST request
      http.Response response = await http.get(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
          }
      );

      // Check the response status
      if (response.statusCode == 200) {
        print('Request successful: ${response.body}');
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } else {
      print('No user is signed in.');
    }
  } catch (e) {
    print('Error: $e');
  }
}