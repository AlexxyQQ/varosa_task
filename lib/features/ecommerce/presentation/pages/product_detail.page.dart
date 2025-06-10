import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/fonts/app_text_style.dart';
import '../../../../core/common/presentation/views/widgets/app_text.widget.dart';
import '../../../../core/di/main.di.dart';
import '../bloc/detail/product_detail.bloc.dart';

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
      ),
    );
  }
}
