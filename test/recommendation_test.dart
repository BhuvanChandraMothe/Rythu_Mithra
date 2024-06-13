import 'package:flutter_test/flutter_test.dart';
import 'package:rythu_mithra/pages/crop_condition.dart';

void main() {
  group('Crop Recommendation Logic', () {
    test(
        'should recommend Wheat for Medium rainfall, Loamy soil, Temperate climate, Spring season',
        () {
      List<String> result = recommendCrops(
        rainfall: 'Medium',
        soilType: 'Loamy',
        climate: 'Temperate',
        season: 'Spring',
      );
      expect(result, contains('Wheat'));
    });

    test(
        'should not recommend Rice for Less/No Rain, Sandy soil, Dry climate, Autumn season',
        () {
      List<String> result = recommendCrops(
        rainfall: 'Less/No Rain',
        soilType: 'Sandy',
        climate: 'Dry',
        season: 'Autumn',
      );
      expect(result, isEmpty);
    });

    test('should recommend multiple crops for suitable conditions', () {
      List<String> result = recommendCrops(
        rainfall: 'Medium',
        soilType: 'Loamy',
        climate: 'Temperate',
        season: 'Spring',
      );
      expect(result, containsAll(['Wheat', 'Barley', 'Soybean']));
    });

    test('should recommend empty list for no matching conditions', () {
      List<String> result = recommendCrops(
        rainfall: 'Less/No Rain',
        soilType: 'Saline',
        climate: 'Tropical',
        season: 'Winter',
      );
      expect(result, isEmpty);
    });
  });
}
