import 'package:flutter/material.dart';
import 'package:wiget_dasar2/models/candi.dart';

class DetailScreen extends StatelessWidget {
  final Candi candi;

  const DetailScreen({super.key, required this.candi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    candi.imageAsset,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding
              (padding: 
                const EdgeInsets.symmetric(horizontal: 16,
                vertical: 32),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.deepPurple[100]?.withOpacity(0.8),
                  shape: BoxShape.circle),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back),
                  ),
              ),
              )
            ],
          ),
          Padding(const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    candi.name,
                    style: 
                      const TextStyle (
                        fontSize: 20,
                      ),
                  ),
                    Row(children: [
                      const Icon(Icons.place, color: Colors.red),
                      const SizedBox(width: 8),
                      const SizedBox(width : 70),
                      child:Text('Lokasi',style:TextStyle(
                        FontWeight FontWeight.blod
                      ),),)
                      Text(': ${candi.lokasi}')
                    ],)
                ],
                ),
                Row(children: [],),
                Row(children: [],),
                const SizwdBox(height: 16),
                Divider(color: Colors.deepPurple.shade100,),
                const SizedBox(height: 16),
            ],
          ),
          )
        ],
      ),
    );
  }
}