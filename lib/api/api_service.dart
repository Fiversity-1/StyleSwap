import 'dart:convert';
import 'package:http/http.dart' as http;

const String _baseUrl = 'https://deco3801-fiversityplus1.uqcloud.net/api';

class ApiService {
  final http.Client client;

  ApiService({http.Client? client}) : client = client ?? http.Client();

  // Example method to fetch data
  Future<Map<String, dynamic>> fetchData(String endpoint) async {
    final response = await client.get(Uri.parse('$_baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  // Example method to post data
  Future<Map<String, dynamic>> postData(String endpoint, Map<String, dynamic> data) async {
    final response = await client.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to post data');
    }
  }

  // Health check
  Future<Map<String, dynamic>> health() async {
    final response = await client.get(Uri.parse('$_baseUrl/health'));
    return json.decode(response.body);
  }

  // Post a new user
  Future<Map<String, dynamic>> postUser(Map<String, dynamic> data) async {
    return postData('users', data);
  }
}
