import 'package:flutter/material.dart';
import '../models/candi.dart';
import '../data/candi_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  final List<Candi> favorites;

  const FavoriteScreen({super.key, required this.favorites});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late List<Candi> favorites;

  @override
  void initState() {
    super.initState();
    favorites = [];
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Candi> tempFavorites = [];

    for (Candi candi in candiList) {
      String key = 'favorite_${candi.name.replaceAll(' ', '_')}';
      bool isFavorite = prefs.getBool(key) ?? false;
      if (isFavorite) {
        tempFavorites.add(candi);
      }
    }

    setState(() {
      favorites = tempFavorites;
    });

    await prefs.setInt('favoriteCandiCount', tempFavorites.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Candi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.favorites.isEmpty
            ? const Center(child: Text('No favorites added yet'))
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: widget.favorites.length,
                itemBuilder: (context, index) {
                  final candi = widget.favorites[index];
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            candi.imageAsset,
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            candi.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
