// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dimensions.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DimensionsModel _$DimensionsModelFromJson(Map<String, dynamic> json) =>
    _DimensionsModel(
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      depth: (json['depth'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$DimensionsModelToJson(_DimensionsModel instance) =>
    <String, dynamic>{
      'width': instance.width,
      'height': instance.height,
      'depth': instance.depth,
    };
