import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../../config/constants/fonts/app_text_style.dart';
import '../../../../../config/constants/size/app_size.constant.dart';
import '../../../../../core/common/presentation/views/widgets/app_text.widget.dart';

class ProductReviewCard extends StatelessWidget {
  final dynamic review;

  const ProductReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppSize.bottomPadding12,
      padding: AppSize.allPadding16,
      decoration: BoxDecoration(
        borderRadius: AppSize.allRadius12,
        border: Border.all(color: PrimitiveColors.stroke),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: AppText(
                  review.reviewerName ?? 'Anonymous',
                  style: AppTextStyles.body.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  translate: false,
                ),
              ),
              if (review.rating != null) ...[
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < review.rating!.floor()
                          ? Icons.star
                          : Icons.star_border,
                      color: PrimitiveColors.orange,
                      size: 16.w,
                    );
                  }),
                ),
                AppSize.horizontalMargin4,
                AppText(
                  '${review.rating}',
                  style: AppTextStyles.caption,
                  translate: false,
                ),
              ],
            ],
          ),
          if (review.comment != null) ...[
            AppSize.verticalMargin8,
            AppText(
              review.comment!,
              style: AppTextStyles.body.copyWith(
                color: PrimitiveColors.hintText,
              ),
              translate: false,
            ),
          ],
          if (review.date != null) ...[
            AppSize.verticalMargin8,
            AppText(
              review.date?.toLocal().toString() ?? '',
              style: AppTextStyles.caption.copyWith(
                color: PrimitiveColors.hintText,
              ),
              translate: false,
            ),
          ],
        ],
      ),
    );
  }
}
