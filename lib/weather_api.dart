import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String baseUrl;
  final String apiKey;

  WeatherService({required this.baseUrl, required this.apiKey});

  Future<Map<String, dynamic>> getWeather(String city) async {
    final response = await http.get(
      Uri.parse('$baseUrl?q=$city&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else if (response.statusCode == 404) {
      throw Exception('City not found');
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
