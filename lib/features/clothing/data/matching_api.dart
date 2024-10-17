import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

import '../domain/clothing_info.dart';

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
      if (response.statusCode == 200) { // Success and matched
        print('Request successful: ${response.body}');
        return liked;
      } else if (response.statusCode == 201) { // Success but no match
        print('Request successful: ${response.body}');
        return false;
      } {
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

class MatchedUserResponse {
  final String userId;
  final String name;
  final Uint8List profilePicture;

  MatchedUserResponse(this.userId, this.name, this.profilePicture);
}

/// Get the user ids where there is a match with a user
Future<List<MatchedUserResponse>> getMatchedUsers() async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User ID
      String userId = user.uid;

      // API URL
      String url = 'https://deco3801-fiversityplus1.uqcloud.net/api/match/$userId';

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

        var data = await jsonDecode(response.body);
        return data.map<MatchedUserResponse>((elem) => MatchedUserResponse(elem['userId'], elem['name'], base64Decode(elem['image']))).toList();
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

class MatchedClothing {
  List<ClothingInfo> othersTrades;
  List<ClothingInfo> ourTrades;

  MatchedClothing(this.othersTrades, this.ourTrades);
}

/// Get the clothing items that users have matched on
Future<MatchedClothing?> getMatchedClothing(String otherUserId) async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User ID
      String userId = user.uid;

      // API URL
      String url = 'https://deco3801-fiversityplus1.uqcloud.net/api/clothes/match/$userId/$otherUserId';

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

        var data = await jsonDecode(response.body);
        return MatchedClothing(
          await convertApiResponseToClothingInfo(data['toRecv']),
            await convertApiResponseToClothingInfo(data['toTrade'])
        );
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