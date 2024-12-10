import 'package:flutter/material.dart';
import 'package:newsletter/src/core/config/dependencies.dart';
import 'package:provider/provider.dart';

import 'main.dart';

void main() {
  runApp(
    MultiProvider(
      providers: providersHybrid,
      child: const MainApp(),
    ),
  );
}
