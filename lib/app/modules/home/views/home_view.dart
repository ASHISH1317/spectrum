import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_starter_kit_2024/app/data/config/app_colors.dart';
import 'package:get_starter_kit_2024/app/data/config/app_images.dart';
import 'package:get_starter_kit_2024/app/modules/dashboard/views/dashboard_view.dart';
import 'package:get_starter_kit_2024/app/modules/profile/views/profile_view.dart';
import 'package:get_starter_kit_2024/app/modules/reports/views/reports_view.dart';
import 'package:get_starter_kit_2024/app/modules/settings/views/settings_view.dart';
import '../controllers/home_controller.dart';

/// Home view class
class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => HomeController());
    return Scaffold(
      backgroundColor: AppColors.kFFFFFF,
      bottomNavigationBar: Obx(
        () => NavigationBar(
          elevation: 5,
          backgroundColor: AppColors.kF0F8FF,
          selectedIndex: controller.selectedTabIndex(),
          indicatorColor: AppColors.k002244,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          shadowColor: AppColors.k000000,
          surfaceTintColor: AppColors.kFFFFFF,
          overlayColor: WidgetStateProperty.all(AppColors.kFFFFFF),
          animationDuration: const Duration(milliseconds: 600),
          onDestinationSelected: (int index) {
            controller.selectedTabIndex(index);
            controller.selectedTabIndex.refresh();
            controller.pageController?.jumpToPage(index);
          },
          destinations: <Widget>[
            NavigationDestination(
              selectedIcon: Icon(
                Icons.home,
                size: 22.h,
                color: AppColors.kFFFFFF,
              ),
              icon: Icon(
                Icons.home,
                size: 22.h,
                color: AppColors.k000000,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.receipt,
                size: 22.h,
                color: AppColors.kFFFFFF,
              ),
              icon: Icon(
                Icons.receipt,
                size: 22.h,
                color: AppColors.k000000,
              ),
              label: 'Reports',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.person,
                size: 22.h,
                color: AppColors.kFFFFFF,
              ),
              icon: Icon(
                Icons.person,
                size: 22.h,
                color: AppColors.k000000,
              ),
              label: 'Profile',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.settings,
                size: 22.h,
                color: AppColors.kFFFFFF,
              ),
              icon: Icon(
                Icons.settings,
                size: 22.h,
                color: AppColors.k000000,
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 1,
        shadowColor: AppColors.k000000,
        backgroundColor: AppColors.kFFFFFF,
        automaticallyImplyLeading: false,
        title: Image(
          height: 30.h,
          fit: BoxFit.cover,
          image: const AssetImage(AppImages.appLogo),
        ),
        actions:  <Widget>[
          const Icon(
            Icons.notifications,
            color: AppColors.k002244,
          ),
          SizedBox(
            width: 15.w,
          ),
        ],
        centerTitle: false,
      ),
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const <Widget>[
          DashboardView(),
          ReportsView(),
          ProfileView(),
          SettingsView()
          // const HelpView(),
        ],
      ),
    );
  }
}
