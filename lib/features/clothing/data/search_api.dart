
import 'dart:convert';

import 'package:clothing_swap/features/preferences/domain/clothing_search.dart';
import 'package:clothing_swap/features/clothing/presentation/clothing_item_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../domain/clothing_info.dart';

Future<List<dynamic>> searchClothes(ClothingSearch search) async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User ID
      String userId = user.uid;

      // API URL
      String url = 'https://deco3801-fiversityplus1.uqcloud.net/api/clothes/search/$userId';

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
        print('Request successful: ${response.body}');
        return convertApiResponseToClothingInfo(jsonDecode(response.body));
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } else {
      print('No user is signed in.');
    }
  } catch (e) {
    print('Error: $e');
  }

  return [];
}