import 'package:flutter/material.dart';

import '../gen/app_localizations.dart';

extension L10nExtension on BuildContext {
  AppLocalizations get l10n {
    final localizations = AppLocalizations.of(this);
    assert(
      localizations != null,
      'AppLocalizations Instances not found in BuildContext'
      'Add AppLocalizations.delegate in localizationsDelegates inside MaterialApp.',
    );
    return localizations!;
  }
}
