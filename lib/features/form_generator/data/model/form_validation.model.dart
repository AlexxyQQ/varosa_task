import 'package:freezed_annotation/freezed_annotation.dart';

part 'form_validation.model.freezed.dart';
part 'form_validation.model.g.dart';

@freezed
abstract class FormValidation with _$FormValidation {
  const factory FormValidation({
    bool? numberOnly,
    int? minLength,
    int? maxLength,
    String? pattern,
  }) = _FormValidation;

  factory FormValidation.fromJson(Map<String, dynamic> json) =>
      _$FormValidationFromJson(json);
}
