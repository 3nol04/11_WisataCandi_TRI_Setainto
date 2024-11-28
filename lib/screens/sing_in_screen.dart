import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // TODO: 1. Deklarasi Variable
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  String _errorText = '';
  bool _isSigned = false;
  bool _obscurePassword = true;

  void  _signIn() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String savedUsername = prefs.getString('username') ?? '';
    final String savedPassword = prefs.getString('password') ?? '';
    final String enteredUsername = _usernameController.text.trim();
    final String enteredPassword = _passwordController.text.trim();

    if (enteredUsername == savedUsername && enteredPassword == savedPassword){
      setState(() {
        _errorText = '';
        _isSigned = true;
        prefs.setBool('isSignedIn', true);
      });
      WidgetsBinding.instance.addPostFrameCallback((_){
        Navigator.of(context).popUntil((route) => route.isFirst);
      });
        // Simpan nama dan username ke SharedPreferences untuk digunakan di profil
      final String savedName = prefs.getString('fullname') ?? '';
      prefs.setString('currentName', savedName);
      prefs.setString('currentUsername', savedUsername);
      
      WidgetsBinding.instance.addPostFrameCallback((_){
        Navigator.pushReplacementNamed(context, '/mainscreen');
      });
    } else{
      setState(() {
        _errorText = 'Nama Pengguna atau sandi salah';
      });
    }

    if(enteredUsername.isEmpty || enteredPassword.isEmpty) {
      setState(() {
        _errorText = 'nama pengguna dan kata sandi harus diisi!';
      });
      return;
    }

    if(savedUsername.isEmpty || savedPassword.isEmpty) {
      setState(() {
        _errorText = 'Pengguna Belum Terdaftar. Silahkan daftar terlebih dahulu';
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: 2 Pasang APP BAr
      appBar: AppBar(
        title: const Text('Sign in'),
      ),
      // TODO: 3 Pasang BOdy
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              child: Column(
                // TODO: 4 Atur MainAxisAlignment dan CrossAxisAlignment
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // TODO: 5 Pasang TextFormField
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Pengguna',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  // TODO: 6 Pasang TextFormField Kedua
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Kata Sandi',
                      errorText: _errorText.isNotEmpty ? _errorText : null,
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    obscureText: _obscurePassword,
                  ),
                  // TODO: 7 Pasang ElevatedButton Sign in
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _signIn,
                    child: const Text('Sign in'),
                  ),
                  // TODO: 8 Pasang ElevatedButton Register
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: 'Belum punya Akun?',
                      style: const TextStyle(fontSize: 16, color: Colors.deepPurple),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' Daftar Disini',
                          style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {Navigator.pushNamed(context, '/signup');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}