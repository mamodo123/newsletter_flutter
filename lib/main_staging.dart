import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:newsletter/src/core/config/dependencies.dart';
import 'package:newsletter/src/core/helper/firebase_helper.dart';

import 'main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (await InternetConnection().hasInternetAccess) {
    await FirebaseHelper.initFirebase();
  }

  HybridBindings().dependencies();

  runApp(const MainApp());
}
