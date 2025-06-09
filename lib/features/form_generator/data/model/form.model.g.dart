// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FormData _$FormDataFromJson(Map<String, dynamic> json) => _FormData(
  title: json['title'] as String,
  steps: (json['steps'] as List<dynamic>)
      .map((e) => FormStep.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$FormDataToJson(_FormData instance) => <String, dynamic>{
  'title': instance.title,
  'steps': instance.steps,
};
