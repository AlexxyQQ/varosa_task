// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FromModel {

 String? get title; List<FormStepModel>? get steps;
/// Create a copy of FromModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FromModelCopyWith<FromModel> get copyWith => _$FromModelCopyWithImpl<FromModel>(this as FromModel, _$identity);

  /// Serializes this FromModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FromModel&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.steps, steps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(steps));

@override
String toString() {
  return 'FromModel(title: $title, steps: $steps)';
}


}

/// @nodoc
abstract mixin class $FromModelCopyWith<$Res>  {
  factory $FromModelCopyWith(FromModel value, $Res Function(FromModel) _then) = _$FromModelCopyWithImpl;
@useResult
$Res call({
 String? title, List<FormStepModel>? steps
});




}
/// @nodoc
class _$FromModelCopyWithImpl<$Res>
    implements $FromModelCopyWith<$Res> {
  _$FromModelCopyWithImpl(this._self, this._then);

  final FromModel _self;
  final $Res Function(FromModel) _then;

/// Create a copy of FromModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? steps = freezed,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,steps: freezed == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<FormStepModel>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FromModel implements FromModel {
  const _FromModel({this.title, final  List<FormStepModel>? steps}): _steps = steps;
  factory _FromModel.fromJson(Map<String, dynamic> json) => _$FromModelFromJson(json);

@override final  String? title;
 final  List<FormStepModel>? _steps;
@override List<FormStepModel>? get steps {
  final value = _steps;
  if (value == null) return null;
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of FromModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FromModelCopyWith<_FromModel> get copyWith => __$FromModelCopyWithImpl<_FromModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FromModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FromModel&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._steps, _steps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(_steps));

@override
String toString() {
  return 'FromModel(title: $title, steps: $steps)';
}


}

/// @nodoc
abstract mixin class _$FromModelCopyWith<$Res> implements $FromModelCopyWith<$Res> {
  factory _$FromModelCopyWith(_FromModel value, $Res Function(_FromModel) _then) = __$FromModelCopyWithImpl;
@override @useResult
$Res call({
 String? title, List<FormStepModel>? steps
});




}
/// @nodoc
class __$FromModelCopyWithImpl<$Res>
    implements _$FromModelCopyWith<$Res> {
  __$FromModelCopyWithImpl(this._self, this._then);

  final _FromModel _self;
  final $Res Function(_FromModel) _then;

/// Create a copy of FromModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? steps = freezed,}) {
  return _then(_FromModel(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,steps: freezed == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<FormStepModel>?,
  ));
}


}

// dart format on
