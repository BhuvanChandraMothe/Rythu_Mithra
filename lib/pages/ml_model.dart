// crop_recommendation_page.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rythu_mithra/pages/crop_condition.dart';
import 'package:rythu_mithra/theme/green.dart';

class CropRecommendationPage extends StatefulWidget {
  @override
  _CropRecommendationPageState createState() => _CropRecommendationPageState();
}

class _CropRecommendationPageState extends State<CropRecommendationPage> {
  final List<String> rainfallOptions = ['Medium', 'Abundant', 'Less/No Rain'];
  final List<String> soilTypeOptions = [
    'Loamy',
    'Sandy',
    'Clay',
    'Silt',
    'Saline'
  ];
  final List<String> climateOptions = ['Temperate', 'Tropical', 'Dry'];
  final List<String> seasonOptions = ['Spring', 'Summer', 'Autumn'];

  String? selectedRainfall;
  String? selectedSoilType;
  String? selectedClimate;
  String? selectedSeason;

  List<String> recommendedCrops = [];
  String? errorMessage;

  void getRecommendations() {
    if (selectedRainfall == null ||
        selectedSoilType == null ||
        selectedClimate == null ||
        selectedSeason == null) {
      setState(() {
        errorMessage = 'Please select all options';
      });
      return;
    }

    recommendedCrops = recommendCrops(
      rainfall: selectedRainfall!,
      soilType: selectedSoilType!,
      climate: selectedClimate!,
      season: selectedSeason!,
    );

    setState(() {
      errorMessage = null;
      selectedRainfall = null;
      selectedSoilType = null;
      selectedClimate = null;
      selectedSeason = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenColor,
        title: const Text('Crop Recommendation',
            style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Please select the most relevant option based on your farm:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Rainfall',
                border: OutlineInputBorder(),
              ),
              value: selectedRainfall,
              items: rainfallOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedRainfall = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Soil Type',
                border: OutlineInputBorder(),
              ),
              value: selectedSoilType,
              items: soilTypeOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedSoilType = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Climate',
                border: OutlineInputBorder(),
              ),
              value: selectedClimate,
              items: climateOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedClimate = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Season',
                border: OutlineInputBorder(),
              ),
              value: selectedSeason,
              items: seasonOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedSeason = newValue;
                });
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: getRecommendations,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: greenColor,
              ),
              child: const Text('Get Recommendations'),
            ),
            const SizedBox(height: 20),
            if (errorMessage != null) ...[
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
              const SizedBox(height: 20),
            ],
            const Text(
              'Recommended Crops:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            for (var crop in recommendedCrops)
              Card(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    crop,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
