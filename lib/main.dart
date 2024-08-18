import 'package:api_management_/screens/auth/login_screen.dart';
import 'package:api_management_/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Dashboard',
      theme: ThemeData(primarySwatch: Colors.blueGrey, fontFamily: 'Arial'),
      home: DashboardScreen(),
    );
  }
}
