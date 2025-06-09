import 'package:freezed_annotation/freezed_annotation.dart';

import 'form_validation.model.dart';

part 'form_input.model.freezed.dart';
part 'form_input.model.g.dart';

@freezed
abstract class FormInput with _$FormInput {
  const FormInput._();

  const factory FormInput({
    required String key,
    required String type,
    required String label,
    required bool required,
    dynamic defaultValue,
    @JsonKey(name: 'default') dynamic defaultValueAlt,
    List<String>? options,
    FormValidation? validation,
  }) = _FormInput;

  factory FormInput.fromJson(Map<String, dynamic> json) =>
      _$FormInputFromJson(json);

  // Helper getter for default value
  dynamic get effectiveDefault => defaultValue ?? defaultValueAlt;
}
