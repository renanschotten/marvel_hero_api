import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:marvel_hero_api/bloc/characters_bloc.dart';
import 'package:marvel_hero_api/di.dart';
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
      home: BlocProvider(
        create: (context) => getIt<CharactersBloc>(),
        child: HomePage(),
      ),
    );
  }
}
