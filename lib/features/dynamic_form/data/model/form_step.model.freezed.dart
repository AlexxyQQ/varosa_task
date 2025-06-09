// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form_step.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FormStepModel {

 String? get title; String? get description; List<FormInputModel>? get inputs;
/// Create a copy of FormStepModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormStepModelCopyWith<FormStepModel> get copyWith => _$FormStepModelCopyWithImpl<FormStepModel>(this as FormStepModel, _$identity);

  /// Serializes this FormStepModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormStepModel&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.inputs, inputs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,const DeepCollectionEquality().hash(inputs));

@override
String toString() {
  return 'FormStepModel(title: $title, description: $description, inputs: $inputs)';
}


}

/// @nodoc
abstract mixin class $FormStepModelCopyWith<$Res>  {
  factory $FormStepModelCopyWith(FormStepModel value, $Res Function(FormStepModel) _then) = _$FormStepModelCopyWithImpl;
@useResult
$Res call({
 String? title, String? description, List<FormInputModel>? inputs
});




}
/// @nodoc
class _$FormStepModelCopyWithImpl<$Res>
    implements $FormStepModelCopyWith<$Res> {
  _$FormStepModelCopyWithImpl(this._self, this._then);

  final FormStepModel _self;
  final $Res Function(FormStepModel) _then;

/// Create a copy of FormStepModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? description = freezed,Object? inputs = freezed,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,inputs: freezed == inputs ? _self.inputs : inputs // ignore: cast_nullable_to_non_nullable
as List<FormInputModel>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FormStepModel implements FormStepModel {
  const _FormStepModel({this.title, this.description, final  List<FormInputModel>? inputs}): _inputs = inputs;
  factory _FormStepModel.fromJson(Map<String, dynamic> json) => _$FormStepModelFromJson(json);

@override final  String? title;
@override final  String? description;
 final  List<FormInputModel>? _inputs;
@override List<FormInputModel>? get inputs {
  final value = _inputs;
  if (value == null) return null;
  if (_inputs is EqualUnmodifiableListView) return _inputs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of FormStepModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormStepModelCopyWith<_FormStepModel> get copyWith => __$FormStepModelCopyWithImpl<_FormStepModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormStepModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormStepModel&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._inputs, _inputs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,const DeepCollectionEquality().hash(_inputs));

@override
String toString() {
  return 'FormStepModel(title: $title, description: $description, inputs: $inputs)';
}


}

/// @nodoc
abstract mixin class _$FormStepModelCopyWith<$Res> implements $FormStepModelCopyWith<$Res> {
  factory _$FormStepModelCopyWith(_FormStepModel value, $Res Function(_FormStepModel) _then) = __$FormStepModelCopyWithImpl;
@override @useResult
$Res call({
 String? title, String? description, List<FormInputModel>? inputs
});




}
/// @nodoc
class __$FormStepModelCopyWithImpl<$Res>
    implements _$FormStepModelCopyWith<$Res> {
  __$FormStepModelCopyWithImpl(this._self, this._then);

  final _FormStepModel _self;
  final $Res Function(_FormStepModel) _then;

/// Create a copy of FormStepModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? description = freezed,Object? inputs = freezed,}) {
  return _then(_FormStepModel(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,inputs: freezed == inputs ? _self._inputs : inputs // ignore: cast_nullable_to_non_nullable
as List<FormInputModel>?,
  ));
}


}

// dart format on
