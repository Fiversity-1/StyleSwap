
import 'package:clothing_swap/features/clothing/domain/clothing_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';

class SearchQuery {
  ClothingSearch search;

  SearchQuery(this.search);

  void setSearch(ClothingSearch search) {
    this.search = search;
  }

  Future<void> searchClothes() async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // User ID
        String userId = user.uid;

        // API URL
        String url = 'https://yourapi.com/api/clothes/search/$userId';

        // Make the POST request
        http.Response response = await http.post(
          Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(data),
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

}