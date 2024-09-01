import 'package:api_task/weather_api.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final WeatherService weatherService = WeatherService(
    baseUrl: 'https://api.openweathermap.org/data/2.5/weather',
    apiKey: '8f5e7b7be2f8a98b42cf6381eda02109',
  );

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Weather App')),
        body: WeatherScreen(weatherService: weatherService),
      ),
    );
  }
}

class WeatherScreen extends StatefulWidget {
  final WeatherService weatherService;

  const WeatherScreen({super.key, required this.weatherService});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Map<String, dynamic>? weatherData;

  void fetchWeather() async {
    try {
      final data = await widget.weatherService.getWeather('Karachi');
      print(data);
      setState(() {
        weatherData = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: weatherData == null
          ? const CircularProgressIndicator()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://openweathermap.org/img/wn/${weatherData!['weather'][0]['icon']}@2x.png',
                ),
                Text(
                  'City Name: ${weatherData!['name']}',
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Temperature in Celsius: ${weatherData!['main']['temp']}°C',
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Weather: ${weatherData!['weather'][0]['description']}',
                  style: const TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
    );
  }
}
