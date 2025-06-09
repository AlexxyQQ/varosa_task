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
mixin _$FormInputModel {

 String? get key; InputType? get type; String? get label; bool? get required; dynamic get defaultValue;@JsonKey(name: 'default') dynamic get defaultValueAlt; List<String>? get options; FormValidationModel? get validation;
/// Create a copy of FormInputModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FormInputModelCopyWith<FormInputModel> get copyWith => _$FormInputModelCopyWithImpl<FormInputModel>(this as FormInputModel, _$identity);

  /// Serializes this FormInputModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FormInputModel&&(identical(other.key, key) || other.key == key)&&(identical(other.type, type) || other.type == type)&&(identical(other.label, label) || other.label == label)&&(identical(other.required, required) || other.required == required)&&const DeepCollectionEquality().equals(other.defaultValue, defaultValue)&&const DeepCollectionEquality().equals(other.defaultValueAlt, defaultValueAlt)&&const DeepCollectionEquality().equals(other.options, options)&&(identical(other.validation, validation) || other.validation == validation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,type,label,required,const DeepCollectionEquality().hash(defaultValue),const DeepCollectionEquality().hash(defaultValueAlt),const DeepCollectionEquality().hash(options),validation);

@override
String toString() {
  return 'FormInputModel(key: $key, type: $type, label: $label, required: $required, defaultValue: $defaultValue, defaultValueAlt: $defaultValueAlt, options: $options, validation: $validation)';
}


}

/// @nodoc
abstract mixin class $FormInputModelCopyWith<$Res>  {
  factory $FormInputModelCopyWith(FormInputModel value, $Res Function(FormInputModel) _then) = _$FormInputModelCopyWithImpl;
@useResult
$Res call({
 String? key, InputType? type, String? label, bool? required, dynamic defaultValue,@JsonKey(name: 'default') dynamic defaultValueAlt, List<String>? options, FormValidationModel? validation
});


$FormValidationModelCopyWith<$Res>? get validation;

}
/// @nodoc
class _$FormInputModelCopyWithImpl<$Res>
    implements $FormInputModelCopyWith<$Res> {
  _$FormInputModelCopyWithImpl(this._self, this._then);

  final FormInputModel _self;
  final $Res Function(FormInputModel) _then;

/// Create a copy of FormInputModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = freezed,Object? type = freezed,Object? label = freezed,Object? required = freezed,Object? defaultValue = freezed,Object? defaultValueAlt = freezed,Object? options = freezed,Object? validation = freezed,}) {
  return _then(_self.copyWith(
key: freezed == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InputType?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,required: freezed == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as bool?,defaultValue: freezed == defaultValue ? _self.defaultValue : defaultValue // ignore: cast_nullable_to_non_nullable
as dynamic,defaultValueAlt: freezed == defaultValueAlt ? _self.defaultValueAlt : defaultValueAlt // ignore: cast_nullable_to_non_nullable
as dynamic,options: freezed == options ? _self.options : options // ignore: cast_nullable_to_non_nullable
as List<String>?,validation: freezed == validation ? _self.validation : validation // ignore: cast_nullable_to_non_nullable
as FormValidationModel?,
  ));
}
/// Create a copy of FormInputModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FormValidationModelCopyWith<$Res>? get validation {
    if (_self.validation == null) {
    return null;
  }

  return $FormValidationModelCopyWith<$Res>(_self.validation!, (value) {
    return _then(_self.copyWith(validation: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _FormInputModel extends FormInputModel {
  const _FormInputModel({this.key, this.type, this.label, this.required, this.defaultValue, @JsonKey(name: 'default') this.defaultValueAlt, final  List<String>? options, this.validation}): _options = options,super._();
  factory _FormInputModel.fromJson(Map<String, dynamic> json) => _$FormInputModelFromJson(json);

@override final  String? key;
@override final  InputType? type;
@override final  String? label;
@override final  bool? required;
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

@override final  FormValidationModel? validation;

/// Create a copy of FormInputModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FormInputModelCopyWith<_FormInputModel> get copyWith => __$FormInputModelCopyWithImpl<_FormInputModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FormInputModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FormInputModel&&(identical(other.key, key) || other.key == key)&&(identical(other.type, type) || other.type == type)&&(identical(other.label, label) || other.label == label)&&(identical(other.required, required) || other.required == required)&&const DeepCollectionEquality().equals(other.defaultValue, defaultValue)&&const DeepCollectionEquality().equals(other.defaultValueAlt, defaultValueAlt)&&const DeepCollectionEquality().equals(other._options, _options)&&(identical(other.validation, validation) || other.validation == validation));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,key,type,label,required,const DeepCollectionEquality().hash(defaultValue),const DeepCollectionEquality().hash(defaultValueAlt),const DeepCollectionEquality().hash(_options),validation);

@override
String toString() {
  return 'FormInputModel(key: $key, type: $type, label: $label, required: $required, defaultValue: $defaultValue, defaultValueAlt: $defaultValueAlt, options: $options, validation: $validation)';
}


}

/// @nodoc
abstract mixin class _$FormInputModelCopyWith<$Res> implements $FormInputModelCopyWith<$Res> {
  factory _$FormInputModelCopyWith(_FormInputModel value, $Res Function(_FormInputModel) _then) = __$FormInputModelCopyWithImpl;
@override @useResult
$Res call({
 String? key, InputType? type, String? label, bool? required, dynamic defaultValue,@JsonKey(name: 'default') dynamic defaultValueAlt, List<String>? options, FormValidationModel? validation
});


@override $FormValidationModelCopyWith<$Res>? get validation;

}
/// @nodoc
class __$FormInputModelCopyWithImpl<$Res>
    implements _$FormInputModelCopyWith<$Res> {
  __$FormInputModelCopyWithImpl(this._self, this._then);

  final _FormInputModel _self;
  final $Res Function(_FormInputModel) _then;

/// Create a copy of FormInputModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = freezed,Object? type = freezed,Object? label = freezed,Object? required = freezed,Object? defaultValue = freezed,Object? defaultValueAlt = freezed,Object? options = freezed,Object? validation = freezed,}) {
  return _then(_FormInputModel(
key: freezed == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InputType?,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String?,required: freezed == required ? _self.required : required // ignore: cast_nullable_to_non_nullable
as bool?,defaultValue: freezed == defaultValue ? _self.defaultValue : defaultValue // ignore: cast_nullable_to_non_nullable
as dynamic,defaultValueAlt: freezed == defaultValueAlt ? _self.defaultValueAlt : defaultValueAlt // ignore: cast_nullable_to_non_nullable
as dynamic,options: freezed == options ? _self._options : options // ignore: cast_nullable_to_non_nullable
as List<String>?,validation: freezed == validation ? _self.validation : validation // ignore: cast_nullable_to_non_nullable
as FormValidationModel?,
  ));
}

/// Create a copy of FormInputModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FormValidationModelCopyWith<$Res>? get validation {
    if (_self.validation == null) {
    return null;
  }

  return $FormValidationModelCopyWith<$Res>(_self.validation!, (value) {
    return _then(_self.copyWith(validation: value));
  });
}
}

// dart format on
