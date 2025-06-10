import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../../config/constants/fonts/app_text_style.dart';
import '../../../../../config/constants/size/app_size.constant.dart';
import '../../../../../core/common/presentation/views/widgets/app_loader.widget.dart';
import '../../../../../core/common/presentation/views/widgets/app_text.widget.dart';
import '../../../../../core/di/main.di.dart';
import '../../../data/models/product.model.dart';
import '../../bloc/detail/product_detail.bloc.dart';
import '../widgets/product_category_brand_section.widget.dart';
import '../widgets/product_description_section.widget.dart';
import '../widgets/product_details_section.widget.dart';
import '../widgets/product_image_carousel.widget.dart';
import '../widgets/product_price_section.widget.dart';
import '../widgets/product_rating_section.widget.dart';
import '../widgets/product_reviews_section.widget.dart';
import '../widgets/product_shipping_warranty_section.widget.dart';
import '../widgets/product_title_section.widget.dart';

@RoutePage(name: 'ProductDetailPageRoute')
class ProductDetailPage extends StatefulWidget implements AutoRouteWrapper {
  const ProductDetailPage({
    super.key,
    @PathParam('id') required this.productId,
  });
  final int productId;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProductDetailBloc>(),
      child: this,
    );
  }
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductDetailBloc>().add(
      GetProductDetail(id: widget.productId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText('Product Detail', style: AppTextStyles.title),
        backgroundColor: PrimitiveColors.white,
        elevation: 0,
      ),
      backgroundColor: PrimitiveColors.white,
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: AppLoader());
          }

          if (state.error != null) {
            return Center(
              child: Padding(
                padding: AppSize.allPadding24,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64.w,
                      color: PrimitiveColors.red,
                    ),
                    AppSize.verticalMargin16,
                    AppText(
                      'Error loading product',
                      style: AppTextStyles.title.copyWith(
                        color: PrimitiveColors.red,
                      ),
                      translate: false,
                    ),
                    AppSize.verticalMargin8,
                    AppText(
                      state.error?.message ?? 'Unknown error occurred',
                      style: AppTextStyles.body.copyWith(
                        color: PrimitiveColors.hintText,
                      ),
                      textAlign: TextAlign.center,
                      translate: false,
                    ),
                    AppSize.verticalMargin24,
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProductDetailBloc>().add(
                          GetProductDetail(id: widget.productId),
                        );
                      },
                      child: AppText('Retry', style: AppTextStyles.button),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state.product == null) {
            return Center(
              child: AppText(
                'Product not found',
                style: AppTextStyles.title,
                translate: false,
              ),
            );
          }

          return _buildProductDetail(state.product!);
        },
      ),
    );
  }

  Widget _buildProductDetail(ProductModel product) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Images Section
          ProductImageCarousel(product: product),

          // Product Information Section
          Padding(
            padding: AppSize.horizontalPadding16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSize.verticalMargin16,

                // Title and Basic Info
                ProductTitleSection(product: product),
                AppSize.verticalMargin16,

                // Price Section
                ProductPriceSection(product: product),
                AppSize.verticalMargin20,

                // Rating and Reviews
                ProductRatingSection(product: product),

                // Category and Brand
                ProductCategoryBrandSection(product: product),
                AppSize.verticalMargin16,

                // Description
                ProductDescriptionSection(product: product),

                // Product Details
                ProductDetailsSection(product: product),

                // Shipping and Warranty
                ProductShippingWarrantySection(product: product),

                // Reviews Section
                ProductReviewsSection(product: product),

                AppSize.verticalMargin32,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
