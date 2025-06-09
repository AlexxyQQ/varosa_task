// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_step.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FormStep _$FormStepFromJson(Map<String, dynamic> json) => _FormStep(
  title: json['title'] as String,
  description: json['description'] as String,
  inputs: (json['inputs'] as List<dynamic>)
      .map((e) => FormInput.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$FormStepToJson(_FormStep instance) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'inputs': instance.inputs,
};
