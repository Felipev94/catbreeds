import 'package:catbreeds/cats/data/datasources/dtos/cat_dto.dart';
import 'package:catbreeds/cats/data/repositories/entities/cat.dart';
import 'package:catbreeds/cats/data/repositories/mappers/cat_dto_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CatDtoMapper Test', () {
    test('CatWeightDto.toEntity maps all fields correctly', () {
      const dto = CatWeightDto(imperial: '8-12', metric: '3.6-5.4');
      final entity = dto.toEntity();

      expect(entity, isA<CatWeight>());
      expect(entity.imperial, equals('8-12'));
      expect(entity.metric, equals('3.6-5.4'));
    });

    test('CatHeightDto.toEntity maps all fields correctly', () {
      const dto = CatHeightDto(imperial: '10-12', metric: '25-30');
      final entity = dto.toEntity();

      expect(entity, isA<CatHeight>());
      expect(entity.imperial, equals('10-12'));
      expect(entity.metric, equals('25-30'));
    });

    test('CatImageDto.toEntity maps all fields correctly', () {
      const dto = CatImageDto(
        id: 'img_1',
        url: 'https://cdn.example.com/cat.jpg',
        width: 1200,
        height: 800,
      );
      final entity = dto.toEntity();

      expect(entity, isA<CatImage>());
      expect(entity.id, equals('img_1'));
      expect(entity.url, equals('https://cdn.example.com/cat.jpg'));
      expect(entity.width, equals(1200));
      expect(entity.height, equals(800));
    });

    test('CatDto.toEntity maps full cat DTO to Cat entity', () {
      const dto = CatDto(
        id: 'abys',
        name: 'Abyssinian',
        speciesId: '1',
        lifeSpan: '14-17',
        temperament: 'Active, Energetic',
        description: 'Medium cat',
        origin: 'Egypt',
        countryCodes: 'EG',
        countryCode: 'EG',
        bredFor: null,
        perfectFor: null,
        breedGroup: 'Short-haired',
        history: 'Oldest known cat breed',
        referenceImageId: 'img_ref_1',
        weight: CatWeightDto(imperial: '8-12', metric: '3.6-5.4'),
        height: CatHeightDto(imperial: '10-12', metric: '25-30'),
        image: CatImageDto(
          id: 'img_1',
          url: 'https://cdn.example.com/cat.jpg',
          width: 1200,
          height: 800,
        ),
      );

      final entity = dto.toEntity();

      expect(entity, isA<Cat>());
      expect(entity.id, equals('abys'));
      expect(entity.name, equals('Abyssinian'));
      expect(entity.speciesId, equals('1'));
      expect(entity.lifeSpan, equals('14-17'));
      expect(entity.temperament, equals('Active, Energetic'));
      expect(entity.description, equals('Medium cat'));
      expect(entity.origin, equals('Egypt'));
      expect(entity.countryCodes, equals('EG'));
      expect(entity.countryCode, equals('EG'));
      expect(entity.bredFor, isNull);
      expect(entity.perfectFor, isNull);
      expect(entity.breedGroup, equals('Short-haired'));
      expect(entity.history, equals('Oldest known cat breed'));
      expect(entity.referenceImageId, equals('img_ref_1'));
      expect(entity.weight.imperial, equals('8-12'));
      expect(entity.weight.metric, equals('3.6-5.4'));
      expect(entity.height.imperial, equals('10-12'));
      expect(entity.height.metric, equals('25-30'));
      expect(entity.image, isNotNull);
      expect(entity.image?.id, equals('img_1'));
      expect(entity.image?.url, equals('https://cdn.example.com/cat.jpg'));
      expect(entity.image?.width, equals(1200));
      expect(entity.image?.height, equals(800));
    });

    test('CatDto.toEntity maps nullable image as null', () {
      const dto = CatDto(
        id: 'ring',
        name: 'American Ringtail',
        speciesId: '1',
        lifeSpan: '15-20',
        temperament: 'Loving',
        description: 'Curled tail cat',
        weight: CatWeightDto(imperial: '7-15', metric: '3-7'),
        height: CatHeightDto(imperial: '8-10', metric: '20-25'),
        image: null,
      );

      final entity = dto.toEntity();

      expect(entity.id, equals('ring'));
      expect(entity.image, isNull);
    });
  });
}
