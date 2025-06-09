// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FromModel _$FromModelFromJson(Map<String, dynamic> json) => _FromModel(
  title: json['title'] as String?,
  steps: (json['steps'] as List<dynamic>?)
      ?.map((e) => FormStepModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$FromModelToJson(_FromModel instance) =>
    <String, dynamic>{'title': instance.title, 'steps': instance.steps};
