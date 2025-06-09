import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../../config/theme/components_theme/picture.theme.dart';
import 'app_svg_picture.widget.dart';

class AppCachedNetworkImage extends StatelessWidget {
  const AppCachedNetworkImage._({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.imageBuilder,
    this.theme,
    this.placeholder,
    this.errorWidget,
    // ignore: unused_element_parameter
    this.altText,
  });

  final double? width;
  final double? height;
  final String? imageUrl;
  final Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder;
  final PictureTheme? theme;
  final Widget? placeholder;
  final Widget? errorWidget;
  final String? altText;

  // Avatar factory constructor: circular shape with border and default image
  factory AppCachedNetworkImage.avatar({
    double? width,
    double? height,
    String? imageUrl,
    required String alt,
    PictureTheme? theme,
  }) {
    return AppCachedNetworkImage._(
      width: width?.w,
      height: height?.h,
      imageUrl: imageUrl,
      theme: theme,
      imageBuilder: (context, imageProvider) {
        return Container(
          width: width?.w,
          height: height?.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme?.backgroundColor ?? PrimitiveColors.transparent,
            border: Border.all(
              color: theme?.borderColor ?? PrimitiveColors.transparent,
              width: theme?.borderWidth ?? 0,
            ),
            image: imageUrl != null
                ? DecorationImage(
                    image: imageProvider,
                    fit: theme?.fit ?? BoxFit.cover,
                  )
                : null,
          ),
          child: imageUrl == null
              ? ImageNoDataWidget(
                  title: alt,
                  theme: theme,
                  width: width?.w,
                  height: height?.h,
                )
              : null,
        );
      },
      placeholder: ImagePlaceholderWidget(
        theme: theme,
        width: width,
        height: height,
      ),
      errorWidget: ImageNoDataWidget(
        title: alt,
        theme: theme,
        width: width,
        height: height,
      ),
    );
  }

  // Custom factory constructor for allowing full customization
  factory AppCachedNetworkImage.custom({
    Key? key,
    required double width,
    required double height,
    required String imageUrl,
    Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder,
    PictureTheme? theme,
    Widget? placeholder,
    Widget? errorWidget,
    required String alt,
  }) {
    return AppCachedNetworkImage._(
      key: key,
      width: width.w,
      height: height.h,
      imageUrl: imageUrl,
      placeholder: placeholder,
      errorWidget: errorWidget,
      imageBuilder: imageBuilder,
      theme: theme,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      width: width?.w,
      height: height?.h,
      fit: theme?.fit ?? BoxFit.cover,
      imageBuilder:
          imageBuilder ??
          (context, imageProvider) {
            return Container(
              width: width?.w,
              height: height?.h,
              decoration: BoxDecoration(
                shape: theme?.shape ?? BoxShape.rectangle,
                color: theme?.backgroundColor ?? PrimitiveColors.transparent,
                border: Border.all(
                  color: theme?.borderColor ?? PrimitiveColors.transparent,
                  width: theme?.borderWidth ?? 0,
                ),
                image: imageUrl != null
                    ? DecorationImage(
                        image: imageProvider,
                        fit: theme?.fit ?? BoxFit.cover,
                      )
                    : null,
              ),
              child: imageUrl == null
                  ? ImageNoDataWidget(
                      title: altText,
                      theme: theme,
                      width: width?.w,
                      height: height?.h,
                    )
                  : null,
            );
          },
      placeholder: (context, url) =>
          placeholder ??
          ImagePlaceholderWidget(theme: theme, width: width, height: height),
      errorWidget: (context, url, error) {
        log('Error loading image: $error', name: "AppCachedNetworkImage");
        return errorWidget ??
            ImageNoDataWidget(
              title: altText,
              theme: theme,
              width: width,
              height: height,
            );
      },
      useOldImageOnUrlChange: true,
      errorListener: (value) {
        log(value.toString(), name: "AppCachedNetworkImage");
      },
    );
  }
}
