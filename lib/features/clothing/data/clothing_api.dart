import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../domain/clothing_info.dart';

/// Encodes a list of images (byte arrays) and encodes them in base64.
Future<List<String>> getImageBase64(List<Uint8List> images) async {
  return images.map((image) {
    return base64Encode(image);
  }).toList();
}

/// Decode a list of images from base64 strings to byte arrays.
Future<List<Uint8List>> decodeImageBase64(List<String> base64Strings) async {
  return base64Strings.map((base64Str) {
    return base64Decode(base64Str);
  }).toList();
}

/// Add the given clothing item.
Future<bool> addClothingItem(ClothingInfo clothingInfo) async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User ID
      String userId = user.uid;

      // API URL
      String url =
          'https://deco3801-fiversityplus1.uqcloud.net/api/clothes/$userId';

      // Create a map for all the data of the item to encode as a string.
      final Map<String, dynamic> data = {
        'colour': clothingInfo.colours
            ?.map((c) => c.getDatabaseRepresentation())
            .toList(),
        'size': clothingInfo.size?.getDatabaseRepresentation(),
        'condition': clothingInfo.condition?.getDatabaseRepresentation(),
        'gender': clothingInfo.gender?.getDatabaseRepresentation(),
        'type': clothingInfo.type?.getDatabaseRepresentation(),
        'bio': clothingInfo.description,
        'images': await getImageBase64(clothingInfo.images),
      };
      var encodedData = jsonEncode(data);

      // Make the POST request
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: encodedData,
      );

      // Check the response status
      if (response.statusCode == 201) {
        if (kDebugMode) {
          print('Request successful: ${response.body}');
        }
        return true;
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

  return false;
}

/// Gets the list of clothing items owned by a user.
Future<List<ClothingInfo>> getUsersClothes({String? userId}) async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null || userId != null) {
      // User ID
      userId ??= user!.uid;

      // API URL
      String url =
          'https://deco3801-fiversityplus1.uqcloud.net/api/clothes/$userId';

      // Make the GET request
      http.Response response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
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

/// Deletes the clothing item with the given id
Future<bool> deleteClothingItem(String id) async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User ID
      String userId = user.uid;

      // API URL
      String url =
          'https://deco3801-fiversityplus1.uqcloud.net/api/clothes/$userId/$id';

      // Make the DELETE request
      http.Response response = await http.delete(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
      });

      // Check the response status
      if (response.statusCode == 203) {
        if (kDebugMode) {
          print('Request successful: ${response.body}');
        }
        return true;
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

  return false;
}
