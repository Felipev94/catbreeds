import 'package:json_annotation/json_annotation.dart';

part 'cat_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class CatDto {
  final String id;
  final String name;
  final String speciesId;
  final String lifeSpan;
  final String temperament;
  final String description;
  final CatWeightDto weight;
  final CatHeightDto height;
  final String? origin;
  final String? countryCodes;
  final String? countryCode;
  final String? bredFor;
  final String? perfectFor;
  final String? breedGroup;
  final String? history;
  final String? referenceImageId;
  final CatImageDto? image;

  const CatDto({
    required this.id,
    required this.name,
    required this.speciesId,
    required this.lifeSpan,
    required this.temperament,
    required this.description,
    required this.weight,
    required this.height,
    this.origin,
    this.countryCodes,
    this.countryCode,
    this.bredFor,
    this.perfectFor,
    this.breedGroup,
    this.history,
    this.referenceImageId,
    this.image,
  });

  factory CatDto.fromJson(Map<String, dynamic> json) => _$CatDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CatDtoToJson(this);
}

@JsonSerializable()
class CatWeightDto {
  final String imperial;
  final String metric;

  const CatWeightDto({required this.imperial, required this.metric});

  factory CatWeightDto.fromJson(Map<String, dynamic> json) =>
      _$CatWeightDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CatWeightDtoToJson(this);
}

@JsonSerializable()
class CatHeightDto {
  final String imperial;
  final String metric;

  const CatHeightDto({required this.imperial, required this.metric});

  factory CatHeightDto.fromJson(Map<String, dynamic> json) =>
      _$CatHeightDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CatHeightDtoToJson(this);
}

@JsonSerializable()
class CatImageDto {
  final String? id;
  final String? url;
  final int? width;
  final int? height;

  const CatImageDto({this.id, this.url, this.width, this.height});

  factory CatImageDto.fromJson(Map<String, dynamic> json) =>
      _$CatImageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CatImageDtoToJson(this);
}
