import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:newsletter/src/core/routing/router.dart';
import 'package:newsletter/src/core/routing/routes.dart';
import 'package:newsletter/src/core/themes/theme.dart';

// import 'main_development_remote.dart' as development_remote;

// import 'main_development.dart' as development;
import 'main_staging.dart' as staging;

void main() {
  staging.main();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: Routes.newsletter,
      theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      // themeMode: ThemeMode.system,
      getPages: appRoutes,
    );
  }
}
