import 'package:fpdart/fpdart.dart';

import '../../../../../core/abstract/presentation/bloc/pagination/pagination.bloc.dart';
import '../../../../../core/common/data/models/error/app_error.model.dart';
import '../../../../../core/common/domain/services/api/dio.service.dart';
import '../../models/product.model.dart';

class ProductRemoteDataSource {
  Future<Either<AppErrorModel, PaginationResponse<ProductModel>>> getProducts({
    int? limit,
    int? skip,
    String? search,
  }) async {
    return ApiHandler.get(
      url: search != null ? "/products/search" : "/products",
      queryParams: {
        "limit": limit,
        "skip": skip,
        if (search != null) "q": search,
      },
      onSuccess: (json) {
        final products = (json['products'] as List)
            .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return PaginationResponse(
          items: products,
          hasReachedEnd: products.length < (limit ?? 10),
          totalCount: json['total'],
        );
      },
      onError: (error) => AppErrorModel.fromJson(error),
    );
  }
}
