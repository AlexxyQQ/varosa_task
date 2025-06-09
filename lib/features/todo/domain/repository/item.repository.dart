import 'package:fpdart/fpdart.dart';
import '../../../../core/common/data/models/error/app_error.model.dart';
import '../../data/models/item.model.dart';

abstract class IItemRepository {
  Future<Either<AppErrorModel, List<ItemModel>>> getAllItems();
  Future<Either<AppErrorModel, List<ItemModel>>> createItem({
    required ItemModel item,
  });
  Future<Either<AppErrorModel, List<ItemModel>>> updateItem({
    required ItemModel item,
  });
  Future<Either<AppErrorModel, List<ItemModel>>> deleteItem({
    required String id,
  });
}
