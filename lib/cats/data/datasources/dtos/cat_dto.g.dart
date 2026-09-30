// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatDto _$CatDtoFromJson(Map<String, dynamic> json) => CatDto(
  id: json['id'] as String,
  name: json['name'] as String,
  speciesId: json['species_id'] as String,
  lifeSpan: json['life_span'] as String,
  temperament: json['temperament'] as String,
  description: json['description'] as String,
  weight: CatWeightDto.fromJson(json['weight'] as Map<String, dynamic>),
  height: CatHeightDto.fromJson(json['height'] as Map<String, dynamic>),
  origin: json['origin'] as String?,
  countryCodes: json['country_codes'] as String?,
  countryCode: json['country_code'] as String?,
  bredFor: json['bred_for'] as String?,
  perfectFor: json['perfect_for'] as String?,
  breedGroup: json['breed_group'] as String?,
  history: json['history'] as String?,
  referenceImageId: json['reference_image_id'] as String?,
  image: json['image'] == null
      ? null
      : CatImageDto.fromJson(json['image'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CatDtoToJson(CatDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'species_id': instance.speciesId,
  'life_span': instance.lifeSpan,
  'temperament': instance.temperament,
  'description': instance.description,
  'weight': instance.weight.toJson(),
  'height': instance.height.toJson(),
  'origin': instance.origin,
  'country_codes': instance.countryCodes,
  'country_code': instance.countryCode,
  'bred_for': instance.bredFor,
  'perfect_for': instance.perfectFor,
  'breed_group': instance.breedGroup,
  'history': instance.history,
  'reference_image_id': instance.referenceImageId,
  'image': instance.image?.toJson(),
};

CatWeightDto _$CatWeightDtoFromJson(Map<String, dynamic> json) => CatWeightDto(
  imperial: json['imperial'] as String,
  metric: json['metric'] as String,
);

Map<String, dynamic> _$CatWeightDtoToJson(CatWeightDto instance) =>
    <String, dynamic>{'imperial': instance.imperial, 'metric': instance.metric};

CatHeightDto _$CatHeightDtoFromJson(Map<String, dynamic> json) => CatHeightDto(
  imperial: json['imperial'] as String,
  metric: json['metric'] as String,
);

Map<String, dynamic> _$CatHeightDtoToJson(CatHeightDto instance) =>
    <String, dynamic>{'imperial': instance.imperial, 'metric': instance.metric};

CatImageDto _$CatImageDtoFromJson(Map<String, dynamic> json) => CatImageDto(
  id: json['id'] as String?,
  url: json['url'] as String?,
  width: (json['width'] as num?)?.toInt(),
  height: (json['height'] as num?)?.toInt(),
);

Map<String, dynamic> _$CatImageDtoToJson(CatImageDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'width': instance.width,
      'height': instance.height,
    };
