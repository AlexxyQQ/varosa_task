import 'package:fpdart/src/either.dart';

import '../../../../core/common/data/models/error/app_error.model.dart';
import '../../domain/repository/item.repository.dart';
import '../data_sources/local/todo.local.data_source.dart';
import '../models/item.model.dart';

class ItemRepositoryImpl implements IItemRepository {
  final ItemLocalDataSource _localDataSource;

  ItemRepositoryImpl({required ItemLocalDataSource localDataSource})
    : _localDataSource = localDataSource;

  @override
  Future<Either<AppErrorModel, List<ItemModel>>> getAllItems() {
    return _localDataSource.read();
  }

  @override
  Future<Either<AppErrorModel, List<ItemModel>>> createItem({
    required ItemModel item,
  }) {
    return _localDataSource.create(value: item);
  }

  @override
  Future<Either<AppErrorModel, List<ItemModel>>> deleteItem({
    required String id,
  }) {
    return _localDataSource.deleteWhere(test: (item) => item.id == id);
  }

  @override
  Future<Either<AppErrorModel, List<ItemModel>>> updateItem({
    required ItemModel item,
  }) {
    return _localDataSource.updateWhere(
      test: (item) => item.id == item.id,
      newValue: item,
    );
  }
}
