import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // Import Geolocator package
import 'package:http/http.dart' as http; // Import http package
import 'package:permission_handler/permission_handler.dart'; // Import permission handler package

class WeatherContainer extends StatefulWidget {
  const WeatherContainer({Key? key}) : super(key: key);

  @override
  _WeatherContainerState createState() => _WeatherContainerState();
}

class _WeatherContainerState extends State<WeatherContainer> {
  String _location = 'Loading...'; // Variable to store location
  String _weatherDescription = ''; // Variable to store weather description
  String _temperature = ''; // Variable to store temperature

  @override
  void initState() {
    super.initState();
    _checkPermissions(); // Check for permissions when widget is initialized
  }

  // Function to check location permissions
  Future<void> _checkPermissions() async {
    var status = await Permission.location.status;
    if (status.isGranted) {
      _fetchWeatherData();
    } else if (status.isDenied) {
      await Permission.location.request();
      _fetchWeatherData();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  // Function to fetch weather data
  Future<void> _fetchWeatherData() async {
    try {
      // Get current location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Fetch weather data using latitude and longitude
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&appid=e0c9b6ff1e01f2a9fe6aa3e4a23c7083'));

      if (response.statusCode == 200) {
        // Parse weather data from response
        var data = json.decode(response.body);
        String location = data['name'];
        String weatherDescription = data['weather'][0]['description'];
        double temperature =
            data['main']['temp'] - 273.15; // Convert temperature to Celsius

        // Update weather data strings
        setState(() {
          _location = location;
          _weatherDescription = weatherDescription[0].toUpperCase() +
              weatherDescription.substring(1);
          _temperature = '${temperature.toStringAsFixed(1)}°C';
        });
      } else {
        // Display error message if unable to fetch weather data
        setState(() {
          _location = 'Failed to fetch location';
          _weatherDescription = '';
          _temperature = '';
        });
      }
    } catch (e) {
      // Handle exceptions such as permissions issues
      setState(() {
        _location = 'Error fetching weather data';
        _weatherDescription = '';
        _temperature = '';
      });
    }
  }

  // Function to get weather icon based on weather description
  IconData _getWeatherIcon(String description) {
    if (description.contains('clear')) {
      return Icons.wb_sunny;
    } else if (description.contains('clouds')) {
      return Icons.cloud;
    } else if (description.contains('rain')) {
      return Icons.beach_access;
    } else if (description.contains('snow')) {
      return Icons.ac_unit;
    } else {
      return Icons.wb_cloudy;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 134, 208, 225),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          // Weather icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              _getWeatherIcon(_weatherDescription.toLowerCase()),
              color: Colors.white,
              size: 50,
            ),
          ),
          SizedBox(width: 150),
          // Weather details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _location,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(height: 8),
              Text(
                _weatherDescription,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              SizedBox(height: 8),
              Text(
                _temperature,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
