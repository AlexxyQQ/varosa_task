import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../common/data/models/error/app_error.model.dart';

part 'crud.event.dart';
part 'crud.state.dart';

part 'crud.bloc.freezed.dart';

abstract class CrudBloc<T, ID> extends Bloc<CrudEvent<T>, CrudState<T>> {
  CrudBloc() : super(CrudState.initial()) {
    on<GetAllEntitiesEvent<T>>(_onGetAllEntities);
    on<GetEntityByIdEvent<T>>(_onGetEntityById);
    on<CreateEntityEvent<T>>(_onCreateEntity);
    on<UpdateEntityEvent<T>>(_onUpdateEntity);
    on<DeleteEntityEvent<T>>(_onDeleteEntity);
  }

  ID getEntityId(T entity);

  Future<Either<AppErrorModel, List<T>>> readAllEntities();

  Future<void> _onGetAllEntities(
    GetAllEntitiesEvent<T> event,
    Emitter<CrudState<T>> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null, successMessage: null));
    final result = await readAllEntities();
    result.fold(
      (error) => emit(
        state.copyWith(error: error, isLoading: false, successMessage: null),
      ),
      (entities) => emit(
        state.copyWith(
          entities: entities,
          isLoading: false,
          error: null,
          successMessage: null,
        ),
      ),
    );
  }

  Future<Either<AppErrorModel, T>> readEntity(ID id);

  Future<void> _onGetEntityById(
    GetEntityByIdEvent<T> event,
    Emitter<CrudState<T>> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null, successMessage: null));
    final result = await readEntity(event.id as ID);
    result.fold(
      (error) => emit(
        state.copyWith(error: error, isLoading: false, successMessage: null),
      ),
      (entity) => emit(
        state.copyWith(
          selectedEntity: entity,
          isLoading: false,
          successMessage: null,
        ),
      ),
    );
  }

  Future<Either<AppErrorModel, List<T>>> createEntity(T entity);

  Future<void> _onCreateEntity(
    CreateEntityEvent<T> event,
    Emitter<CrudState<T>> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null, successMessage: null));
    final result = await createEntity(event.entity);
    result.fold(
      (error) => emit(
        state.copyWith(error: error, isLoading: false, successMessage: null),
      ),
      (entities) => emit(
        state.copyWith(
          entities: entities,
          isLoading: false,
          error: null,
          successMessage: "Entity created successfully",
        ),
      ),
    );
  }

  Future<Either<AppErrorModel, List<T>>> updateEntity(T entity);

  Future<void> _onUpdateEntity(
    UpdateEntityEvent<T> event,
    Emitter<CrudState<T>> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null, successMessage: null));
    final result = await updateEntity(event.entity);
    result.fold(
      (error) => emit(
        state.copyWith(error: error, isLoading: false, successMessage: null),
      ),
      (entities) => emit(
        state.copyWith(
          entities: entities,
          isLoading: false,
          error: null,
          successMessage: "Entity updated successfully",
        ),
      ),
    );
  }

  Future<Either<AppErrorModel, List<T>>> deleteEntity(ID id);

  Future<void> _onDeleteEntity(
    DeleteEntityEvent<T> event,
    Emitter<CrudState<T>> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: null));
    final result = await deleteEntity(getEntityId(event.entity));
    result.fold(
      (error) => emit(
        state.copyWith(error: error, isLoading: false, successMessage: null),
      ),
      (entities) => emit(
        state.copyWith(
          isLoading: false,
          successMessage: "Entity deleted successfully",
          error: null,
          entities: entities,
        ),
      ),
    );
  }
}
