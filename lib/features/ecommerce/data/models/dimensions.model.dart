import 'package:freezed_annotation/freezed_annotation.dart';

part 'dimensions.model.freezed.dart';
part 'dimensions.model.g.dart';

@freezed
abstract class DimensionsModel with _$DimensionsModel {
  const factory DimensionsModel({
    double? width,
    double? height,
    double? depth,
  }) = _DimensionsModel;

  factory DimensionsModel.fromJson(Map<String, dynamic> json) =>
      _$DimensionsModelFromJson(json);
}
