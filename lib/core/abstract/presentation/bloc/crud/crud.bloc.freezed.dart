// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'crud.bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CrudState<T> {

 bool get isLoading; List<T> get entities; AppErrorModel? get error; T? get selectedEntity; String? get successMessage;
/// Create a copy of CrudState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CrudStateCopyWith<T, CrudState<T>> get copyWith => _$CrudStateCopyWithImpl<T, CrudState<T>>(this as CrudState<T>, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CrudState<T>&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.entities, entities)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.selectedEntity, selectedEntity)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(entities),error,const DeepCollectionEquality().hash(selectedEntity),successMessage);

@override
String toString() {
  return 'CrudState<$T>(isLoading: $isLoading, entities: $entities, error: $error, selectedEntity: $selectedEntity, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class $CrudStateCopyWith<T,$Res>  {
  factory $CrudStateCopyWith(CrudState<T> value, $Res Function(CrudState<T>) _then) = _$CrudStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<T> entities, AppErrorModel? error, T? selectedEntity, String? successMessage
});


$AppErrorModelCopyWith<$Res>? get error;

}
/// @nodoc
class _$CrudStateCopyWithImpl<T,$Res>
    implements $CrudStateCopyWith<T, $Res> {
  _$CrudStateCopyWithImpl(this._self, this._then);

  final CrudState<T> _self;
  final $Res Function(CrudState<T>) _then;

/// Create a copy of CrudState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? entities = null,Object? error = freezed,Object? selectedEntity = freezed,Object? successMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,entities: null == entities ? _self.entities : entities // ignore: cast_nullable_to_non_nullable
as List<T>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppErrorModel?,selectedEntity: freezed == selectedEntity ? _self.selectedEntity : selectedEntity // ignore: cast_nullable_to_non_nullable
as T?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CrudState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppErrorModelCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $AppErrorModelCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}


/// @nodoc


class _CrudState<T> extends CrudState<T> {
  const _CrudState({this.isLoading = false, final  List<T> entities = const [], this.error, this.selectedEntity, this.successMessage}): _entities = entities,super._();
  

@override@JsonKey() final  bool isLoading;
 final  List<T> _entities;
@override@JsonKey() List<T> get entities {
  if (_entities is EqualUnmodifiableListView) return _entities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entities);
}

@override final  AppErrorModel? error;
@override final  T? selectedEntity;
@override final  String? successMessage;

/// Create a copy of CrudState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CrudStateCopyWith<T, _CrudState<T>> get copyWith => __$CrudStateCopyWithImpl<T, _CrudState<T>>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CrudState<T>&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._entities, _entities)&&(identical(other.error, error) || other.error == error)&&const DeepCollectionEquality().equals(other.selectedEntity, selectedEntity)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_entities),error,const DeepCollectionEquality().hash(selectedEntity),successMessage);

@override
String toString() {
  return 'CrudState<$T>(isLoading: $isLoading, entities: $entities, error: $error, selectedEntity: $selectedEntity, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class _$CrudStateCopyWith<T,$Res> implements $CrudStateCopyWith<T, $Res> {
  factory _$CrudStateCopyWith(_CrudState<T> value, $Res Function(_CrudState<T>) _then) = __$CrudStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<T> entities, AppErrorModel? error, T? selectedEntity, String? successMessage
});


@override $AppErrorModelCopyWith<$Res>? get error;

}
/// @nodoc
class __$CrudStateCopyWithImpl<T,$Res>
    implements _$CrudStateCopyWith<T, $Res> {
  __$CrudStateCopyWithImpl(this._self, this._then);

  final _CrudState<T> _self;
  final $Res Function(_CrudState<T>) _then;

/// Create a copy of CrudState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? entities = null,Object? error = freezed,Object? selectedEntity = freezed,Object? successMessage = freezed,}) {
  return _then(_CrudState<T>(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,entities: null == entities ? _self._entities : entities // ignore: cast_nullable_to_non_nullable
as List<T>,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as AppErrorModel?,selectedEntity: freezed == selectedEntity ? _self.selectedEntity : selectedEntity // ignore: cast_nullable_to_non_nullable
as T?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CrudState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppErrorModelCopyWith<$Res>? get error {
    if (_self.error == null) {
    return null;
  }

  return $AppErrorModelCopyWith<$Res>(_self.error!, (value) {
    return _then(_self.copyWith(error: value));
  });
}
}

// dart format on
