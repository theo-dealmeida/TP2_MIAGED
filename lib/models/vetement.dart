import 'dart:ui';

class Vetement {
  String? image;
  String? marque;
  String? prix;
  String? taille;
  String? titre;

  Vetement({this.image, this.marque, this.prix, this.taille, this.titre});

  factory Vetement.fromJson(Map<String, dynamic> json) {
    return Vetement(
      marque: json['marque'],
      image: json['image'],
      prix: json['prix'],
      taille: json['taille'],
      titre: json['titre']
    );
  }
}
