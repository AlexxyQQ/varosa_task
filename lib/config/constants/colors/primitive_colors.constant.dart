import '../../../core/abstract/presentation/abstract.app_color.dart';

class PrimitiveColors {
  static const CustomAppColor white = CustomAppColor(0xFFFFFFFF); // White
  static const CustomAppColor black = CustomAppColor(0xFF000000); // Black
  static const CustomAppColor transparent = CustomAppColor(0x00000000);
  static const CustomAppColor red = CustomAppColor(0xFFEB5757); // Red
  static const CustomAppColor green = CustomAppColor(0xFF27AE60); // Green
  static const CustomAppColor blue = CustomAppColor(0xFF2F97C1); // Blue
  static const CustomAppColor orange = CustomAppColor(0xFFF49342); // Orange
  static const CustomAppColor pink = CustomAppColor(0xFFEC407A); // Pink

  static const CustomAppColor hintText = CustomAppColor(0xFF828282); // Stroke
  static const CustomAppColor stroke = CustomAppColor(0xFFE0E0E0); // Stroke
  static const CustomAppColor inactive = CustomAppColor(0xFF828282); // Stroke

  static const CustomAppColor primary = CustomAppColor(0xFFFFC800); // Primary
  static const CustomAppColor onPrimary = CustomAppColor(
    0xFF000000,
  ); // On Primary
  static const CustomAppColor primaryDisabled = CustomAppColor(
    0xFFE0E0E0,
  ); // Primary Disabled
  static const CustomAppColor onPrimaryDisabled = CustomAppColor(
    0xFF828282,
  ); // On Primary Disabled

  static const CustomAppColor secondary = CustomAppColor(
    0xFF04C243,
  ); // Secondary
  static const CustomAppColor onSecondary = CustomAppColor(
    0xFFFFFFFF,
  ); // On Secondary
  static const CustomAppColor secondaryDisabled = CustomAppColor(
    0xFFE0E0E0,
  ); // Secondary Disabled
  static const CustomAppColor onSecondaryDisabled = CustomAppColor(
    0xFF828282,
  ); // On Secondary Disabled
}
