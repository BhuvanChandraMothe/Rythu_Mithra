// crop_recommendation_logic.dart

class CropCondition {
  final String name;
  final List<String> rainfall;
  final List<String> soilType;
  final List<String> climate;
  final List<String> season;

  CropCondition({
    required this.name,
    required this.rainfall,
    required this.soilType,
    required this.climate,
    required this.season,
  });
}

List<CropCondition> cropConditions = [
  CropCondition(
    name: 'Wheat',
    rainfall: ['Medium'],
    soilType: ['Loamy', 'Sandy'],
    climate: ['Temperate'],
    season: ['Spring', 'Autumn'],
  ),
  CropCondition(
    name: 'Rice',
    rainfall: ['Abundant'],
    soilType: ['Clay', 'Silt'],
    climate: ['Tropical'],
    season: ['Summer', 'Spring', 'Autumn'],
  ),
  CropCondition(
    name: 'Maize',
    rainfall: ['Medium', 'Less/No Rain'],
    soilType: ['Loamy', 'Sandy'],
    climate: ['Temperate', 'Dry'],
    season: ['Spring', 'Summer'],
  ),
  CropCondition(
    name: 'Barley',
    rainfall: ['Medium'],
    soilType: ['Loamy', 'Sandy'],
    climate: ['Temperate'],
    season: ['Spring'],
  ),
  CropCondition(
    name: 'Cotton',
    rainfall: ['Abundant'],
    soilType: ['Saline', 'Sandy'],
    climate: ['Tropical', 'Dry'],
    season: ['Summer'],
  ),
  CropCondition(
    name: 'Soybean',
    rainfall: ['Medium'],
    soilType: ['Loamy', 'Sandy'],
    climate: ['Temperate', 'Tropical'],
    season: ['Spring', 'Summer'],
  ),
  CropCondition(
    name: 'Sugarcane',
    rainfall: ['Abundant'],
    soilType: ['Loamy', 'Clay'],
    climate: ['Tropical', 'Temperate'],
    season: ['Spring', 'Summer'],
  ),
  CropCondition(
    name: 'Millet',
    rainfall: ['Less/No Rain'],
    soilType: ['Sandy', 'Loamy'],
    climate: ['Dry'],
    season: ['Summer'],
  ),
  CropCondition(
    name: 'Mango',
    rainfall: ['Abundant'],
    soilType: ['Loamy', 'Sandy'],
    climate: ['Tropical'],
    season: ['Spring', 'Summer'],
  ),
  CropCondition(
    name: 'Grape',
    rainfall: ['Abundant', 'Medium'],
    soilType: ['Loamy', 'Sandy'],
    climate: ['Temperate', 'Tropical'],
    season: ['Spring', 'Summer'],
  ),
  CropCondition(
    name: 'Turmeric',
    rainfall: ['Abundant'],
    soilType: ['Loamy', 'Clay'],
    climate: ['Tropical'],
    season: ['Summer', 'Autumn'],
  ),
  CropCondition(
    name: 'Peanut',
    rainfall: ['Medium'],
    soilType: ['Sandy', 'Loamy'],
    climate: ['Tropical'],
    season: ['Summer'],
  ),
  CropCondition(
    name: 'Sunflower',
    rainfall: ['Medium'],
    soilType: ['Loamy', 'Sandy'],
    climate: ['Temperate', 'Tropical'],
    season: ['Spring', 'Summer'],
  ),
  CropCondition(
    name: 'Carrot',
    rainfall: ['Medium'],
    soilType: ['Loamy', 'Sandy'],
    climate: ['Temperate'],
    season: ['Spring', 'Autumn'],
  ),
  CropCondition(
    name: 'Potato',
    rainfall: ['Medium'],
    soilType: ['Loamy', 'Sandy'],
    climate: ['Temperate'],
    season: ['Spring', 'Autumn'],
  ),
  CropCondition(
    name: 'Tomato',
    rainfall: ['Medium'],
    soilType: ['Loamy', 'Sandy'],
    climate: ['Temperate', 'Tropical'],
    season: ['Spring', 'Summer', 'Autumn'],
  ),
  CropCondition(
    name: 'Cucumber',
    rainfall: ['Abundant'],
    soilType: ['Loamy', 'Sandy'],
    climate: ['Tropical'],
    season: ['Summer'],
  ),
  CropCondition(
    name: 'Chili',
    rainfall: ['Medium'],
    soilType: ['Loamy', 'Sandy'],
    climate: ['Tropical'],
    season: ['Summer'],
  ),
  CropCondition(
    name: 'Garlic',
    rainfall: ['Less/No Rain'],
    soilType: ['Loamy', 'Sandy'],
    climate: ['Temperate'],
    season: ['Spring', 'Autumn'],
  ),
  CropCondition(
    name: 'Onion',
    rainfall: ['Medium'],
    soilType: ['Loamy', 'Sandy'],
    climate: ['Temperate', 'Tropical'],
    season: ['Spring', 'Summer'],
  ),
  CropCondition(
    name: 'Papaya',
    rainfall: ['Abundant'],
    soilType: ['Loamy', 'Sandy'],
    climate: ['Tropical'],
    season: ['Spring', 'Summer'],
  ),
  CropCondition(
    name: 'Banana',
    rainfall: ['Abundant'],
    soilType: ['Loamy', 'Silt'],
    climate: ['Tropical'],
    season: ['Spring', 'Summer'],
  ),
  CropCondition(
    name: 'Pineapple',
    rainfall: ['Abundant'],
    soilType: ['Loamy', 'Sandy'],
    climate: ['Tropical'],
    season: ['Spring', 'Summer'],
  ),
  CropCondition(
    name: 'Cabbage',
    rainfall: ['Medium'],
    soilType: ['Loamy', 'Silt'],
    climate: ['Temperate'],
    season: ['Spring', 'Autumn'],
  ),
  CropCondition(
    name: 'Cauliflower',
    rainfall: ['Medium'],
    soilType: ['Loamy', 'Silt'],
    climate: ['Temperate'],
    season: ['Spring', 'Autumn'],
  ),
];

List<String> recommendCrops({
  required String rainfall,
  required String soilType,
  required String climate,
  required String season,
}) {
  List<String> recommendations = [];

  for (var crop in cropConditions) {
    if (crop.rainfall.contains(rainfall) &&
        crop.soilType.contains(soilType) &&
        crop.climate.contains(climate) &&
        crop.season.contains(season)) {
      recommendations.add(crop.name);
    }
  }

  return recommendations;
}
