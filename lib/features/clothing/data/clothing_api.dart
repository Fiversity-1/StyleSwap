
import 'dart:convert';
import 'dart:typed_data';

import 'package:clothing_swap/features/clothing/domain/clothing_search.dart';
import 'package:clothing_swap/features/clothing/presentation/clothing_item_class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../domain/clothing_info.dart';

Future<List<String>> getImageBase64(List<Uint8List> images) async {
  return images.map((image) {
    return base64Encode(image);
  }).toList();
}

Future<List<Uint8List>> decodeImageBase64(List<String> base64Strings) async {
  return base64Strings.map((base64Str) {
    return base64Decode(base64Str);
  }).toList();
}

Future<bool> addClothingItem(ClothingInfo clothingInfo) async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User ID
      String userId = user.uid;

      // API URL
      String url = 'https://deco3801-fiversityplus1.uqcloud.net/api/clothes/$userId';
      
      final Map<String, dynamic> data ={
        'colour': clothingInfo.colours?.map((c) => c.getDatabaseRepresentation()).toList(),
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


Future<List<ClothingInfo>> getUsersClothes() async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User ID
      String userId = user.uid;

      // API URL
      String url = 'https://deco3801-fiversityplus1.uqcloud.net/api/clothes/$userId';

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


Future<bool> deleteClothingItem(String id) async {
  try {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // User ID
      String userId = user.uid;

      // API URL
      String url = 'https://deco3801-fiversityplus1.uqcloud.net/api/clothes/$userId/$id';

      // Make the DELETE request
      http.Response response = await http.delete(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        }
      );

      // Check the response status
      if (response.statusCode == 203) {
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