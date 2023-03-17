import 'package:flutter/material.dart';
import 'package:marvel_hero_api/shared/colors/app_colors.dart';
import 'package:marvel_hero_api/shared/text_styles/app_text_styles.dart';

class BottomNavigator extends StatelessWidget {
  const BottomNavigator({
    Key? key,
    required this.scrollController,
    required this.totalPages,
    required this.currentPage,
    required this.onTapLeftButton,
    required this.onTapRightButton,
  }) : super(key: key);

  final ScrollController scrollController;
  final int totalPages;
  final int currentPage;
  final VoidCallback onTapLeftButton;
  final VoidCallback onTapRightButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 18, 30, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RotatedBox(
            quarterTurns: 2,
            child: GestureDetector(
              onTap: onTapLeftButton,
              child: Icon(
                Icons.play_arrow,
                size: 36,
                color: AppColors.red,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: SizedBox(
              width: 150,
              height: 32,
              child: ListView(
                scrollDirection: Axis.horizontal,
                controller: scrollController,
                children: List.generate(
                  totalPages,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    child: ClipOval(
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: index == currentPage
                              ? AppColors.red
                              : AppColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
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
          ),
          GestureDetector(
            onTap: onTapRightButton,
            child: Icon(
              Icons.play_arrow,
              size: 36,
              color: AppColors.red,
            ),
          )
        ],
      ),
    );
  }
}
