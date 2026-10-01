import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CatDetailScreen extends StatefulWidget {
  final String catId;
  const CatDetailScreen({required this.catId, super.key});

  @override
  State<CatDetailScreen> createState() => _CatDetailScreenState();
}

class _CatDetailScreenState extends State<CatDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldTemplate(content: []);
  }
}
