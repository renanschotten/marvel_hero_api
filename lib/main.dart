import 'package:flutter/material.dart';

import 'package:marvel_hero_api/view/pages/details_screen.dart';
import 'package:marvel_hero_api/view/pages/home_page.dart';

import 'di.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marvel Hero Api',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/details': (context) => DetailsPage(),
      },
    );
  }
}
