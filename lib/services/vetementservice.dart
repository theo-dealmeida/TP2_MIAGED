import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tp2_miaged/models/vetement.dart';

class VetementService {


  FirebaseFirestore? _instance;

  List<Vetement> _vetements = [];

  List<Vetement> getVetements() {
    return _vetements;
  }

  getVetementsCollectionFromFirebase() async {

    _instance = FirebaseFirestore.instance;

    CollectionReference vetements = _instance!.collection('vetements');

    DocumentSnapshot snapshot = await vetements.doc('vetements').get();
    var data = snapshot.data() as Map;
    var vetementsData = data['vetements'] as List<dynamic>;

    vetementsData.forEach((vetement) {
      _vetements.add(Vetement.fromJson(vetement));
    }
    );

    print(_vetements);
  }

}