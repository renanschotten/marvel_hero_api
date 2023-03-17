import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_hero_api/characters/view/bloc/characters_bloc.dart';
import 'package:marvel_hero_api/characters/view/widgets/bottom_navigator.dart';
import 'package:marvel_hero_api/characters/view/widgets/home_page_header.dart';
import 'package:marvel_hero_api/characters/view/widgets/main_content_widget.dart';
import 'package:marvel_hero_api/di.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    pageController.dispose();
    scrollController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  late final bloc = getIt<CharactersBloc>();
  late final PageController pageController = PageController();
  late final ScrollController scrollController = ScrollController();
  late final TextEditingController textEditingController =
      TextEditingController();
  late final FocusNode focusNode = FocusNode();
  late int totalPages;
  int currentPage = 0;
  double offset = 0.0;

  void onChangedTextField(value) => bloc.add(FilterCharacters(name: value));

  void onTapTextField() {
    setState(() {
      currentPage = 0;
      offset = 0;
      scrollController.animateTo(
        offset,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
      pageController.animateToPage(
        currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  void onTapOutsideTextField(_) => focusNode.unfocus();

  void onTapRightButton() {
    setState(() {
      if (currentPage < totalPages - 1) {
        currentPage++;
        scrollController.animateTo(
          offset += 30.0,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        );
        pageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    });
  }

  void onTapLeftButton() {
    setState(() {
      if (currentPage > 0) {
        currentPage--;
        scrollController.animateTo(
          offset -= 30.0,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        );
        pageController.previousPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomePageHeader(
                focusNode: focusNode,
                textEditingController: textEditingController,
                onChangedTextField: onChangedTextField,
                onTapOutsideTextField: onTapOutsideTextField,
                onTapTextField: onTapTextField,
              ),
              MainContentWidget(
                bloc: bloc,
                pageController: pageController,
                currentPage: currentPage,
              ),
              BlocBuilder(
                bloc: bloc,
                builder: (context, state) {
                  if (state is CharactersSuccess) {
                    totalPages = state.characters.length;
                    return BottomNavigator(
                      scrollController: scrollController,
                      totalPages: totalPages,
                      currentPage: currentPage,
                      onTapLeftButton: onTapLeftButton,
                      onTapRightButton: onTapRightButton,
                    );
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
