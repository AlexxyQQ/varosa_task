import 'package:flutter/material.dart';

import '../../../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../../../config/theme/components_theme/app_icon.theme.dart';
import '../styles/app_icon.style.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color? color;
  final String? semanticLabel;
  final TextDirection? textDirection;
  final VoidCallback? onTap;
  final bool isCircular;
  final Color? backgroundColor;
  final double? circularRadius;
  final AppIconTheme? theme;

  const AppIcon(
    this.icon, {
    super.key,
    this.size,
    this.color,
    this.semanticLabel,
    this.textDirection,
    this.onTap,
    this.isCircular = false,
    this.backgroundColor,
    this.circularRadius,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final appIconTheme = AppIconStyles.getTheme(theme);

    Widget iconWidget = Icon(
      icon,
      size: size ?? appIconTheme.size,
      color: color ?? appIconTheme.color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );

    // Wrap in circular container if needed
    final shouldBeCircular = isCircular || (appIconTheme.isCircular ?? false);
    if (shouldBeCircular) {
      final containerSize =
          circularRadius ??
          appIconTheme.containerHeight ??
          appIconTheme.containerWidth ??
          (size != null ? size! * 2 : 48);

      iconWidget = Container(
        width: containerSize,
        height: containerSize,
        padding: appIconTheme.containerPadding,
        decoration: BoxDecoration(
          shape: appIconTheme.shape ?? BoxShape.circle,
          color:
              backgroundColor ??
              appIconTheme.backgroundColor ??
              Theme.of(context).primaryColor.withOpacity(0.1),
          border:
              appIconTheme.borderWidth != null &&
                  appIconTheme.borderColor != null
              ? Border.all(
                  color: appIconTheme.borderColor!,
                  width: appIconTheme.borderWidth!,
                )
              : null,
          borderRadius: appIconTheme.shape == BoxShape.rectangle
              ? appIconTheme.borderRadius
              : null,
        ),
        child: Center(child: iconWidget),
      );
    }

    // Wrap with GestureDetector if onTap is provided
    if (onTap != null) {
      iconWidget = GestureDetector(onTap: onTap, child: iconWidget);
    }

    return iconWidget;
  }

  // Factory constructor for disabled state
  factory AppIcon.disabled(
    IconData icon, {
    double? size,
    String? semanticLabel,
    TextDirection? textDirection,
    AppIconTheme? theme,
  }) {
    return AppIcon(
      icon,
      size: size,
      color: PrimitiveColors.onPrimaryDisabled,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
      theme: theme,
    );
  }

  // Factory constructor for circular icon
  factory AppIcon.circular(
    IconData icon, {
    double? size,
    Color? color,
    Color? backgroundColor,
    String? semanticLabel,
    TextDirection? textDirection,
    double? circularRadius,
    AppIconTheme? theme,
    VoidCallback? onTap,
  }) {
    return AppIcon(
      icon,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
      isCircular: true,
      backgroundColor: backgroundColor,
      circularRadius: circularRadius,
      theme: theme,
      onTap: onTap,
    );
  }
}
