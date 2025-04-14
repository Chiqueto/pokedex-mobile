import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedex/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokedex/pages/pokedex.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, preencha todos os campos')),
      );
      return;
    }
    setState(() => _isLoading = true);

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PokedexApp()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Email ou senha incorretos, tente novamente!!!')),
      );
    } finally {
      setState(() => _isLoading = false);
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
                  child: Image.asset('assets/squirtle1.png',
                      height: 200, width: 200),
                ),
                SizedBox(
                  height: 32,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login',
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
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Color(0xff000000)),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Color(0xff000000)),
                      border: OutlineInputBorder()),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  child: const Text(
                    'Login',
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
                    const Text('Não tem um cadastro?'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const RegisterPage(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  var fadeAnimation =
                                      Tween(begin: 0.0, end: 1.0)
                                          .animate(animation);
                                  return FadeTransition(
                                      opacity: fadeAnimation, child: child);
                                }));
                      },
                      child: const Text('Cadastre-se',
                          style: TextStyle(color: Colors.blue)),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
