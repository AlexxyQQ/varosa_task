import 'package:fpdart/fpdart.dart';

import '../../../../core/abstract/presentation/bloc/pagination/pagination.bloc.dart';
import '../../../../core/common/data/models/error/app_error.model.dart';
import '../../domain/repository/product.repository.dart';
import '../data_source/remote/product.remote.data_source.dart';
import '../models/product.model.dart';

class ProductRepositoryImpl extends IProductRepository {
  final ProductRemoteDataSource _productRemoteDataSource;

  ProductRepositoryImpl({
    required ProductRemoteDataSource productRemoteDataSource,
  }) : _productRemoteDataSource = productRemoteDataSource;

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
}
