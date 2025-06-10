import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../config/constants/fonts/app_text_style.dart';
import '../../../../config/constants/size/app_size.constant.dart';
import '../../../../core/abstract/presentation/widgets/pagination/both_side_pagination_list_view.widget.dart';
import '../../../../core/abstract/presentation/widgets/pagination/pagination_list_view.widget.dart';
import '../../../../core/abstract/presentation/widgets/pagination/searchable_pagination_list_view.widget.dart';
import '../../../../core/common/domain/services/navigation/navigation.service.dart';
import '../../../../core/common/presentation/routes/app_router.gr.dart';
import '../../../../core/common/presentation/views/widgets/app_text.widget.dart';
import '../../../../core/di/main.di.dart';
import '../../../todo/data/models/item.model.dart';
import '../../data/models/product.model.dart';
import '../bloc/product.bloc.dart';
import '../widgets/product_card.widget.dart';

@RoutePage(name: 'ProductPageRoute')
class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: AppText('Products', style: AppTextStyles.title)),
      body: PaginationListView<ProductModel>(
        bloc: context.read<ProductBloc>(),
        itemBuilder: (context, item, index) => ProductCard(
          product: item,
          onTap: () {
            if (item.id != null) {
              sl<NavigationService>().push(
                ProductDetailPageRoute(productId: item.id!),
              );
            }
          },
        ),
      ),
    );
  }
}
