import 'package:catbreeds/cats/data/datasources/dtos/cat_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CatDto', () {
    test('successfully parses from full json map', () {
      final json = <String, dynamic>{
        'id': 'abys',
        'name': 'Abyssinian',
        'species_id': '1',
        'life_span': '14-17',
        'temperament': 'Active, Energetic, Independent, Intelligent',
        'origin': 'Egypt',
        'country_codes': 'EG',
        'country_code': 'EG',
        'description':
            'Medium-sized, elegant cat with a distinctive ticked coat pattern.',
        'bred_for': null,
        'perfect_for': null,
        'breed_group': 'Short-haired',
        'history': 'One of the oldest known cat breeds.',
        'reference_image_id': 'KWdLHmOqc',
        'weight': {
          'imperial': '8-12',
          'metric': '3.6-5.4',
        },
        'height': {
          'imperial': '10-12',
          'metric': '25-30',
        },
        'image': {
          'id': 'KWdLHmOqc',
          'url': 'https://cdn2.thecatapi.com/images/KWdLHmOqc.jpg',
          'width': 3114,
          'height': 2609,
        },
      };

      final dto = CatDto.fromJson(json);

      expect(dto.id, equals('abys'));
      expect(dto.name, equals('Abyssinian'));
      expect(dto.speciesId, equals('1'));
      expect(dto.lifeSpan, equals('14-17'));
      expect(
        dto.temperament,
        equals('Active, Energetic, Independent, Intelligent'),
      );
      expect(dto.origin, equals('Egypt'));
      expect(dto.countryCodes, equals('EG'));
      expect(dto.countryCode, equals('EG'));
      expect(dto.description, contains('elegant cat'));
      expect(dto.bredFor, isNull);
      expect(dto.perfectFor, isNull);
      expect(dto.breedGroup, equals('Short-haired'));
      expect(dto.history, equals('One of the oldest known cat breeds.'));
      expect(dto.referenceImageId, equals('KWdLHmOqc'));
      expect(dto.weight.imperial, equals('8-12'));
      expect(dto.weight.metric, equals('3.6-5.4'));
      expect(dto.height.imperial, equals('10-12'));
      expect(dto.height.metric, equals('25-30'));
      expect(dto.image?.id, equals('KWdLHmOqc'));
      expect(
        dto.image?.url,
        equals('https://cdn2.thecatapi.com/images/KWdLHmOqc.jpg'),
      );
      expect(dto.image?.width, equals(3114));
      expect(dto.image?.height, equals(2609));
    });

    test('successfully parses json with null or omitted optional fields', () {
      final json = <String, dynamic>{
        'id': 'ring',
        'name': 'American Ringtail',
        'species_id': '1',
        'life_span': '15-20',
        'temperament': 'Playful, Loving',
        'description': 'Cat with curled tail.',
        'origin': null,
        'country_codes': null,
        'country_code': null,
        'bred_for': null,
        'perfect_for': null,
        'breed_group': null,
        'history': null,
        'reference_image_id': null,
        'weight': {
          'imperial': '7-15',
          'metric': '3-7',
        },
        'height': {
          'imperial': '8-10',
          'metric': '20-25',
        },
        'image': null,
      };

      final dto = CatDto.fromJson(json);

      expect(dto.id, equals('ring'));
      expect(dto.name, equals('American Ringtail'));
      expect(dto.image, isNull);
      expect(dto.referenceImageId, isNull);
      expect(dto.origin, isNull);
      expect(dto.breedGroup, isNull);
    });

    test('serializes to json and back correctly', () {
      const dto = CatDto(
        id: 'abys',
        name: 'Abyssinian',
        speciesId: '1',
        lifeSpan: '14-17',
        temperament: 'Active',
        origin: 'Egypt',
        countryCodes: 'EG',
        countryCode: 'EG',
        description: 'Medium-sized cat',
        weight: CatWeightDto(imperial: '8-12', metric: '3.6-5.4'),
        height: CatHeightDto(imperial: '10-12', metric: '25-30'),
        image: CatImageDto(
          id: 'img1',
          url: 'https://example.com/img.jpg',
          width: 800,
          height: 600,
        ),
      );

      final json = dto.toJson();
      expect(json['id'], equals('abys'));
      expect(json['species_id'], equals('1'));
      expect(json['life_span'], equals('14-17'));

      final parsed = CatDto.fromJson(json);
      expect(parsed.id, equals(dto.id));
      expect(parsed.weight.imperial, equals(dto.weight.imperial));
      expect(parsed.image?.url, equals(dto.image?.url));
    });
  });
}
