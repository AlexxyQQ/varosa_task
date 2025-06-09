import 'package:fpdart/fpdart.dart';
import '../../../../core/abstract/presentation/bloc/crud/crud.bloc.dart';
import '../../../../core/common/data/models/error/app_error.model.dart';
import '../../data/models/item.model.dart';
import '../../domain/repository/item.repository.dart';

class ItemBloc extends CrudBloc<ItemModel, String> {
  final IItemRepository _repository;

  ItemBloc({required IItemRepository repository}) : _repository = repository;

  @override
  String getEntityId(ItemModel entity) {
    return entity.id;
  }

  @override
  Future<Either<AppErrorModel, List<ItemModel>>> readAllEntities() {
    return _repository.getAllItems();
  }

  @override
  Future<Either<AppErrorModel, List<ItemModel>>> createEntity(
    ItemModel entity,
  ) {
    return _repository.createItem(item: entity);
  }

  @override
  Future<Either<AppErrorModel, List<ItemModel>>> deleteEntity(String id) {
    return _repository.deleteItem(id: id);
  }

  @override
  Future<Either<AppErrorModel, ItemModel>> readEntity(String id) {
    // TODO: implement readEntity
    throw UnimplementedError();
  }

  @override
  Future<Either<AppErrorModel, List<ItemModel>>> updateEntity(
    ItemModel entity,
  ) {
    return _repository.updateItem(item: entity);
  }
}
