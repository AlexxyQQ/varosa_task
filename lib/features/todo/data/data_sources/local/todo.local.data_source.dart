import 'dart:convert';

import '../../../../../core/abstract/data/data_source/abstract.secure_storage.data_source.dart';
import '../../../../../core/common/domain/services/storage/secure_storage.service.dart';
import '../../../../../core/di/main.di.dart';
import '../../models/item.model.dart';

class ItemLocalDataSource extends ISecureStorageDataSource<ItemModel> {
  ItemLocalDataSource()
    : super(modelKey: 'item', secureStorageService: sl<SecureStorageService>());

  @override
  fromJson(String json) {
    return ItemModel.fromJson(jsonDecode(json));
  }

  @override
  String toJson(object) {
    return jsonEncode(object.toJson());
  }

  @override
  ItemModel copyWith(ItemModel existingItem, ItemModel newValue) {
    return existingItem.copyWith(
      id: newValue.id,
      name: newValue.name ?? existingItem.name,
      description: newValue.description ?? existingItem.description,
      status: newValue.status ?? existingItem.status,
      createdAt: newValue.createdAt ?? existingItem.createdAt,
      updatedAt: newValue.updatedAt,
    );
  }
}
