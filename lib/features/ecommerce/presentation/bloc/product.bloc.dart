import 'dart:developer';

import 'package:fpdart/fpdart.dart';

import '../../../../core/abstract/presentation/bloc/pagination/mixins/both_side_pagination.bloc.dart';
import '../../../../core/abstract/presentation/bloc/pagination/pagination.bloc.dart';
import '../../../../core/common/data/models/error/app_error.model.dart';
import '../../data/models/product.model.dart';
import '../../domain/repository/product.repository.dart';

class ProductBloc extends PaginationBloc<ProductModel>
    with BothSidePaginationBloc<ProductModel> {
  final IProductRepository _productRepository;

  ProductBloc({required IProductRepository productRepository})
    : _productRepository = productRepository,
      super(useCursorPagination: false);

  @override
  Future<Either<AppErrorModel, PaginationResponse<ProductModel>>> fetchItems({
    int? page,
    int? limit,
    String? nextToken,
    String? previousToken,
    Map<String, dynamic>? filters,
  }) async {
    log(
      'fetchItems called with: page=$page, limit=$limit, nextToken="$nextToken", previousToken="$previousToken"',
      name: 'CursorBloc',
    );

    final result = await _productRepository.getProducts(
      limit: limit,
      skip: (page ?? 1) * (limit ?? 10),
    );

    result.fold(
      (error) => log('fetchItems error: ${error.message}', name: 'CursorBloc'),
      (response) => log(
        'fetchItems success: ${response.items.length} items, nextToken="${response.nextToken}", hasReachedEnd=${response.hasReachedEnd}',
        name: 'CursorBloc',
      ),
    );

    return result;
  }
}
