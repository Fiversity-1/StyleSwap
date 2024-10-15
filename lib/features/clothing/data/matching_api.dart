import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

/// Likes/dislikes the given clothing item.
/// Returns true if it is a match, otherwise false.
Future<bool> likeDislikeItem(String clothingId, bool liked) async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User ID
      String userId = user.uid;

      // API URL
      String url = 'https://deco3801-fiversityplus1.uqcloud.net/api/clothes/like/$userId/$clothingId?Like=$liked';

      // Make the GET request
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      // Check the response status
      if (response.statusCode == 200) {
        print('Request successful: ${response.body}');
        return liked;
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