import 'dart:developer';

import 'package:fpdart/fpdart.dart';

import '../../../../core/abstract/presentation/bloc/pagination/pagination.bloc.dart';
import '../../../../core/common/data/models/error/app_error.model.dart';
import '../../domain/repository/product.repository.dart';
import '../data_source/local/product.local.data_source.dart';
import '../data_source/remote/product.remote.data_source.dart';
import '../models/product.model.dart';

class ProductRepositoryImpl extends IProductRepository {
  final ProductRemoteDataSource _productRemoteDataSource;
  final ProductLocalDataSource _productLocalDataSource;

  ProductRepositoryImpl({
    required ProductRemoteDataSource productRemoteDataSource,
    required ProductLocalDataSource productLocalDataSource,
  }) : _productRemoteDataSource = productRemoteDataSource,
       _productLocalDataSource = productLocalDataSource;

  @override
  Future<Either<AppErrorModel, PaginationResponse<ProductModel>>> getProducts({
    int? limit,
    int? skip,
    String? search,
  }) async {
    return _productRemoteDataSource.getProducts(
      limit: limit,
      skip: skip,
      search: search,
    );
  }

  @override
  Future<Either<AppErrorModel, ProductModel>> getProductById({
    required int id,
  }) {
    return _productRemoteDataSource.getProductById(id: id);
  }

  @override
  Future<Either<AppErrorModel, ProductModel>> toggleFavorite({
    required int id,
  }) async {
    // First check if product exists in local storage
    final localProductResult = await _productLocalDataSource.firstWhere(
      test: (product) => product.id == id,
    );

    return localProductResult.fold(
      // Product doesn't exist in local storage, fetch from remote and add as favorite
      (error) async {
        final remoteProductResult = await _productRemoteDataSource
            .getProductById(id: id);
        return remoteProductResult.fold((error) => Left(error), (
          remoteProduct,
        ) async {
          final favoriteProduct = remoteProduct.copyWith(isFavorite: true);
          await _productLocalDataSource.upsertItem(
            test: (product) => product.id == id,
            value: favoriteProduct,
          );
          return Right(favoriteProduct);
        });
      },
      // Product exists in local storage, toggle its favorite status
      (localProduct) async {
        if (localProduct != null) {
          final updatedProduct = localProduct.copyWith(
            isFavorite: !(localProduct.isFavorite ?? false),
          );

          if (updatedProduct.isFavorite == false) {
            // If unfavoriting, remove from local storage
            await _productLocalDataSource.deleteWhere(
              test: (product) => product.id == id,
            );
          } else {
            // If favoriting, update in local storage
            await _productLocalDataSource.updateWhere(
              test: (product) => product.id == id,
              newValue: updatedProduct,
            );
          }
          return Right(updatedProduct);
        } else {
          // This shouldn't happen, but handle it anyway
          final remoteProductResult = await _productRemoteDataSource
              .getProductById(id: id);
          return remoteProductResult.fold((error) => Left(error), (
            remoteProduct,
          ) async {
            final favoriteProduct = remoteProduct.copyWith(isFavorite: true);
            await _productLocalDataSource.upsertItem(
              test: (product) => product.id == id,
              value: favoriteProduct,
            );
            return Right(favoriteProduct);
          });
        }
      },
    );
  }
}
