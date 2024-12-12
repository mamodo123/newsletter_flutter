import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newsletter/src/core/config/dependencies.dart';
import 'package:newsletter/src/core/helper/fcm_helper.dart';

import 'firebase_options.dart';
import 'main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FCMHelper.initNotifications();

  HybridBindings().dependencies();

  runApp(const MainApp());
}
