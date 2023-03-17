import 'package:flutter/material.dart';
import 'package:marvel_hero_api/shared/colors/app_colors.dart';
import 'package:marvel_hero_api/shared/colors/app_text_styles.dart';

class ItemList extends StatelessWidget {
  const ItemList({
    super.key,
    required this.title,
    required this.item,
  });
  final String title;
  final List<String> item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          color: AppColors.red,
        ),
        Text(
          title,
          style: AppTextStyles.redRobotoBold20,
        ),
        ...item
            .map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text(
                  e,
                  style: AppTextStyles.greyRobotoRegular16,
                ),
              ),
            )
            .toList()
      ],
    );
  }
}
