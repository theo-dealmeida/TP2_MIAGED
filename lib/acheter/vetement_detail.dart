import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../globals.dart' as globals;

class VetementDetailView extends StatefulWidget {
  final Map vetement;

  const VetementDetailView({Key? key, required this.vetement})
      : super(key: key);

  @override
  _VetementDetailViewState createState() => _VetementDetailViewState();
}

class _VetementDetailViewState extends State<VetementDetailView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF02837A)),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: SizedBox(
              width: 100,
              child: Image.asset('assets/images/MIAGED_Logo.png'),
            ),
            centerTitle: true,
          ),
          body: Column(children: [
            Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                child: Text(
                  widget.vetement['titre'],
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 25,
                      color: Color(0xFFFFFFFF)),
                )),
            Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Text(
                  widget.vetement['marque'],
                  style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                      color: Color(0xFFCCCCCC)),
                )),
            Center(
              child: Image.network(widget.vetement['image'],
                  width: 350, height: 350, fit: BoxFit.fitWidth),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Text(
                'Prix : ' + widget.vetement['prix'],
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Color(0xFFDDDDDD)),
              ),
              Text(
                'Taille : ' + widget.vetement['taille'],
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: Color(0xFFCCCCCC)),
              ),
            ]),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: ElevatedButton(
                    onPressed: () {
                      List<dynamic> list = globals.currentUser.panier;
                      list.add(Map<String, dynamic>.from(widget.vetement));
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(globals.currentUser.login)
                          .update({'panier': list});
                      debugPrint("Ajout au panier du vêtement : " +
                          globals.currentUser.panier.last.toString());
                    },
                    child: const Text("Ajouter au panier")))
          ]),
        ));
  }
}
