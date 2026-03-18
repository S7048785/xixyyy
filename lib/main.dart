import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:xixyyy_sign/pages/frame/frame_page.dart';
import 'package:xixyyy_sign/pages/login/login_page.dart';
import 'package:xixyyy_sign/services/api_service.dart';
import 'package:xixyyy_sign/stores/sign_store.dart';
import 'package:xixyyy_sign/stores/user_store.dart';

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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final signStore = Get.find<SignStore>();

    return ShadApp.custom(
      themeMode: ThemeMode.light,
      darkTheme: ShadThemeData(
        brightness: Brightness.dark,
        colorScheme: const ShadSlateColorScheme.dark(),
      ),
      appBuilder: (context) {
        return GetMaterialApp(
          title: 'XixyyySign',
          theme: Theme.of(context),
          builder: (context, child) {
            BotToastInit();
            return ShadAppBuilder(child: child!);
          },
          home: Obx(() {
            // 根据签到信息是否存在决定显示哪个页面
            if (signStore.signInfo.value != null) {
              return const FramePage();
            }
            return const LoginPage();
          }),
          navigatorObservers: [BotToastNavigatorObserver()],
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
