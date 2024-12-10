import 'package:flutter/material.dart';
import 'package:newsletter/src/core/config/dependencies.dart';

import 'main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  LocalBindings().dependencies();

  runApp(const MainApp());
}
