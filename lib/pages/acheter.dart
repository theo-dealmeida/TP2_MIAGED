import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp2_miaged/models/vetement.dart';
import 'package:tp2_miaged/services/vetementservice.dart';
import 'package:provider/provider.dart';

class AcheterView extends StatefulWidget {
  const AcheterView({Key? key}) : super(key: key);

  @override
  _AcheterViewState createState() => _AcheterViewState();
}

class _AcheterViewState extends State<AcheterView> {
  final List<Vetement> vetements = [];

  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('vetements');
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc("vetements").get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          Map<String, dynamic> data = {};

          if (snapshot.connectionState == ConnectionState.done) {
            data = {};
            data = snapshot.data!.data() as Map<String, dynamic>;
          }
          return NotificationListener<ScrollNotification>(
            child: Scaffold(
              body: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: List.generate(data.length, (index) {
                  return Container(
                      child: Column(children: <Widget>[
                    Center(
                      child: TextButton(
                        onPressed: () {},
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  data[index.toString()]['titre'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color(0xFF000000)),
                                ),
                              ),
                               Center(
                                 child: Image.network(
                                     data[index.toString()]['image'],
                                     width: 300,
                                     height: 150,
                                     fit:BoxFit.fitWidth
                                 ),)
                            ]),
                      ),
                    ),
                  ]));
                }),
              ),
            ),
          );
        });
  }
}

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [],
    );
  }
}
