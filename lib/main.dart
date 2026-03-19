import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:xixyyy_sign/pages/frame/frame_page.dart';
import 'package:xixyyy_sign/pages/login/login_page.dart';
import 'package:xixyyy_sign/services/api_service.dart';
import 'package:xixyyy_sign/stores/sign_store.dart';
import 'package:xixyyy_sign/stores/user_store.dart';

import 'stores/theme_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化 UserStore
  final userStore = Get.put(UserStore());
  await userStore.init();

  // 初始化 SignStore
  final signStore = Get.put(SignStore());

  // 如果有用户信息，尝试获取签到信息
  if (userStore.userInfo != null) {
    try {
      final signInfo = await ApiService.getSignInInfo(
        account: userStore.userInfo!.userNumber,
        token: userStore.userInfo!.token,
        schoolId: userStore.userInfo!.schoolId,
      );
      signStore.setSignInfo(signInfo);
    } catch (e) {
      // 获取签到信息失败，清除用户信息
      // await userStore.clearUser();
    }
  }

  // 初始化 ThemeStore
  final themeStore = Get.put(ThemeStore());
  await themeStore.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final signStore = Get.find<SignStore>();

    return Obx(() {
      final themeStore = Get.find<ThemeStore>();
      return ShadApp.custom(
        themeMode: themeStore.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        theme: ShadThemeData(
          brightness: Brightness.light,
          colorScheme: const ShadSlateColorScheme.light(
            background: Color(0xfff6f7f8),
            secondary: Colors.white,
            border: Color(0xffe2e8f0),
            custom: {'navigationBottom': Colors.white},
          ),
        ),
        darkTheme: ShadThemeData(
          brightness: Brightness.dark,
          colorScheme: const ShadSlateColorScheme.dark(
            background: Color(0xff23262f),
            secondary: Color(0xff202020),
            card: Color(0xff2a3441),
            border: Color(0xff4a5568),
          ),
        ),
        appBuilder: (context) {
          return GetMaterialApp(
            title: 'XixyyySign',
            theme: Theme.of(context),
            builder: (context, child) {
              return ShadAppBuilder(child: child!);
            },
            home: Obx(() {
              // 根据签到信息是否存在决定显示哪个页面
              if (signStore.signInfo.value != null) {
                return const FramePage();
              }
              return const LoginPage();
            }),
            debugShowCheckedModeBanner: false,
          );
        },
      );
    });
  }
}

extension CustomColorExtension on ShadColorScheme {
  Color get navigationBottom => custom['navigationBottom']!;
}
