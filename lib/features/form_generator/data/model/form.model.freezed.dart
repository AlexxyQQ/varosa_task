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
mixin _$FormData {

 String get title; List<FormStep> get steps;
/// Create a copy of FormData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormDataCopyWith<FormData> get copyWith => _$FormDataCopyWithImpl<FormData>(this as FormData, _$identity);

  /// Serializes this FormData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormData&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.steps, steps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(steps));

@override
String toString() {
  return 'FormData(title: $title, steps: $steps)';
}


}

/// @nodoc
abstract mixin class $FormDataCopyWith<$Res>  {
  factory $FormDataCopyWith(FormData value, $Res Function(FormData) _then) = _$FormDataCopyWithImpl;
@useResult
$Res call({
 String title, List<FormStep> steps
});




}
/// @nodoc
class _$FormDataCopyWithImpl<$Res>
    implements $FormDataCopyWith<$Res> {
  _$FormDataCopyWithImpl(this._self, this._then);

  final FormData _self;
  final $Res Function(FormData) _then;

/// Create a copy of FormData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? steps = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,steps: null == steps ? _self.steps : steps // ignore: cast_nullable_to_non_nullable
as List<FormStep>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FormData implements FormData {
  const _FormData({required this.title, required final  List<FormStep> steps}): _steps = steps;
  factory _FormData.fromJson(Map<String, dynamic> json) => _$FormDataFromJson(json);

@override final  String title;
 final  List<FormStep> _steps;
@override List<FormStep> get steps {
  if (_steps is EqualUnmodifiableListView) return _steps;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_steps);
}


/// Create a copy of FormData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormDataCopyWith<_FormData> get copyWith => __$FormDataCopyWithImpl<_FormData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormData&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._steps, _steps));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,const DeepCollectionEquality().hash(_steps));

@override
String toString() {
  return 'FormData(title: $title, steps: $steps)';
}


}

/// @nodoc
abstract mixin class _$FormDataCopyWith<$Res> implements $FormDataCopyWith<$Res> {
  factory _$FormDataCopyWith(_FormData value, $Res Function(_FormData) _then) = __$FormDataCopyWithImpl;
@override @useResult
$Res call({
 String title, List<FormStep> steps
});




}
/// @nodoc
class __$FormDataCopyWithImpl<$Res>
    implements _$FormDataCopyWith<$Res> {
  __$FormDataCopyWithImpl(this._self, this._then);

  final _FormData _self;
  final $Res Function(_FormData) _then;

/// Create a copy of FormData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? steps = null,}) {
  return _then(_FormData(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,steps: null == steps ? _self._steps : steps // ignore: cast_nullable_to_non_nullable
as List<FormStep>,
  ));
}


}

// dart format on
