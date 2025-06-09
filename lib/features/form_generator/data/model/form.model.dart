import 'package:freezed_annotation/freezed_annotation.dart';

import 'form_step.model.dart';

part 'form.model.freezed.dart';
part 'form.model.g.dart';

@freezed
abstract class FormData with _$FormData {
  const factory FormData({
    required String title,
    required List<FormStep> steps,
  }) = _FormData;

  factory FormData.fromJson(Map<String, dynamic> json) =>
      _$FormDataFromJson(json);
}
