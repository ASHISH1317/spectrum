import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_starter_kit_2024/app/data/config/encryption.dart';
import 'package:get_starter_kit_2024/app/data/config/logger.dart';
import 'package:get_starter_kit_2024/app/data/local/locale_provider.dart';
import 'package:get_starter_kit_2024/app/data/local/theme_provider.dart';
import 'package:get_starter_kit_2024/app/data/models/menu_option_model.dart';
import 'package:get_starter_kit_2024/app/ui/components/app_snackbar.dart';
import 'package:get_starter_kit_2024/app/ui/components/segmented_controls.dart';
import 'package:get_starter_kit_2024/generated/locales.g.dart';
import '../controllers/home_controller.dart';

/// Home view class
class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('HomeView'),
          centerTitle: true,
        ),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Text(
              LocaleKeys.home_view.tr,
              style: const TextStyle(fontSize: 20),
            ),
            const Divider(),
            const Text(
              'Test API',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                //Todo(ASHISH): Test API
                appSnackbar(
                  message: "hiii",
                );
              },
              child: const Text('Create Fake Task'),
            ),
            const Divider(),
            const Text(
              'Test Error',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                // Catcher2.sendTestException();
              },
              child: const Text('Throw error'),
            ),
            const Divider(),
            const Text(
              'Test Encryption',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                logI(AppEncryption.encrypt(
                  plainText: jsonEncode({
                    'name': '',
                    'username': 'test',
                    'email': '',
                    'phone': '',
                    'country': '',
                    'city': '',
                    'bio': '',
                    'current_location': '',
                    'first_name': '',
                    'last_name': '',
                    'address_line1': '',
                    'address_line2': '',
                    'is_verified': false,
                    'job_post': '',
                    'password':
                        'passwordpasswordpasswordpasswordpasswordpassword',
                  }),
                ));
                AppEncryption.testEncryption();
              },
              child: const Text('Encrypt Data'),
            ),
            const Divider(),
            const Text(
              'Test Instagram API',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () {
                controller.getProfileData(
                  'ASHISH',
                  '263435611%3AgvrbiX3qblOjhY%3A22',
                );
              },
              child: const Text('Get Profile Data'),
            ),
            const Divider(),
            const Text(
              'Test Theme Modes',
              style: TextStyle(fontSize: 20),
            ),
            Container(
              width: Get.width,
              height: 100,
              alignment: Alignment.center,
              child: _themeListTile(),
            ),
            const Divider(),
            const Text(
              'Test Change Language',
              style: TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    LocaleProvider.changeLocale(const Locale('en_US'));
                  },
                  child: const Text('Change to en_US'),
                ),
                ElevatedButton(
                  onPressed: () {
                    LocaleProvider.changeLocale(const Locale('hi_IN'));
                  },
                  child: const Text('Change to hi_IN'),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _themeListTile() {
    final List<MenuOptionsModel> themeOptions = <MenuOptionsModel>[
      MenuOptionsModel(
        key: ThemeMode.system,
        value: 'settings_system'.tr,
        icon: Icons.brightness_4,
      ),
      MenuOptionsModel(
        key: ThemeMode.light,
        value: 'settings_light'.tr,
        icon: Icons.brightness_low,
      ),
      MenuOptionsModel(
        key: ThemeMode.dark,
        value: 'settings_dark'.tr,
        icon: Icons.brightness_3,
      ),
    ];
    return GetBuilder<HomeController>(
      builder: (HomeController controller) => SegmentedSelector(
        selectedOption: ThemeProvider.currentTheme,
        menuOptions: themeOptions,
        onValueChanged: (ThemeMode? value) {
          ThemeProvider.setThemeMode(value!);
        },
      ),
    );
  }
}
