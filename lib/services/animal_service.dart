import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:keep_in_touch/config/api_config.dart';
import 'package:keep_in_touch/models/animal.dart';
import 'package:keep_in_touch/services/api_service.dart';

class AnimalService {
  Future<List<Animal>> getAnimals() async {
    final headers = await ApiService.getHeaders();
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/animals/'),
      headers: headers,
    );

    await ApiService.handleResponse(response);

    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Animal.fromJson(json)).toList();
  }

  Future<Animal> getAnimal(int animalId) async {
    final headers = await ApiService.getHeaders();
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/animals/$animalId'),
      headers: headers,
    );

    await ApiService.handleResponse(response);
    return Animal.fromJson(jsonDecode(response.body));
  }

  List<Animal> filterAnimals(List<Animal> animals, String filter) {
    switch (filter) {
      case 'created':
        return animals
            .where((animal) => animal.formStatus.toLowerCase() == 'created')
            .toList();
      case 'sent':
        return animals
            .where((animal) => animal.formStatus.toLowerCase() == 'sent')
            .toList();
      case 'filled':
        return animals
            .where((animal) => animal.formStatus.toLowerCase() == 'filled')
            .toList();
      case 'controlled':
        return animals
            .where((animal) => animal.formStatus.toLowerCase() == 'controlled')
            .toList();
      default:
        return animals;
    }
  }

  Future<Animal> updateAnimal(int animalId, Map<String, dynamic> data) async {
    final headers = await ApiService.getHeaders();
    final response = await http.put(
      Uri.parse('${ApiConfig.baseUrl}/animals/$animalId'),
      headers: headers,
      body: jsonEncode(data),
    );

    await ApiService.handleResponse(response);
    return Animal.fromJson(jsonDecode(response.body));
  }
}