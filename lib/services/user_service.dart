import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:keep_in_touch/config/api_config.dart';
import 'package:keep_in_touch/models/user.dart';
import 'package:keep_in_touch/services/api_service.dart';

class UserService {
  Future<List<User>> getAllUsers() async {
    final headers = await ApiService.getHeaders();
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/users/'),
      headers: headers,
    );

    await ApiService.handleResponse(response);

    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => User.fromJson(json)).toList();
  }

  Future<User> createUser(String name, String password, String role) async {
    final headers = await ApiService.getHeaders();
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}/users/register'),
      headers: headers,
      body: jsonEncode({
        'name': name,
        'password': password,
        'role': role,
      }),
    );

    await ApiService.handleResponse(response);
    return User.fromJson(jsonDecode(response.body));
  }

  Future<User> updateUser(int userId, String name, String role, {String? password}) async {
    final headers = await ApiService.getHeaders();
    final body = <String, dynamic>{
      'name': name,
      'role': role,
    };
    if (password != null && password.isNotEmpty) {
      body['password'] = password;
    }
    final response = await http.put(
      Uri.parse('${ApiConfig.baseUrl}/users/$userId'),
      headers: headers,
      body: jsonEncode(body),
    );

    await ApiService.handleResponse(response);
    return User.fromJson(jsonDecode(response.body));
  }

  Future<void> deleteUser(int userId) async {
    final headers = await ApiService.getHeaders();
    final response = await http.delete(
      Uri.parse('${ApiConfig.baseUrl}/users/$userId'),
      headers: headers,
    );

    await ApiService.handleResponse(response);
  }
}
