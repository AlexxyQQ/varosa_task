import 'package:fpdart/fpdart.dart';

import '../../../../core/abstract/presentation/bloc/pagination/pagination.bloc.dart';
import '../../../../core/common/data/models/error/app_error.model.dart';
import '../../data/models/product.model.dart';

abstract class IProductRepository {
  Future<Either<AppErrorModel, PaginationResponse<ProductModel>>> getProducts({
    int? limit,
    int? skip,
    String? search,
  });

  Future<Either<AppErrorModel, ProductModel>> getProductById({required int id});

  Future<Either<AppErrorModel, ProductModel>> toggleFavorite({required int id});
}
