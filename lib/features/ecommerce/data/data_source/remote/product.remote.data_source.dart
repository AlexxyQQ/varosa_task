import 'dart:developer';

import 'package:fpdart/fpdart.dart';

import '../../../../../core/abstract/presentation/bloc/pagination/pagination.bloc.dart';
import '../../../../../core/common/data/models/error/app_error.model.dart';
import '../../../../../core/common/domain/services/api/dio.service.dart';
import '../../../../../core/di/main.di.dart';
import '../../models/product.model.dart';
import '../local/product.local.data_source.dart';

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
      onSuccess: (json) async {
        final products = await Future.wait(
          (json['products'] as List).map((e) async {
            final product = ProductModel.fromJson(e as Map<String, dynamic>);
            // Fetch the product from the local data source
            final productLocal = await sl<ProductLocalDataSource>().firstWhere(
              test: (localProduct) => localProduct.id == product.id,
            );

            return productLocal.fold(
              (error) => product.copyWith(isFavorite: false),
              (localProduct) => localProduct?.isFavorite == true
                  ? product.copyWith(isFavorite: true)
                  : product.copyWith(isFavorite: false),
            );
          }).toList(),
        );
        return PaginationResponse(
          items: products,
          hasReachedEnd: products.length < (limit ?? 10),
          totalCount: json['total'],
        );
      },
      onError: (error) => AppErrorModel.fromJson(error),
    );
  }

  Future<Either<AppErrorModel, ProductModel>> getProductById({
    required int id,
  }) async {
    return ApiHandler.get(
      url: "/products/$id",
      onSuccess: (json) async {
        final product = ProductModel.fromJson(json);
        final productLocal = await sl<ProductLocalDataSource>().firstWhere(
          test: (localProduct) => localProduct.id == id,
        );

        return productLocal.fold(
          (error) => product.copyWith(isFavorite: false),
          (localProduct) => localProduct?.isFavorite == true
              ? product.copyWith(isFavorite: true)
              : product.copyWith(isFavorite: false),
        );
      },
      onError: (error) => AppErrorModel.fromJson(error),
    );
  }
}
