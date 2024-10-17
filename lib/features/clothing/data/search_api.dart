import 'dart:convert';

import 'package:clothing_swap/features/preferences/domain/clothing_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../domain/clothing_info.dart';

/// Searches for clothing items with the given search parameters.
Future<List<dynamic>> searchClothes(ClothingSearch search) async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User ID
      String userId = user.uid;

      // API URL
      String url =
          'https://deco3801-fiversityplus1.uqcloud.net/api/clothes/search/$userId?amount=10';

      var encodedData = jsonEncode(search.getData());

      // Make the POST request
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: encodedData,
      );

      // Check the response status
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Request successful: ${response.body}');
        }
        return convertApiResponseToClothingInfo(jsonDecode(response.body));
      } else {
        if (kDebugMode) {
          print('Request failed with status: ${response.statusCode}');
        }
      }
    } else {
      if (kDebugMode) {
        print('No user is signed in.');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error: $e');
    }
  }

  return [];
}
