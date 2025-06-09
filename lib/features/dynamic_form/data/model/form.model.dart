import 'package:freezed_annotation/freezed_annotation.dart';

import 'form_step.model.dart';

part 'form.model.freezed.dart';
part 'form.model.g.dart';

@freezed
abstract class FromModel with _$FromModel {
  const factory FromModel({String? title, List<FormStepModel>? steps}) =
      _FromModel;

  factory FromModel.fromJson(Map<String, dynamic> json) =>
      _$FromModelFromJson(json);
}
