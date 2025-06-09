import 'package:freezed_annotation/freezed_annotation.dart';

import 'form_input.model.dart';

part 'form_step.model.freezed.dart';
part 'form_step.model.g.dart';

@freezed
abstract class FormStepModel with _$FormStepModel {
  const factory FormStepModel({
    String? title,
    String? description,
    List<FormInputModel>? inputs,
  }) = _FormStepModel;

  factory FormStepModel.fromJson(Map<String, dynamic> json) =>
      _$FormStepModelFromJson(json);
}
