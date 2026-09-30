import 'package:catbreeds/app/ui/l10n/extension/l10n_extension.dart';
import 'package:catbreeds/app/ui/navigation/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:monitoring/monitoring.dart';

import 'app/ui/l10n/gen/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Monitoring.initialize(adapters: [ConsoleMonitoringAdapter()]);

  Monitoring.logger.info('Application bootstrapping completed');

  Monitoring.runGuarded(() {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: context.l10n.appName,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      localizationsDelegates: [
        AppLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: AppNavigation.router,
    );
  }
}
