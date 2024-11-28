import 'package:flutter/material.dart';
import '../screens/item_card.dart';
import '../data/candi_data.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  // Mengambil data dari candi_data.dart

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wisata Candi"),
      ),
    
      body: GridView.builder(
        itemCount: candiList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemBuilder: (context, index) {
          final candi = candiList[index];
          return ItemCard(
            candi: candi,
          );
        },
      ),
    );
  }
}
