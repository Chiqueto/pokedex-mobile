import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _register() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Preencha todos os campos!')));
      return;
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Digite um email válido!')));
      return;
    }

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Usuário cadastrado: ${userCredential.user!.email}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao cadastrar: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/pokeball.gif',
              height: 40,
              width: 40,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'Pokedex',
              style: GoogleFonts.limelight(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: Container(
        color: Color(0xfffffffff),
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Image.asset('assets/squirtle2.png',
                      height: 200, width: 200),
                ),
                SizedBox(
                  height: 32,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Cadastrar',
                    style: GoogleFonts.dmSerifText(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff000000)),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Digite seu email',
                    labelStyle: TextStyle(color: Color(0xff000000)),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      labelText: 'Digite seu Password',
                      labelStyle: TextStyle(color: Color(0xff000000)),
                      border: OutlineInputBorder()),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: _register,
                  child: const Text(
                    'Cadastrar',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Pokémon! Temos que pegar'),
                    SizedBox(
                      height: 32,
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
