// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form_validation.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FormValidationModel {

 bool? get numberOnly; int? get minLength; int? get maxLength; String? get pattern;
/// Create a copy of FormValidationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormValidationModelCopyWith<FormValidationModel> get copyWith => _$FormValidationModelCopyWithImpl<FormValidationModel>(this as FormValidationModel, _$identity);

  /// Serializes this FormValidationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormValidationModel&&(identical(other.numberOnly, numberOnly) || other.numberOnly == numberOnly)&&(identical(other.minLength, minLength) || other.minLength == minLength)&&(identical(other.maxLength, maxLength) || other.maxLength == maxLength)&&(identical(other.pattern, pattern) || other.pattern == pattern));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,numberOnly,minLength,maxLength,pattern);

@override
String toString() {
  return 'FormValidationModel(numberOnly: $numberOnly, minLength: $minLength, maxLength: $maxLength, pattern: $pattern)';
}


}

/// @nodoc
abstract mixin class $FormValidationModelCopyWith<$Res>  {
  factory $FormValidationModelCopyWith(FormValidationModel value, $Res Function(FormValidationModel) _then) = _$FormValidationModelCopyWithImpl;
@useResult
$Res call({
 bool? numberOnly, int? minLength, int? maxLength, String? pattern
});




}
/// @nodoc
class _$FormValidationModelCopyWithImpl<$Res>
    implements $FormValidationModelCopyWith<$Res> {
  _$FormValidationModelCopyWithImpl(this._self, this._then);

  final FormValidationModel _self;
  final $Res Function(FormValidationModel) _then;

/// Create a copy of FormValidationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? numberOnly = freezed,Object? minLength = freezed,Object? maxLength = freezed,Object? pattern = freezed,}) {
  return _then(_self.copyWith(
numberOnly: freezed == numberOnly ? _self.numberOnly : numberOnly // ignore: cast_nullable_to_non_nullable
as bool?,minLength: freezed == minLength ? _self.minLength : minLength // ignore: cast_nullable_to_non_nullable
as int?,maxLength: freezed == maxLength ? _self.maxLength : maxLength // ignore: cast_nullable_to_non_nullable
as int?,pattern: freezed == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _FormValidationModel implements FormValidationModel {
  const _FormValidationModel({this.numberOnly, this.minLength, this.maxLength, this.pattern});
  factory _FormValidationModel.fromJson(Map<String, dynamic> json) => _$FormValidationModelFromJson(json);

@override final  bool? numberOnly;
@override final  int? minLength;
@override final  int? maxLength;
@override final  String? pattern;

/// Create a copy of FormValidationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormValidationModelCopyWith<_FormValidationModel> get copyWith => __$FormValidationModelCopyWithImpl<_FormValidationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormValidationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormValidationModel&&(identical(other.numberOnly, numberOnly) || other.numberOnly == numberOnly)&&(identical(other.minLength, minLength) || other.minLength == minLength)&&(identical(other.maxLength, maxLength) || other.maxLength == maxLength)&&(identical(other.pattern, pattern) || other.pattern == pattern));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,numberOnly,minLength,maxLength,pattern);

@override
String toString() {
  return 'FormValidationModel(numberOnly: $numberOnly, minLength: $minLength, maxLength: $maxLength, pattern: $pattern)';
}


}

/// @nodoc
abstract mixin class _$FormValidationModelCopyWith<$Res> implements $FormValidationModelCopyWith<$Res> {
  factory _$FormValidationModelCopyWith(_FormValidationModel value, $Res Function(_FormValidationModel) _then) = __$FormValidationModelCopyWithImpl;
@override @useResult
$Res call({
 bool? numberOnly, int? minLength, int? maxLength, String? pattern
});




}
/// @nodoc
class __$FormValidationModelCopyWithImpl<$Res>
    implements _$FormValidationModelCopyWith<$Res> {
  __$FormValidationModelCopyWithImpl(this._self, this._then);

  final _FormValidationModel _self;
  final $Res Function(_FormValidationModel) _then;

/// Create a copy of FormValidationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? numberOnly = freezed,Object? minLength = freezed,Object? maxLength = freezed,Object? pattern = freezed,}) {
  return _then(_FormValidationModel(
numberOnly: freezed == numberOnly ? _self.numberOnly : numberOnly // ignore: cast_nullable_to_non_nullable
as bool?,minLength: freezed == minLength ? _self.minLength : minLength // ignore: cast_nullable_to_non_nullable
as int?,maxLength: freezed == maxLength ? _self.maxLength : maxLength // ignore: cast_nullable_to_non_nullable
as int?,pattern: freezed == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
