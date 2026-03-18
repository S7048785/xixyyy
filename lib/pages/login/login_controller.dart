import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xixyyy_sign/pages/frame/frame_page.dart';
import 'package:xixyyy_sign/services/api_service.dart';
import 'package:xixyyy_sign/stores/sign_store.dart';
import 'package:xixyyy_sign/stores/user_store.dart';

class LoginController extends GetxController {
  final accountController = TextEditingController();
  final passwordController = TextEditingController();
  final schoolIdController = TextEditingController();

  final isLoading = false.obs;

  String get account => accountController.text.trim();

  String get password => passwordController.text.trim();

  String get schoolId => schoolIdController.text.trim();

  bool get isFormValid =>
      account.isNotEmpty && password.isNotEmpty && schoolId.isNotEmpty;


  Future<void> login() async {
    if (!isFormValid) {
      Get.snackbar(
          '提示', '请填写完整信息', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;

    try {
      final response = await ApiService.login(account, password, schoolId);
      // 保存用户信息到本地
      final userStore = Get.find<UserStore>();
      await userStore.saveUser(response, account, password, schoolId);

      Get.snackbar(
        '成功',
        '登录成功: ${""}',
        snackPosition: SnackPosition.TOP,
      );

      // 登录成功后获取签到信息
      final signStore = Get.find<SignStore>();
      final signInfo = await ApiService.getSignInInfo(
        account: userStore.userInfo!.userNumber,
        token: userStore.userInfo!.token,
        schoolId: userStore.userInfo!.schoolId,
      );
      signStore.setSignInfo(signInfo);

      Get.offAll(() => FramePage());
    } catch (e) {
      Get.snackbar('错误', e.toString(), snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    accountController.dispose();
    passwordController.dispose();
    schoolIdController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    final userStore = Get.find<UserStore>();
    accountController.text = userStore.username;
    passwordController.text = userStore.password;
    schoolIdController.text = userStore.schoolId;
    super.onInit();
  }
}
