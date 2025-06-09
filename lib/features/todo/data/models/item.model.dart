import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/common/data/models/helpers/model_generator.helper.dart';
import '../enums/item_status.enum.dart';

part 'item.model.freezed.dart';
part 'item.model.g.dart';

@freezed
abstract class ItemModel with _$ItemModel {
  const ItemModel._();

  const factory ItemModel({
    @JsonKey(fromJson: ModelGeneratorHelper.generateUuidFromJson)
    required String id,
    String? name,
    String? description,
    ItemStatus? status,
    @JsonKey(fromJson: ModelGeneratorHelper.generateCreatedAtFromJson)
    DateTime? createdAt,
    @JsonKey(fromJson: ModelGeneratorHelper.generateUpdatedAtFromJson)
    DateTime? updatedAt,
  }) = _ItemModel;

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);
}
