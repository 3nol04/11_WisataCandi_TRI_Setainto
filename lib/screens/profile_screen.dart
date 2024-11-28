import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSignedIn = true;
  String fullName = '';
  String userName = '';
  int favoriteCandiCount = 0;
  File? image;

  // Fungsi untuk Sign In
  void signIn() {
    Navigator.pushNamed(context, '/signin');
  }

  // Fungsi untuk Sign Out
  void logOut() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSignedIn', false);  

    // Navigasi ke halaman sign in
    Navigator.pushReplacementNamed(context, '/signin');
  }

  // Fungsi untuk mengambil gambar
  Future<void> selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? selectedImage = await picker.pickImage(source: ImageSource.camera);
    
    if (selectedImage != null) {
      setState(() {
        image = File(selectedImage.path); 
        print("Selected image path: ${selectedImage.path}");  // Set the image file to the state
      });
    }
  }

   // Fungsi untuk menyimpan jumlah favorite
  Future<void> _saveFavoriteCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('favoriteCandiCount', favoriteCandiCount);
  }
  
  // Fungsi untuk mengedit user name
  void _editUserName() async {
    TextEditingController controller = TextEditingController(text: userName);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit User Name'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Enter new user name'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () async {
                setState(() {
                  userName = controller.text;
                });

                final SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('currentUsername', userName); // Simpan username baru

                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk mengedit full name
  void _editFullName() async {
    TextEditingController controller = TextEditingController(text: fullName);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Full Name'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Enter new full name'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () async {
                setState(() {
                  fullName = controller.text;
                });

                final SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('currentName', fullName); // Simpan nama lengkap baru

                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();  // Mengecek status login saat pertama kali membuka layar
    _loadProfileData();  // Memuat data profil pengguna
  }

  // Mengecek status login dari SharedPreferences
  void _checkLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? signedIn = prefs.getBool('isSignedIn');
    setState(() {
      isSignedIn = signedIn ?? false; // Menyimpan status login
    });

    // Jika tidak login, arahkan ke halaman SignIn
    if (!isSignedIn) {
      Navigator.pushReplacementNamed(context, '/signin');
    }
  }

  // Memuat data profil pengguna dari SharedPreferences
  void _loadProfileData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString('currentName') ?? 'Nama Tidak Ditemukan';
      userName = prefs.getString('currentUsername') ?? 'Username Tidak Ditemukan';
      favoriteCandiCount = prefs.getInt('favoriteCandiCount') ?? 0; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200, width: double.infinity, color: Colors.deepPurple,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // Profile Header dengan gambar profil
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 200 - 50),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.deepPurple,
                              width: 2,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: image == null
                                ? const AssetImage('images/placeholder_image.png')
                                : FileImage(image!) as ImageProvider,
                          ),
                        ),
                        if (isSignedIn)
                          IconButton(
                            onPressed: selectImage,
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.deepPurple[50],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Divider(color: Colors.deepPurple[100]),
                const SizedBox(height: 4),

                // Baris UserName
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: const Row(
                        children: [
                          Icon(
                            Icons.lock,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'User Name ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ': $userName',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.deepPurple),
                      onPressed: _editUserName, // Fungsi untuk mengedit nama pengguna
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Divider(color: Colors.deepPurple[100]),
                const SizedBox(height: 4),

                // Baris Full Name
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: const Row(
                        children: [
                          Icon(
                            Icons.lock,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Name ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ': $fullName',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.deepPurple),
                      onPressed: _editFullName, // Fungsi untuk mengedit nama lengkap
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Divider(color: Colors.deepPurple[100]),
                const SizedBox(height: 4),

                // Baris Favorite
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: const Row(
                        children: [
                          Icon(
                            Icons.lock,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Favorite ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(
                            Icons.favorite,
                            color: Colors.red,  
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Text(
                        favoriteCandiCount > 0
                            ? ': $favoriteCandiCount'
                            : ': No Favorites', 
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Divider(color: Colors.deepPurple[100]),
                const SizedBox(height: 20),
                isSignedIn
                    ? TextButton(onPressed: logOut, child: const Text('Log Out'))
                    : TextButton(onPressed: signIn, child: const Text('Sign in')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}