import 'package:flutter/material.dart';
import 'package:marvel_hero_api/models/character.dart';
import 'package:marvel_hero_api/shared/colors/app_colors.dart';
import 'package:marvel_hero_api/shared/colors/app_text_styles.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.character,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, '/details', arguments: character);
      },
      contentPadding: EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 16,
      ),
      leading: ClipOval(
        child: SizedBox(
          height: 58,
          width: 58,
          child: Image(
            image: NetworkImage(character.thumbnail.fullPath),
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
