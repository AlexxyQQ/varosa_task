// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => _ItemModel(
  id: ModelGeneratorHelper.generateUuidFromJson(json['id'] as String?),
  name: json['name'] as String?,
  description: json['description'] as String?,
  status: $enumDecodeNullable(_$ItemStatusEnumMap, json['status']),
  createdAt: ModelGeneratorHelper.generateCreatedAtFromJson(
    json['createdAt'] as String?,
  ),
  updatedAt: ModelGeneratorHelper.generateUpdatedAtFromJson(
    json['updatedAt'] as String?,
  ),
);

Map<String, dynamic> _$ItemModelToJson(_ItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'status': _$ItemStatusEnumMap[instance.status],
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$ItemStatusEnumMap = {
  ItemStatus.completed: 'completed',
  ItemStatus.archived: 'archived',
  ItemStatus.inProgress: 'inProgress',
  ItemStatus.backlog: 'backlog',
};
