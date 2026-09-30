import '../entities/cat.dart';
import '../../datasources/dtos/cat_dto.dart';

extension CatDtoExtension on CatDto {
  Cat toEntity() => Cat(
    id: id,
    name: name,
    speciesId: speciesId,
    lifeSpan: lifeSpan,
    temperament: temperament,
    description: description,
    weight: weight.toEntity(),
    height: height.toEntity(),
    origin: origin,
    countryCodes: countryCodes,
    countryCode: countryCode,
    bredFor: bredFor,
    perfectFor: perfectFor,
    breedGroup: breedGroup,
    history: history,
    referenceImageId: referenceImageId,
    image: image?.toEntity(),
  );
}

extension CatWeightDtoExtension on CatWeightDto {
  CatWeight toEntity() => CatWeight(imperial: imperial, metric: metric);
}

extension CatHeightDtoExtension on CatHeightDto {
  CatHeight toEntity() => CatHeight(imperial: imperial, metric: metric);
}

extension CatImageDtoExtension on CatImageDto {
  CatImage toEntity() =>
      CatImage(id: id, url: url, width: width, height: height);
}
