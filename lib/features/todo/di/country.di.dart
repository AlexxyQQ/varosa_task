import '../../../core/di/main.di.dart';
import '../data/data_sources/local/todo.local.data_source.dart';
import '../data/repository/item.repository.impl.dart';
import '../domain/repository/item.repository.dart';
import '../presentation/bloc/item.bloc.dart';

class ItemDI {
  static void register() {
    sl.registerLazySingleton<ItemLocalDataSource>(() => ItemLocalDataSource());

    sl.registerLazySingleton<IItemRepository>(
      () => ItemRepositoryImpl(localDataSource: sl<ItemLocalDataSource>()),
    );

    sl.registerFactory<ItemBloc>(
      () => ItemBloc(repository: sl<IItemRepository>()),
    );
  }
}
