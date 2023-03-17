import 'package:flutter/material.dart';
import 'package:marvel_hero_api/shared/colors/app_colors.dart';
import 'package:marvel_hero_api/shared/colors/app_text_styles.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({
    super.key,
    required this.focusNode,
    required this.textEditingController,
    required this.onTapTextField,
    required this.onChangedTextField,
    required this.onTapOutsideTextField,
  });

  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final VoidCallback onTapTextField;
  final void Function(String)? onChangedTextField;
  final void Function(PointerDownEvent)? onTapOutsideTextField;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
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
              Container(
                height: 4,
                width: 54,
                color: AppColors.red,
              )
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
              focusNode: focusNode,
              controller: textEditingController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              maxLines: 1,
              onTapOutside: onTapOutsideTextField,
              onTap: onTapTextField,
              onChanged: onChangedTextField,
            ),
          )
        ],
      ),
    );
  }
}
