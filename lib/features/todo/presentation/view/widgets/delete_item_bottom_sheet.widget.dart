import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../../config/constants/fonts/app_text_style.dart';
import '../../../../../config/constants/size/app_size.constant.dart';
import '../../../../../core/abstract/presentation/bloc/crud/crud.bloc.dart';
import '../../../../../core/common/presentation/views/styles/button.style.dart';
import '../../../../../core/common/presentation/views/widgets/app_bottom_sheet.widget.dart';
import '../../../../../core/common/presentation/views/widgets/app_button.widget.dart';
import '../../../data/models/item.model.dart';
import '../../bloc/item.bloc.dart';

class DeleteItemBottomSheet extends StatelessWidget {
  final ItemModel item;

  const DeleteItemBottomSheet({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with warning icon
        Row(
          children: [
            Container(
              padding: AppSize.allPadding12,
              decoration: BoxDecoration(
                color: PrimitiveColors.red.withValues(alpha: 0.1),
                borderRadius: AppSize.allRadius12,
              ),
              child: Icon(
                Icons.warning_outlined,
                color: PrimitiveColors.red,
                size: 24.sp,
              ),
            ),
            AppSize.horizontalMargin16,
            Expanded(child: Text('Delete Item', style: AppTextStyles.headline)),
          ],
        ),

        AppSize.verticalMargin20,

        // Warning message
        Text(
          'Are you sure you want to delete this item?',
          style: AppTextStyles.body,
        ),

        AppSize.verticalMargin8,

        Text(
          'This action cannot be undone. The item will be permanently removed from your list.',
          style: AppTextStyles.caption,
        ),

        AppSize.verticalMargin20,

        // Action buttons
        Row(
          children: [
            Expanded(
              child: AppButton.stroke(
                onPressed: () => Navigator.of(context).pop(),
                label: 'Cancel',
              ),
            ),
            AppSize.horizontalMargin16,
            Expanded(
              child: AppButton.custom(
                theme: ButtonStyles.destructiveTheme,
                onPressed: () {
                  // Trigger delete action
                  context.read<ItemBloc>().add(DeleteEntityEvent(entity: item));
                  Navigator.of(context).pop();
                },
                label: 'Delete',
              ),
            ),
          ],
        ),
        AppSize.verticalMargin24,
      ],
    );
  }

  /// Static method to show the delete confirmation bottom sheet
  static Future<void> show({
    required BuildContext context,
    required ItemModel item,
  }) {
    return AppBottomSheet.show(
      backgroundColor: PrimitiveColors.white,
      context: context,
      padding: AppSize.allPadding16,
      child: DeleteItemBottomSheet(item: item),
    );
  }
}
