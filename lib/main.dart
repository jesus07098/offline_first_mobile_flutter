import 'package:flutter/material.dart';

import 'features/users/pages/home_page.dart';
import 'helper/object_box.dart';

late ObjectBox objectBox;

Future<void> main() async {
  objectBox= await ObjectBox.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
    );
  }
}
