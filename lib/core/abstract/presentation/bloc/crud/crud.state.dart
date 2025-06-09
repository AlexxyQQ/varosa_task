part of 'crud.bloc.dart';

@freezed
abstract class CrudState<T> with _$CrudState<T> {
  const CrudState._();

  const factory CrudState({
    @Default(false) bool isLoading,
    @Default([]) List<T> entities,
    AppErrorModel? error,
    T? selectedEntity,
    String? successMessage,
  }) = _CrudState;

  factory CrudState.initial() => CrudState<T>();
}
