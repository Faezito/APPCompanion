import 'package:appcompanion/api/api_client.dart';
import 'package:appcompanion/core/di/service_locator.dart';
import 'package:appcompanion/screens/auth/splash_screen.dart';
import 'package:appcompanion/widgets/snackbar/snackbar_service.dart' as snackbar_service;
import 'package:flutter/material.dart';

void main() {
  setupDependencies();
  ApiClient.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: snackbar_service.scaffoldMessengerKey,
      home: SplashScreen(),
      title: "Game Companion",
    );
  }
}
