
import 'dart:convert';

import 'package:clothing_swap/features/clothing/domain/clothing_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

Future<bool> addUser(String lat, String long, String bio) async {
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
        print('User does not exists or error: ${response.statusCode}');
      }
    } else {
      print('No user is signed in.');
    }
  } catch (e) {
    print('Error: $e');
  }

  return false;
}