// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'form_input.model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FormInput {

 String get key; String get type; String get label; bool get required; dynamic get defaultValue;@JsonKey(name: 'default') dynamic get defaultValueAlt; List<String>? get options; FormValidation? get validation;
/// Create a copy of FormInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormInputCopyWith<FormInput> get copyWith => _$FormInputCopyWithImpl<FormInput>(this as FormInput, _$identity);

  /// Serializes this FormInput to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormInput&&(identical(other.key, key) || other.key == key)&&(identical(other.type, type) || other.type == type)&&(identical(other.label, label) || other.label == label)&&(identical(other.required, required) || other.required == required)&&const DeepCollectionEquality().equals(other.defaultValue, defaultValue)&&const DeepCollectionEquality().equals(other.defaultValueAlt, defaultValueAlt)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.validation, validation) || other.validation == validation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,type,label,required,const DeepCollectionEquality().hash(defaultValue),const DeepCollectionEquality().hash(defaultValueAlt),const DeepCollectionEquality().hash(options),validation);

@override
String toString() {
  return 'FormInput(key: $key, type: $type, label: $label, required: $required, defaultValue: $defaultValue, defaultValueAlt: $defaultValueAlt, options: $options, validation: $validation)';
}


}

/// @nodoc
abstract mixin class $FormInputCopyWith<$Res>  {
  factory $FormInputCopyWith(FormInput value, $Res Function(FormInput) _then) = _$FormInputCopyWithImpl;
@useResult
$Res call({
 String key, String type, String label, bool required, dynamic defaultValue,@JsonKey(name: 'default') dynamic defaultValueAlt, List<String>? options, FormValidation? validation
});


$FormValidationCopyWith<$Res>? get validation;

}
/// @nodoc
class _$FormInputCopyWithImpl<$Res>
    implements $FormInputCopyWith<$Res> {
  _$FormInputCopyWithImpl(this._self, this._then);

  final FormInput _self;
  final $Res Function(FormInput) _then;

/// Create a copy of FormInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? type = null,Object? label = null,Object? required = null,Object? defaultValue = freezed,Object? defaultValueAlt = freezed,Object? options = freezed,Object? validation = freezed,}) {
  return _then(_self.copyWith(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,required: null == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as bool,defaultValue: freezed == defaultValue ? _self.defaultValue : defaultValue // ignore: cast_nullable_to_non_nullable
as dynamic,defaultValueAlt: freezed == defaultValueAlt ? _self.defaultValueAlt : defaultValueAlt // ignore: cast_nullable_to_non_nullable
as dynamic,options: freezed == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<String>?,validation: freezed == validation ? _self.validation : validation // ignore: cast_nullable_to_non_nullable
as FormValidation?,
  ));
}
/// Create a copy of FormInput
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FormValidationCopyWith<$Res>? get validation {
    if (_self.validation == null) {
    return null;
  }

  return $FormValidationCopyWith<$Res>(_self.validation!, (value) {
    return _then(_self.copyWith(validation: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _FormInput extends FormInput {
  const _FormInput({required this.key, required this.type, required this.label, required this.required, this.defaultValue, @JsonKey(name: 'default') this.defaultValueAlt, final  List<String>? options, this.validation}): _options = options,super._();
  factory _FormInput.fromJson(Map<String, dynamic> json) => _$FormInputFromJson(json);

@override final  String key;
@override final  String type;
@override final  String label;
@override final  bool required;
@override final  dynamic defaultValue;
@override@JsonKey(name: 'default') final  dynamic defaultValueAlt;
 final  List<String>? _options;
@override List<String>? get options {
  final value = _options;
  if (value == null) return null;
  if (_options is EqualUnmodifiableListView) return _options;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  FormValidation? validation;

/// Create a copy of FormInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormInputCopyWith<_FormInput> get copyWith => __$FormInputCopyWithImpl<_FormInput>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormInputToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormInput&&(identical(other.key, key) || other.key == key)&&(identical(other.type, type) || other.type == type)&&(identical(other.label, label) || other.label == label)&&(identical(other.required, required) || other.required == required)&&const DeepCollectionEquality().equals(other.defaultValue, defaultValue)&&const DeepCollectionEquality().equals(other.defaultValueAlt, defaultValueAlt)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.validation, validation) || other.validation == validation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,type,label,required,const DeepCollectionEquality().hash(defaultValue),const DeepCollectionEquality().hash(defaultValueAlt),const DeepCollectionEquality().hash(_options),validation);

@override
String toString() {
  return 'FormInput(key: $key, type: $type, label: $label, required: $required, defaultValue: $defaultValue, defaultValueAlt: $defaultValueAlt, options: $options, validation: $validation)';
}


}

/// @nodoc
abstract mixin class _$FormInputCopyWith<$Res> implements $FormInputCopyWith<$Res> {
  factory _$FormInputCopyWith(_FormInput value, $Res Function(_FormInput) _then) = __$FormInputCopyWithImpl;
@override @useResult
$Res call({
 String key, String type, String label, bool required, dynamic defaultValue,@JsonKey(name: 'default') dynamic defaultValueAlt, List<String>? options, FormValidation? validation
});


@override $FormValidationCopyWith<$Res>? get validation;

}
/// @nodoc
class __$FormInputCopyWithImpl<$Res>
    implements _$FormInputCopyWith<$Res> {
  __$FormInputCopyWithImpl(this._self, this._then);

  final _FormInput _self;
  final $Res Function(_FormInput) _then;

/// Create a copy of FormInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? type = null,Object? label = null,Object? required = null,Object? defaultValue = freezed,Object? defaultValueAlt = freezed,Object? options = freezed,Object? validation = freezed,}) {
  return _then(_FormInput(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,required: null == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as bool,defaultValue: freezed == defaultValue ? _self.defaultValue : defaultValue // ignore: cast_nullable_to_non_nullable
as dynamic,defaultValueAlt: freezed == defaultValueAlt ? _self.defaultValueAlt : defaultValueAlt // ignore: cast_nullable_to_non_nullable
as dynamic,options: freezed == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>?,validation: freezed == validation ? _self.validation : validation // ignore: cast_nullable_to_non_nullable
as FormValidation?,
  ));
}

/// Create a copy of FormInput
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FormValidationCopyWith<$Res>? get validation {
    if (_self.validation == null) {
    return null;
  }

  return $FormValidationCopyWith<$Res>(_self.validation!, (value) {
    return _then(_self.copyWith(validation: value));
  });
}
}

// dart format on
