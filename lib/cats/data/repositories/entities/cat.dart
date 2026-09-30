class Cat {
  final String id;
  final String name;
  final String speciesId;
  final String lifeSpan;
  final String temperament;
  final String description;
  final CatWeight weight;
  final CatHeight height;
  final String? origin;
  final String? countryCodes;
  final String? countryCode;
  final String? bredFor;
  final String? perfectFor;
  final String? breedGroup;
  final String? history;
  final String? referenceImageId;
  final CatImage? image;

  const Cat({
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
}

class CatWeight {
  final String imperial;
  final String metric;

  const CatWeight({required this.imperial, required this.metric});
}

class CatHeight {
  final String imperial;
  final String metric;

  const CatHeight({required this.imperial, required this.metric});
}

class CatImage {
  final String? id;
  final String? url;
  final int? width;
  final int? height;

  const CatImage({this.id, this.url, this.width, this.height});
}
