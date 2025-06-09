// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_step.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FormStepModel _$FormStepModelFromJson(Map<String, dynamic> json) =>
    _FormStepModel(
      title: json['title'] as String?,
      description: json['description'] as String?,
      inputs: (json['inputs'] as List<dynamic>?)
          ?.map((e) => FormInputModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FormStepModelToJson(_FormStepModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'inputs': instance.inputs,
    };
