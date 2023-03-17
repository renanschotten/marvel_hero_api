import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marvel_hero_api/bloc/characters_bloc.dart';
import 'package:marvel_hero_api/shared/colors/app_colors.dart';
import 'package:marvel_hero_api/shared/colors/app_text_styles.dart';
import 'package:marvel_hero_api/view/widgets/custom_list_tile.dart';

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
                    height: 400, // listTileHeight * 4,
                    child: PageView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      controller: pageController,
                      itemCount: state.characters.length,
                      itemBuilder: (context, index) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.characters[index].length,
                          itemBuilder: (context, index) => SizedBox(
                            //height: listTileHeight,
                            child: CustomListTile(
                              character: state.characters[currentPage][index],
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
