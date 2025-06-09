// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_input.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FormInputModel _$FormInputModelFromJson(Map<String, dynamic> json) =>
    _FormInputModel(
      key: json['key'] as String?,
      type: json['type'] as String?,
      label: json['label'] as String?,
      required: json['required'] as bool?,
      defaultValue: json['defaultValue'],
      defaultValueAlt: json['default'],
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      validation: json['validation'] == null
          ? null
          : FormValidationModel.fromJson(
              json['validation'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$FormInputModelToJson(_FormInputModel instance) =>
    <String, dynamic>{
      'key': instance.key,
      'type': instance.type,
      'label': instance.label,
      'required': instance.required,
      'defaultValue': instance.defaultValue,
      'default': instance.defaultValueAlt,
      'options': instance.options,
      'validation': instance.validation,
    };
