import 'package:flutter/material.dart';
import 'package:newsletter/src/core/routing/router.dart';

import 'main_development.dart' as development;
// import 'main_staging.dart' as staging;

void main() {
  development.main();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      themeMode: ThemeMode.system,
      routerConfig: router(),
    );
  }
}
