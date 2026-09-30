import 'package:flutter/material.dart';

import '../../../../app/ui/l10n/extension/l10n_extension.dart';

class CatsScreen extends StatefulWidget {
  const CatsScreen({super.key});

  @override
  State<CatsScreen> createState() => _CatsScreenState();
}

class _CatsScreenState extends State<CatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(context.l10n.appName),
      ),
      body: Center(
        child: Column(mainAxisAlignment: .center, children: []),
      ),
    );
  }
}
