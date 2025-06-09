import 'package:freezed_annotation/freezed_annotation.dart';

part 'input_type.enum.g.dart';

@JsonEnum(alwaysCreate: true)
enum InputType {
  @JsonValue("text")
  text,
  @JsonValue("dropdown")
  dropdown,
  @JsonValue("toggle")
  toggle,
  @JsonValue("number")
  number,
  @JsonValue("email")
  email,
  @JsonValue("phone")
  phone;

  String toJson() => _$InputTypeEnumMap[this]!;

  static InputType? fromString(String value) => _$InputTypeEnumMap.entries
      .firstWhere(
        (element) => element.value.toLowerCase() == value.toLowerCase(),
      )
      .key;
}
