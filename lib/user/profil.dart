import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tp2_miaged/user/login.dart';

import '../globals.dart' as globals;
import 'model/user.dart';

class ProfilView extends StatefulWidget {
  const ProfilView({Key? key}) : super(key: key);

  @override
  _ProfilViewState createState() => _ProfilViewState();
}

class _ProfilViewState extends State<ProfilView> {
  late bool _obscureText = false;

  final _loginController =
      TextEditingController(text: globals.currentUser.login);

  final _passwordController =
      TextEditingController(text: globals.currentUser.password);

  final _birthController =
      TextEditingController(text: globals.currentUser.birth);

  final _addressController =
      TextEditingController(text: globals.currentUser.address);

  final _postalController =
      TextEditingController(text: globals.currentUser.postal);

  final _cityController = TextEditingController(text: globals.currentUser.city);

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
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Builder(
                builder: (context) => Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          child: TextFormField(
                            enabled: false,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                            ),
                            controller: _loginController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          child: TextFormField(
                              decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
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
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                            ),
                            controller: _birthController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                            ),
                            controller: _addressController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                            ),
                            controller: _postalController,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 16),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                            ),
                            controller: _cityController,
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: ElevatedButton(
                                onPressed: () {
                                  if (globals.currentUser.password !=
                                      _passwordController.text) {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(globals.currentUser.login)
                                        .update({
                                      'password': _passwordController.text
                                    });
                                  } else if (globals.currentUser.birth !=
                                      _birthController.text) {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(globals.currentUser.login)
                                        .update(
                                            {'birth': _birthController.text});
                                  } else if (globals.currentUser.address !=
                                      _addressController.text) {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(globals.currentUser.login)
                                        .update({
                                      'address': _addressController.text
                                    });
                                  } else if (globals.currentUser.postal !=
                                      _postalController.text) {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(globals.currentUser.login)
                                        .update(
                                            {'postal': _postalController.text});
                                  } else if (globals.currentUser.city !=
                                      _cityController.text) {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(globals.currentUser.login)
                                        .update({'city': _cityController.text});
                                  }
                                },
                                child: const Text("Valider"))),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red, // // foreground
                                ),
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return const LogInView();
                                      },
                                    ),
                                    (_) => false,
                                  );
                                  globals.currentUser =
                                      const User("", "", [], "", "", "", "");
                                },
                                child: const Text("Se déconnecter")))
                      ],
                    )))));
  }
}
