import 'package:flutter/material.dart';
import 'package:newsletter/src/core/config/dependencies.dart';

import 'main.dart';

void main() {
  HybridBindings().dependencies();
  runApp(const MainApp());
}
