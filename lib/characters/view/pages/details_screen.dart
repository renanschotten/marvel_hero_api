import 'package:flutter/material.dart';
import 'package:marvel_hero_api/characters/models/character.dart';
import 'package:marvel_hero_api/characters/view/widgets/item_list.dart';

import 'package:marvel_hero_api/shared/colors/app_colors.dart';
import 'package:marvel_hero_api/shared/colors/app_text_styles.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late Character character;

  @override
  Widget build(BuildContext context) {
    character = ModalRoute.of(context)!.settings.arguments as Character;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: ListView(
          children: [
            Stack(
              children: [
                Image(
                  image: NetworkImage(character.thumbnail.fullPath),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.arrow_back,
                    color: AppColors.white,
                    shadows: [
                      Shadow(
                        color: AppColors.darkGrey,
                        blurRadius: 10.0,
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: AppTextStyles.redRobotoBlack32,
                  ),
                  SizedBox(height: 4),
                  Text(
                    character.description,
                    style: AppTextStyles.greyRobotoRegular16,
                  ),
                  SizedBox(height: 4),
                  ItemList(
                    title: 'Comics',
                    item: character.comics,
                  ),
                  ItemList(
                    title: 'Series',
                    item: character.series,
                  ),
                  ItemList(
                    title: 'Stories',
                    item: character.stories,
                  ),
                  ItemList(
                    title: 'Events',
                    item: character.events,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
