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
mixin _$FormStep {

 String get title; String get description; List<FormInput> get inputs;
/// Create a copy of FormStep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormStepCopyWith<FormStep> get copyWith => _$FormStepCopyWithImpl<FormStep>(this as FormStep, _$identity);

  /// Serializes this FormStep to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormStep&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.inputs, inputs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,const DeepCollectionEquality().hash(inputs));

@override
String toString() {
  return 'FormStep(title: $title, description: $description, inputs: $inputs)';
}


}

/// @nodoc
abstract mixin class $FormStepCopyWith<$Res>  {
  factory $FormStepCopyWith(FormStep value, $Res Function(FormStep) _then) = _$FormStepCopyWithImpl;
@useResult
$Res call({
 String title, String description, List<FormInput> inputs
});




}
/// @nodoc
class _$FormStepCopyWithImpl<$Res>
    implements $FormStepCopyWith<$Res> {
  _$FormStepCopyWithImpl(this._self, this._then);

  final FormStep _self;
  final $Res Function(FormStep) _then;

/// Create a copy of FormStep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? inputs = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,inputs: null == inputs ? _self.inputs : inputs // ignore: cast_nullable_to_non_nullable
as List<FormInput>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FormStep implements FormStep {
  const _FormStep({required this.title, required this.description, required final  List<FormInput> inputs}): _inputs = inputs;
  factory _FormStep.fromJson(Map<String, dynamic> json) => _$FormStepFromJson(json);

@override final  String title;
@override final  String description;
 final  List<FormInput> _inputs;
@override List<FormInput> get inputs {
  if (_inputs is EqualUnmodifiableListView) return _inputs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_inputs);
}


/// Create a copy of FormStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormStepCopyWith<_FormStep> get copyWith => __$FormStepCopyWithImpl<_FormStep>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormStepToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormStep&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._inputs, _inputs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,const DeepCollectionEquality().hash(_inputs));

@override
String toString() {
  return 'FormStep(title: $title, description: $description, inputs: $inputs)';
}


}

/// @nodoc
abstract mixin class _$FormStepCopyWith<$Res> implements $FormStepCopyWith<$Res> {
  factory _$FormStepCopyWith(_FormStep value, $Res Function(_FormStep) _then) = __$FormStepCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, List<FormInput> inputs
});




}
/// @nodoc
class __$FormStepCopyWithImpl<$Res>
    implements _$FormStepCopyWith<$Res> {
  __$FormStepCopyWithImpl(this._self, this._then);

  final _FormStep _self;
  final $Res Function(_FormStep) _then;

/// Create a copy of FormStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? inputs = null,}) {
  return _then(_FormStep(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,inputs: null == inputs ? _self._inputs : inputs // ignore: cast_nullable_to_non_nullable
as List<FormInput>,
  ));
}


}

// dart format on
