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
}
