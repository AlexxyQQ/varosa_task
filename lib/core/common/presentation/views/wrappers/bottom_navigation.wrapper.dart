import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/constants/colors/primitive_colors.constant.dart';
import '../../../../../config/constants/fonts/all_text_styles.dart';
import '../../../../../config/constants/gen/assets.gen.dart';
import '../../../../di/main.di.dart';
import '../../routes/app_router.gr.dart';
import '../widgets/app_text.widget.dart';

@RoutePage(name: 'BottomNavigationWrapperRoute')
class BottomNavWrapperPage extends StatefulWidget {
  const BottomNavWrapperPage({super.key});

  @override
  State<BottomNavWrapperPage> createState() => _BottomNavWrapperPageState();
}

class _BottomNavWrapperPageState extends State<BottomNavWrapperPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      physics: const NeverScrollableScrollPhysics(),
      routes: [
        const TodoWrapperRoute(),
        const FormWrapperRoute(),
        const EcomWrapperRoute(),
      ],
      builder: (context, child, c) {
        final tabsRouter = context.tabsRouter;

        return Scaffold(
          body: child,
          bottomNavigationBar: _buildBottomNavigationBar(tabsRouter, context),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(
    TabsRouter tabsRouter,
    BuildContext context,
  ) {
    return SafeArea(
      bottom: false,
      child: SizedBox(
        width: double.infinity,
        child: BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          elevation: 3,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            final tabsRouter = context.tabsRouter;
            tabsRouter.setActiveIndex(index);
          },
          items: _navBarItems(tabsRouter),
          selectedItemColor: PrimitiveColors.primary,
          unselectedItemColor: PrimitiveColors.stroke,
          selectedLabelStyle: AllTextStyle.f10W4.copyWith(
            color: PrimitiveColors.primary,
          ),
          unselectedLabelStyle: AllTextStyle.f10W4.copyWith(
            color: PrimitiveColors.stroke,
          ),
          showUnselectedLabels: true,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _navBarItems(TabsRouter tabsRouter) {
    return [
      _navBarItem(
        icon: Icons.calendar_month,
        label: 'Todo',
        isActive: tabsRouter.activeIndex == 0,
      ),
      _navBarItem(
        icon: Icons.format_align_center,
        label: 'Form',
        isActive: tabsRouter.activeIndex == 1,
      ),
      _navBarItem(
        icon: Icons.abc_outlined,
        label: 'Ecom',
        isActive: tabsRouter.activeIndex == 2,
      ),
    ];
  }

  BottomNavigationBarItem _navBarItem({
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return BottomNavigationBarItem(
      icon: FittedBox(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(
              icon,
              color: isActive
                  ? PrimitiveColors.primary
                  : PrimitiveColors.stroke,
              size: 20.h,
            ),
          ],
        ),
      ),
      label: label,
    );
  }
}
