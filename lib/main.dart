// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:marvel_hero_api/bloc/characters_bloc.dart';
import 'package:marvel_hero_api/models/character.dart';
import 'package:marvel_hero_api/shared/colors/app_colors.dart';
import 'package:marvel_hero_api/shared/colors/app_text_styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => CharactersBloc(),
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<CharactersBloc>(context).add(FetchCharacters());
    super.initState();
  }

  int currentPage = 0;
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'BUSCA MARVEL',
                        style: AppTextStyles.redRobotoBlack16,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'TESTE FRONT-END',
                        style: AppTextStyles.redRobotoLight16,
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Nome do Personagem',
                    style: AppTextStyles.redRobotoRegular16,
                  ),
                  SizedBox(height: 4),
                  SizedBox(
                    height: 31,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 37,
              width: double.infinity,
              color: AppColors.red,
              child: Center(
                child: Text(
                  'Nome',
                  style: AppTextStyles.whiteRobotoRegular16,
                ),
              ),
            ),
            SizedBox(
              height: 300,
              child: PageView(
                controller: pageController,
                children: [
                  Center(
                    child: Text('Page 1'),
                  ),
                  Center(
                    child: Text('Page 2'),
                  ),
                  Center(
                    child: Text('Page 3'),
                  ),
                ],
              ),
            ),
            /* BlocBuilder(
              bloc: BlocProvider.of<CharactersBloc>(context),
              builder: (context, state) {
                if (state is CharactersFailure) {
                  return Center(
                    child: Text(state.message),
                  );
                } else if (state is CharactersLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is CharactersSuccess) {
                  return SizedBox(
                    height: 400,
                    child: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) => CustomListTile(
                        character: state.characters[index],
                      ),
                    ),
                  );
                }
                return Center(
                  child: Text('Initial'),
                );
              },
            ), */
            SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RotatedBox(
                    quarterTurns: 2,
                    child: GestureDetector(
                      onTap: () {
                        if (currentPage > 0) {
                          currentPage--;
                          pageController.animateToPage(
                            currentPage,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                          setState(() {});
                        }
                      },
                      child: Icon(
                        Icons.play_arrow,
                        size: 36,
                        color: AppColors.red,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: List.generate(
                        3,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: ClipOval(
                            child: Container(
                              height: 32,
                              width: 32,
                              decoration: BoxDecoration(
                                color: index == currentPage
                                    ? AppColors.red
                                    : AppColors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                  color: AppColors.red,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: index == currentPage
                                      ? AppTextStyles.whiteRobotoRegular16
                                      : AppTextStyles.redRobotoRegular16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (currentPage < 2) {
                        currentPage++;
                        pageController.animateToPage(
                          currentPage,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                        setState(() {});
                      }
                    },
                    child: Icon(
                      Icons.play_arrow,
                      size: 36,
                      color: AppColors.red,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 24)
          ],
        ),
      ),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  final int currentValue;
  const BottomNavigation({
    Key? key,
    required this.currentValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: List.generate(
          3,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ClipOval(
              child: Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color:
                      index == currentValue ? AppColors.red : AppColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(
                    color: AppColors.red,
                  ),
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: index == currentValue
                        ? AppTextStyles.whiteRobotoRegular16
                        : AppTextStyles.redRobotoRegular16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/* class BottomNavigationButton extends StatelessWidget {
  final int currentValue;
  final String buttonText;
  const BottomNavigationButton({
    Key? key,
    required this.isSelected,
    required this.buttonText,
  }) : super(key: key);

  Color get _backgroundColor => isSelected ? AppColors.red : AppColors.white;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            color: AppColors.red,
          ),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: AppTextStyles.whiteRobotoRegular16,
          ),
        ),
      ),
    );
  }
} */

class CustomListTile extends StatelessWidget {
  final Character character;
  const CustomListTile({
    super.key,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 16,
      ),
      leading: ClipOval(
        child: SizedBox(
          height: 58,
          width: 58,
          child: Image(
            image: NetworkImage(character.thumbnail!.fullPath),
          ),
        ),
      ),
      title: Text(
        character.name,
        style: AppTextStyles.greyRobotoRegular21,
      ),
      shape: Border(
        bottom: BorderSide(
          color: AppColors.red,
        ),
      ),
    );
  }
}
