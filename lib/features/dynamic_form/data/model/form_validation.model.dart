import 'package:freezed_annotation/freezed_annotation.dart';

part 'form_validation.model.freezed.dart';
part 'form_validation.model.g.dart';

@freezed
abstract class FormValidationModel with _$FormValidationModel {
  const factory FormValidationModel({
    bool? numberOnly,
    int? minLength,
    int? maxLength,
    String? pattern,
  }) = _FormValidationModel;

  factory FormValidationModel.fromJson(Map<String, dynamic> json) =>
      _$FormValidationModelFromJson(json);
}
