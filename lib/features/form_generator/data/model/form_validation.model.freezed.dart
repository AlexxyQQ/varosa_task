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
mixin _$FormValidation {

 bool? get numberOnly; int? get minLength; int? get maxLength; String? get pattern;
/// Create a copy of FormValidation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormValidationCopyWith<FormValidation> get copyWith => _$FormValidationCopyWithImpl<FormValidation>(this as FormValidation, _$identity);

  /// Serializes this FormValidation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormValidation&&(identical(other.numberOnly, numberOnly) || other.numberOnly == numberOnly)&&(identical(other.minLength, minLength) || other.minLength == minLength)&&(identical(other.maxLength, maxLength) || other.maxLength == maxLength)&&(identical(other.pattern, pattern) || other.pattern == pattern));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,numberOnly,minLength,maxLength,pattern);

@override
String toString() {
  return 'FormValidation(numberOnly: $numberOnly, minLength: $minLength, maxLength: $maxLength, pattern: $pattern)';
}


}

/// @nodoc
abstract mixin class $FormValidationCopyWith<$Res>  {
  factory $FormValidationCopyWith(FormValidation value, $Res Function(FormValidation) _then) = _$FormValidationCopyWithImpl;
@useResult
$Res call({
 bool? numberOnly, int? minLength, int? maxLength, String? pattern
});




}
/// @nodoc
class _$FormValidationCopyWithImpl<$Res>
    implements $FormValidationCopyWith<$Res> {
  _$FormValidationCopyWithImpl(this._self, this._then);

  final FormValidation _self;
  final $Res Function(FormValidation) _then;

/// Create a copy of FormValidation
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

class _FormValidation implements FormValidation {
  const _FormValidation({this.numberOnly, this.minLength, this.maxLength, this.pattern});
  factory _FormValidation.fromJson(Map<String, dynamic> json) => _$FormValidationFromJson(json);

@override final  bool? numberOnly;
@override final  int? minLength;
@override final  int? maxLength;
@override final  String? pattern;

/// Create a copy of FormValidation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormValidationCopyWith<_FormValidation> get copyWith => __$FormValidationCopyWithImpl<_FormValidation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormValidationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormValidation&&(identical(other.numberOnly, numberOnly) || other.numberOnly == numberOnly)&&(identical(other.minLength, minLength) || other.minLength == minLength)&&(identical(other.maxLength, maxLength) || other.maxLength == maxLength)&&(identical(other.pattern, pattern) || other.pattern == pattern));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,numberOnly,minLength,maxLength,pattern);

@override
String toString() {
  return 'FormValidation(numberOnly: $numberOnly, minLength: $minLength, maxLength: $maxLength, pattern: $pattern)';
}


}

/// @nodoc
abstract mixin class _$FormValidationCopyWith<$Res> implements $FormValidationCopyWith<$Res> {
  factory _$FormValidationCopyWith(_FormValidation value, $Res Function(_FormValidation) _then) = __$FormValidationCopyWithImpl;
@override @useResult
$Res call({
 bool? numberOnly, int? minLength, int? maxLength, String? pattern
});




}
/// @nodoc
class __$FormValidationCopyWithImpl<$Res>
    implements _$FormValidationCopyWith<$Res> {
  __$FormValidationCopyWithImpl(this._self, this._then);

  final _FormValidation _self;
  final $Res Function(_FormValidation) _then;

/// Create a copy of FormValidation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? numberOnly = freezed,Object? minLength = freezed,Object? maxLength = freezed,Object? pattern = freezed,}) {
  return _then(_FormValidation(
numberOnly: freezed == numberOnly ? _self.numberOnly : numberOnly // ignore: cast_nullable_to_non_nullable
as bool?,minLength: freezed == minLength ? _self.minLength : minLength // ignore: cast_nullable_to_non_nullable
as int?,maxLength: freezed == maxLength ? _self.maxLength : maxLength // ignore: cast_nullable_to_non_nullable
as int?,pattern: freezed == pattern ? _self.pattern : pattern // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
