import 'package:freezed_annotation/freezed_annotation.dart';

import 'form_input.model.dart';

part 'form_step.model.freezed.dart';
part 'form_step.model.g.dart';

@freezed
abstract class FormStep with _$FormStep {
  const factory FormStep({
    required String title,
    required String description,
    required List<FormInput> inputs,
  }) = _FormStep;

  factory FormStep.fromJson(Map<String, dynamic> json) =>
      _$FormStepFromJson(json);
}
