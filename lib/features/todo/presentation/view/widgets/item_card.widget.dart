import 'package:flutter/material.dart';
import '../../../../../config/constants/fonts/app_text_style.dart';
import '../../../../../config/constants/size/app_size.constant.dart';
import '../../../../../core/common/presentation/views/widgets/app_text.widget.dart';
import '../../../data/models/item.model.dart';

class ItemCardWidget extends StatelessWidget {
  const ItemCardWidget({super.key, required this.data});

  final ItemModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // Name of Country
          Row(
            children: [
              AppText(data.name ?? "", style: AppTextStyles.title),
              AppSize.horizontalMargin8,
              AppText(
                "(${data.description ?? ""})",
                style: AppTextStyles.subtitle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
