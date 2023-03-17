import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_hero_api/characters/view/bloc/characters_bloc.dart';
import 'package:marvel_hero_api/characters/view/widgets/custom_list_tile.dart';
import 'package:marvel_hero_api/shared/colors/app_colors.dart';
import 'package:marvel_hero_api/shared/colors/app_text_styles.dart';

class MainContentWidget extends StatelessWidget {
  const MainContentWidget({
    super.key,
    required this.bloc,
    required this.pageController,
    required this.currentPage,
  });

  final CharactersBloc bloc;
  final PageController pageController;
  final int currentPage;
  final double listTileHeight = 95.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is CharactersFailure) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is CharactersLoading) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.red),
              );
            } else if (state is CharactersSuccess) {
              return ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
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
                    height: listTileHeight * 4,
                    child: PageView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      controller: pageController,
                      itemCount: state.characters.length,
                      itemBuilder: (context, pvIndex) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.characters[pvIndex].length,
                          itemBuilder: (context, lvIndex) => SizedBox(
                            child: CustomListTile(
                              character: state.characters[pvIndex][lvIndex],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return ElevatedButton(
              onPressed: () {
                bloc.add(FetchCharacters());
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.red),
              child: Text(
                'Buscar',
                style: AppTextStyles.whiteRobotoRegular16,
              ),
            );
          },
        ),
      ],
    );
  }
}
