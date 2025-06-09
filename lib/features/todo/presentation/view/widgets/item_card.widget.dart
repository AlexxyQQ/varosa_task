import 'package:flutter/material.dart';

import '../../../../../config/constants/fonts/app_text_style.dart';
import '../../../../../config/constants/size/app_size.constant.dart';
import '../../../../../core/common/presentation/views/widgets/app_text.widget.dart';
import '../../../data/models/item.model.dart';
import 'delete_item_bottom_sheet.widget.dart';
import 'update_item_bottom_sheet.widget.dart';

class ItemCardWidget extends StatelessWidget {
  const ItemCardWidget({super.key, required this.data});

  final ItemModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppSize.horizontalPadding16 + AppSize.verticalPadding6,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppSize.allRadius16,
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: AppSize.allPadding20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with name, status, and actions
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(data.status.icon, color: data.status.textColor, size: 24),
                AppSize.horizontalMargin12,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        data.name ?? "Untitled Item",
                        style: AppTextStyles.title,
                      ),
                      AppSize.verticalMargin4,
                      _buildStatusChip(),
                    ],
                  ),
                ),
                _buildActionButtons(context),
              ],
            ),

            // Description section
            if (data.description != null && data.description!.isNotEmpty) ...[
              AppSize.verticalMargin16,
              Container(
                padding: AppSize.allPadding12,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: AppSize.allRadius12,
                  border: Border.all(color: Colors.blue.shade100),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.description_outlined,
                      color: Colors.blue.shade600,
                      size: 20,
                    ),
                    AppSize.horizontalMargin8,
                    Expanded(
                      child: AppText(
                        data.description!,
                        style: AppTextStyles.subtitle,
                        maxLines: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () async {
            await UpdateItemBottomSheet.show(context: context, item: data);
          },
          icon: Icon(
            Icons.edit_outlined,
            color: Colors.blue.shade600,
            size: 20,
          ),
          style: IconButton.styleFrom(
            backgroundColor: Colors.blue.shade50,
            padding: const EdgeInsets.all(8),
          ),
        ),
        AppSize.horizontalMargin8,
        IconButton(
          onPressed: () async {
            await DeleteItemBottomSheet.show(context: context, item: data);
          },
          icon: Icon(
            Icons.delete_outline,
            color: Colors.red.shade600,
            size: 20,
          ),
          style: IconButton.styleFrom(
            backgroundColor: Colors.red.shade50,
            padding: const EdgeInsets.all(8),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip() {
    return Container(
      padding: AppSize.horizontalPadding12 + AppSize.verticalPadding6,
      decoration: BoxDecoration(
        color: data.status.backgroundColor,
        borderRadius: AppSize.allRadius20,
        border: Border.all(
          color: data.status.backgroundColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: data.status.textColor,
              shape: BoxShape.circle,
            ),
          ),
          AppSize.horizontalMargin6,
          AppText(data.status.name, style: AppTextStyles.caption),
        ],
      ),
    );
  }
}
