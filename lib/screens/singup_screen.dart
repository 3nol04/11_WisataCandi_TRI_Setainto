import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SingUpScreen extends StatefulWidget {
  SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _Sing_inScreenState();
}

class _Sing_inScreenState extends State<SingUpScreen> {
  //TODO 1 Deklarasi variabel
  final TextEditingController _nameuserController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorMessage = "";
  bool _isSingIn = false;
  bool _isObscure = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO @ Pasang Appabar
      appBar: AppBar(
        title: const Text("Sing_Up"),
      ),
      body: Center(
        child: Form(
            child: Column(
          //TODO 4 Atur MainAxisAlignment dana CrossAxisAlignment\
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _nameuserController,
              decoration: const InputDecoration(
                labelText: "Nama Pengguna",
                border: OutlineInputBorder(),
              ),
            ),
            //TODO 6. Pasang TextFieldField TextField  Kata Sandi
            const SizedBox(
              height: 20,
            ),
            //TODO 5. Pasang TextFieldField Nama Pengguna
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
            ),
            //TODO 6. Pasang TextFieldField TextField  Kata Sandi
            const SizedBox(
              height: 20,
            ),

            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: "Kata Sandi",
                errorText: _errorMessage.isNotEmpty ? _errorMessage : null,
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility),
                ),
              ),
              obscureText: _isObscure,
            ),
            //TODO 7. Pasang TextFieldField TextField  Tombol Sign In
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Sign Up"),
            ),
            const SizedBox(
              height: 20,
            ),
            //TODO 8. Pasang TextFieldField TextField  Tombol Sign Up
            // TextButton(
            //   onPressed: () {},
            //   child: const Text("Belum punya akun ? Daftar disini"),
            // )
            RichText(
                text: TextSpan(
                    text: "Sadah punya akun ? ",
                    style:
                        const TextStyle(fontSize: 16, color: Colors.deepPurple),
                    children: [
                  TextSpan(
                      text: "Masuk disini",
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {})
                ]))
          ],
        )),
      ),
    );
  }
}
