import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../../core/common/presentation/views/widgets/app_cached_network_image.dart';
import '../../../data/models/product.model.dart';

class ProductImageCarousel extends StatefulWidget {
  final ProductModel product;

  const ProductImageCarousel({super.key, required this.product});

  @override
  State<ProductImageCarousel> createState() => _ProductImageCarouselState();
}

class _ProductImageCarouselState extends State<ProductImageCarousel> {
  final PageController _pageController = PageController();
  int _currentImageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = widget.product.images ?? [];
    final hasMultipleImages = images.length > 1;

    return Container(
      height: 300.h,
      width: double.infinity,
      color: PrimitiveColors.stroke.withOpacity(0.1),
      child: Stack(
        children: [
          if (hasMultipleImages)
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentImageIndex = index;
                });
              },
              itemCount: images.length,
              itemBuilder: (context, index) {
                return _buildImageWidget(
                  images[index],
                  widget.product.title ?? '',
                );
              },
            )
          else
            _buildImageWidget(
              widget.product.thumbnail ??
                  (images.isNotEmpty ? images.first : ''),
              widget.product.title ?? '',
            ),

          // Image indicators
          if (hasMultipleImages)
            Positioned(
              bottom: 16.h,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  images.length,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentImageIndex == index
                          ? PrimitiveColors.primary
                          : PrimitiveColors.white.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImageWidget(String imageUrl, String alt) {
    if (imageUrl.isEmpty) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: PrimitiveColors.stroke.withOpacity(0.3),
        child: Icon(
          Icons.image_not_supported,
          size: 64.w,
          color: PrimitiveColors.hintText,
        ),
      );
    }

    return AppCachedNetworkImage.custom(
      width: 1.sw,
      height: 300.h,
      imageUrl: imageUrl,
      alt: alt,
    );
  }
}
