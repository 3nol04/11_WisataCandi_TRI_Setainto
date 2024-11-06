import 'package:flutter/material.dart';
import 'package:widget_dasar_flutter2/data/candi_data.dart';
import 'package:widget_dasar_flutter2/screens/profile_screen.dart';
import 'screens/detail_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: DetailScreen(candi: candiList[0]),
      home : const ProfileScreen()
    );
  }
}