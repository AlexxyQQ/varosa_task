import 'package:flutter/material.dart';

import '../../../../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../abstract/presentation/abstract.app_color.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key, this.color});

  final CustomAppColor? color;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: color ?? PrimitiveColors.white,
      strokeWidth: 4,
    );
  }
}
