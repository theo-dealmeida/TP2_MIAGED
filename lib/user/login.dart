import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../core/home.dart';

class LogInView extends StatefulWidget {
  const LogInView({Key? key}) : super(key: key);

  @override
  _LogInViewState createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  late bool _obscureText = false;

  final databaseReference = FirebaseFirestore.instance;

  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LogIn',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF02837A)),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: SizedBox(
            width: 100,
            child: Image.asset('assets/images/MIAGED_Logo.png'),
          ),
          centerTitle: true,
        ),
        body: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Connexion',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color(0xFFFFFFFF)),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Login',
                        border: OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      controller: _loginController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: const OutlineInputBorder(),
                        fillColor: Colors.white,
                        filled: true,
                        suffixIcon: IconButton(
                            onPressed: () {
                              _toggle();
                              return;
                            },
                            icon: const Icon(Icons.visibility)),
                      ),
                      controller: _passwordController,
                      obscureText: !_obscureText,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        const snackBar =
                            SnackBar(content: Text('Ce compte n\'existe pas'));

                        const snackBarPwd =
                            SnackBar(content: Text('Mot de passe incorrect'));

                        const snackBarError =
                            SnackBar(content: Text('Une erreur est survenue'));

                        if (_formKey.currentState!.validate()) {
                          try {
                            var checkExist = await databaseReference
                                .collection('users')
                                .doc(_loginController.text)
                                .get();
                            if (checkExist.exists) {
                              databaseReference
                                  .collection("users")
                                  .doc(_loginController.text)
                                  .snapshots()
                                  .listen((event) {
                                if (event.get("password") ==
                                    _passwordController.text) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const HomeView()),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBarPwd);
                                }
                              });
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBarError);
                          }
                        }
                        return;
                      },
                      child: const Text('Se connecter'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
