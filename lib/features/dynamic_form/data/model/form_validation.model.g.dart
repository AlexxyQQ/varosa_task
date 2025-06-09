// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_validation.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FormValidationModel _$FormValidationModelFromJson(Map<String, dynamic> json) =>
    _FormValidationModel(
      numberOnly: json['numberOnly'] as bool?,
      minLength: (json['minLength'] as num?)?.toInt(),
      maxLength: (json['maxLength'] as num?)?.toInt(),
      pattern: json['pattern'] as String?,
    );

Map<String, dynamic> _$FormValidationModelToJson(
  _FormValidationModel instance,
) => <String, dynamic>{
  'numberOnly': instance.numberOnly,
  'minLength': instance.minLength,
  'maxLength': instance.maxLength,
  'pattern': instance.pattern,
};
