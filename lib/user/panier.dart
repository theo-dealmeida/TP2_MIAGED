import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../globals.dart' as globals;

class PanierView extends StatefulWidget {
  const PanierView({Key? key}) : super(key: key);

  @override
  _PanierViewState createState() => _PanierViewState();
}

class _PanierViewState extends State<PanierView> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Column(
          children: [
            Container(
              color: const Color(0xFF02837A),
              height: 50,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Votre panier',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Color(0xFFFFFFFF)),
                    ),
                    Text(
                      globals.currentUser.panier.length.toString() +
                          ' article(s)',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: Color(0xFFFFFFFF)),
                    ),
                  ]),
            ),
            Flexible(
              child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return Column(children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: const Color(0xFF999999),
                        height: 1,
                      ),
                    ]);
                  },
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: globals.currentUser.panier.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 10,
                            ),
                            Center(
                              child: Text(
                                globals.currentUser.panier
                                    .elementAt(index)['titre'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color(0xFF000000)),
                              ),
                            ),
                            Container(
                              height: 10,
                            ),
                            Center(
                              child: Image.network(
                                  globals.currentUser.panier
                                      .elementAt(index)['image'],
                                  width: 300,
                                  height: 250,
                                  fit: BoxFit.fitWidth),
                            ),
                            Container(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(children: [
                                  Text(
                                    globals.currentUser.panier
                                        .elementAt(index)['prix'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Color(0xFF000000)),
                                  ),
                                  Text(
                                    'Taille : ' +
                                        globals.currentUser.panier
                                            .elementAt(index)['taille'],
                                    style: const TextStyle(
                                        fontSize: 15, color: Color(0xFF444444)),
                                  ),
                                ]),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30.0),
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.red, // // foreground
                                        ),
                                        onPressed: () {
                                          List<dynamic> list =
                                              globals.currentUser.panier;
                                          list.removeAt(index);
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(globals.currentUser.login)
                                              .update({'panier': list});
                                          debugPrint(
                                              "Suppression du panier du vêtement : " +
                                                  globals
                                                      .currentUser.panier.last
                                                      .toString());
                                        },
                                        child:
                                            const Text("Supprimer du panier")))
                              ],
                            )
                          ]),
                    );
                  }),
            )
          ],
        )));
  }
}
