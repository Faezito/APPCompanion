import 'package:appcompanion/screens/home.dart';
import 'package:appcompanion/widgets/snackbar/snackbar_service.dart' as snackbar_service;
import 'package:flutter/material.dart';

void main() {
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
      home: HomePage(title: 'Pagina Inicial'),
    );
  }
}
