import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PanierView extends StatefulWidget {
  const PanierView({Key? key}) : super(key: key);

  @override
  _PanierViewState createState() => _PanierViewState();
}


class _PanierViewState extends State<PanierView> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Text('Panier')
        )
    );
  }
}