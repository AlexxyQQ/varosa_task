import 'package:freezed_annotation/freezed_annotation.dart';

part 'meta.model.freezed.dart';
part 'meta.model.g.dart';

@freezed
abstract class MetaModel with _$MetaModel {
  const factory MetaModel({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? barcode,
    String? qrCode,
  }) = _MetaModel;

  factory MetaModel.fromJson(Map<String, dynamic> json) =>
      _$MetaModelFromJson(json);
}
