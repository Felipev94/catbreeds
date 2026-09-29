import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:monitoring/monitoring.dart';

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
    return MaterialApp(
      title: 'Catbreeds',
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Catbreeds'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: .center, children: []),
      ),
    );
  }
}
