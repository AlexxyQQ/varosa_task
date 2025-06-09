import 'package:freezed_annotation/freezed_annotation.dart';

import 'form_validation.model.dart';

part 'form_input.model.freezed.dart';
part 'form_input.model.g.dart';

@freezed
abstract class FormInputModel with _$FormInputModel {
  const FormInputModel._();

  const factory FormInputModel({
    String? key,
    String? type,
    String? label,
    bool? required,
    dynamic defaultValue,
    @JsonKey(name: 'default') dynamic defaultValueAlt,
    List<String>? options,
    FormValidationModel? validation,
  }) = _FormInputModel;

  factory FormInputModel.fromJson(Map<String, dynamic> json) =>
      _$FormInputModelFromJson(json);
}
