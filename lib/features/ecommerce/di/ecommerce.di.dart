import 'package:get_it/get_it.dart';

import '../../../core/di/main.di.dart';
import '../data/data_source/local/product.local.data_source.dart';
import '../data/data_source/remote/product.remote.data_source.dart';
import '../data/repository/product.repository.impl.dart';
import '../domain/repository/product.repository.dart';
import '../presentation/bloc/detail/product_detail.bloc.dart';
import '../presentation/bloc/product.bloc.dart';

class ECommerceDI {
  static void register() {
    //  Data Source
    sl.registerLazySingleton(() => ProductRemoteDataSource());
    sl.registerLazySingleton(() => ProductLocalDataSource());
    //  Repository
    sl.registerLazySingleton<IProductRepository>(
      () => ProductRepositoryImpl(
        productRemoteDataSource: sl(),
        productLocalDataSource: sl(),
      ),
    );
    //  Bloc
    sl.registerFactory(() => ProductBloc(productRepository: sl()));
    sl.registerFactory(() => ProductDetailBloc(productRepository: sl()));
  }
}
