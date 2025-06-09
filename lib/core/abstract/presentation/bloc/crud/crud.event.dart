part of 'crud.bloc.dart';

abstract class CrudEvent<T> extends Equatable {
  const CrudEvent();

  @override
  List<Object?> get props => [];
}

// Get All Entities
class GetAllEntitiesEvent<T> extends CrudEvent<T> {}

// Get Entity By Id
class GetEntityByIdEvent<T> extends CrudEvent<T> {
  final String id;

  const GetEntityByIdEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

// Create Entity
class CreateEntityEvent<T> extends CrudEvent<T> {
  final T entity;

  const CreateEntityEvent({required this.entity});

  @override
  List<Object?> get props => [entity];
}

// Update Entity
class UpdateEntityEvent<T> extends CrudEvent<T> {
  final T entity;

  const UpdateEntityEvent({required this.entity});

  @override
  List<Object?> get props => [entity];
}

// Delete Entity
class DeleteEntityEvent<T> extends CrudEvent<T> {
  final T entity;

  const DeleteEntityEvent({required this.entity});

  @override
  List<Object?> get props => [entity];
}
