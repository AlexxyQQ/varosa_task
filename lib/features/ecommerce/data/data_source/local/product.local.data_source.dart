import 'dart:convert';

import '../../../../../core/abstract/data/data_source/abstract.secure_storage.data_source.dart';
import '../../../../../core/common/domain/services/storage/secure_storage.service.dart';
import '../../../../../core/di/main.di.dart';
import '../../models/product.model.dart';

class ProductLocalDataSource extends ISecureStorageDataSource<ProductModel> {
  ProductLocalDataSource()
    : super(
        secureStorageService: sl<SecureStorageService>(),
        modelKey: 'product',
      );

  @override
  ProductModel copyWith(ProductModel existingItem, ProductModel newValue) {
    return existingItem.copyWith(
      id: newValue.id ?? existingItem.id,
      title: newValue.title ?? existingItem.title,
      description: newValue.description ?? existingItem.description,
      category: newValue.category ?? existingItem.category,
      price: newValue.price ?? existingItem.price,
      discountPercentage:
          newValue.discountPercentage ?? existingItem.discountPercentage,
      rating: newValue.rating ?? existingItem.rating,
      stock: newValue.stock ?? existingItem.stock,
      tags: newValue.tags ?? existingItem.tags,
      brand: newValue.brand ?? existingItem.brand,
      sku: newValue.sku ?? existingItem.sku,
      weight: newValue.weight ?? existingItem.weight,
      dimensions: newValue.dimensions ?? existingItem.dimensions,
      warrantyInformation:
          newValue.warrantyInformation ?? existingItem.warrantyInformation,
      shippingInformation:
          newValue.shippingInformation ?? existingItem.shippingInformation,
      availabilityStatus:
          newValue.availabilityStatus ?? existingItem.availabilityStatus,
      reviews: newValue.reviews ?? existingItem.reviews,
      returnPolicy: newValue.returnPolicy ?? existingItem.returnPolicy,
      minimumOrderQuantity:
          newValue.minimumOrderQuantity ?? existingItem.minimumOrderQuantity,
      meta: newValue.meta ?? existingItem.meta,
      thumbnail: newValue.thumbnail ?? existingItem.thumbnail,
      images: newValue.images ?? existingItem.images,
      isFavorite: newValue.isFavorite ?? existingItem.isFavorite,
    );
  }

  @override
  ProductModel fromJson(String json) {
    return ProductModel.fromJson(jsonDecode(json));
  }

  @override
  String toJson(ProductModel object) {
    return jsonEncode(object.toJson());
  }
}
