// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'CatBreeds';

  @override
  String get catsSearchHint => 'Busca por nombre o raza';

  @override
  String get catDetailLifeSpan => 'Vida promedio';

  @override
  String get catDetailOriginCountry => 'País de origen';

  @override
  String get catsErrorTitle => 'Ha ocurrido un error';

  @override
  String get catsErrorRetry => 'Volver a intentar';

  @override
  String get catDetailDescription => 'Descripción';

  @override
  String get catDetailTemperament => 'Temperamento';

  @override
  String get catDetailWeight => 'Peso';

  @override
  String get catDetailHeight => 'Altura';

  @override
  String get catDetailBreedGroup => 'Grupo de raza';

  @override
  String get catDetailBredFor => 'Criado para';

  @override
  String get catDetailPerfectFor => 'Ideal para';

  @override
  String get catDetailHistory => 'Historia';

  @override
  String get catDetailGeneralInfo => 'Información general';

  @override
  String get catDetailPhysicalCharacteristics => 'Características físicas';

  @override
  String get catDetailCountryCodes => 'Códigos de país';

  @override
  String catDetailWeightValue(String metric, String imperial) {
    return '$metric kg ($imperial lbs)';
  }

  @override
  String catDetailHeightValue(String metric, String imperial) {
    return '$metric cm ($imperial in)';
  }

  @override
  String catDetailLifeSpanYears(String years) {
    return '$years años';
  }
}
