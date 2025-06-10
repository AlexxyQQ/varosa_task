import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../config/constants/size/app_size.constant.dart';
import '../../../../core/abstract/presentation/widgets/pagination/both_side_pagination_list_view.widget.dart';
import '../../../../core/abstract/presentation/widgets/pagination/pagination_list_view.widget.dart';
import '../../../todo/data/models/item.model.dart';
import '../../data/models/product.model.dart';
import '../bloc/product.bloc.dart';

@RoutePage(name: 'ProductPageRoute')
class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: PaginationListView<ProductModel>(
        bloc: context.read<ProductBloc>(),
        itemBuilder: (context, item, index) => Container(
          color: PrimitiveColors.red,
          height: 100.h,
          width: 100.w,
          padding: AppSize.allPadding16,
          margin: AppSize.allMargin16,
          child: Text(item.title ?? ''),
        ),
      ),
    );
  }
}
