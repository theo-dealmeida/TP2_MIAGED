import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp2_miaged/acheter/vetement_detail.dart';

class AcheterView extends StatefulWidget {
  const AcheterView({Key? key}) : super(key: key);

  @override
  _AcheterViewState createState() => _AcheterViewState();
}

class _AcheterViewState extends State<AcheterView> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('vetements');
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc("vetements").get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
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
                mainAxisSpacing: 30,
                children: List.generate(data.length, (index) {
                  return SizedBox(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VetementDetailView(
                                    vetement: data[index.toString()])));
                      },
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
                                  fit: BoxFit.fitWidth),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data[index.toString()]['prix'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color(0xFF000000)),
                                ),
                                Text(
                                  data[index.toString()]['taille'],
                                  style: const TextStyle(
                                      fontSize: 15, color: Color(0xFF444444)),
                                ),
                              ],
                            ),
                          ]),
                    ),
                  );
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
