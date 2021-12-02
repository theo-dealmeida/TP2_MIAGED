import 'package:flutter/material.dart';

import 'user/login.dart';

void app() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MIAGED',
        home: Navigator(
            pages: const [MaterialPage(child: LogInView())],
            onPopPage: (route, result) {
              return route.didPop(result);
            }));
  }
}
