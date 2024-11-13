import 'package:flutter/material.dart';
import 'package:widget_dasar_flutter2/data/candi_data.dart';
import 'package:widget_dasar_flutter2/screens/profile_screen.dart';
import 'package:widget_dasar_flutter2/screens/sing_in_screen.dart';
import 'package:widget_dasar_flutter2/screens/singup_screen.dart';
import 'screens/detail_screen.dart';
import 'package:widget_dasar_flutter2/screens/search_screen.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisata Candi',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
        )
      ),
      //home: DetailScreen(candi: candiList[0]),
      //home : const ProfileScreen()
     // home:  Sing_inScreen(),
      //home:  SingUpScreen(),
      home:  SearchScreen(),
    );
  }
}