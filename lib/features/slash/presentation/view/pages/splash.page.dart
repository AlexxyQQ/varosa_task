import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../../core/common/domain/services/navigation/navigation.service.dart';
import '../../../../../core/common/presentation/routes/app_router.gr.dart';
import '../../../../../core/common/presentation/views/widgets/app_loader.widget.dart';
import '../../../../../core/di/main.di.dart';

@RoutePage(name: 'SplashRoute')
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Navigate to home page
    Future.delayed(const Duration(seconds: 2), () {
      sl<NavigationService>().replaceAll([const TodoPageRoute()]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: AppLoader(color: PrimitiveColors.primary)),
    );
  }
}
