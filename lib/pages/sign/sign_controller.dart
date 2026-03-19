import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xixyyy_sign/stores/sign_store.dart';
import 'package:xixyyy_sign/stores/user_store.dart';
import 'package:xixyyy_sign/utils/crypto_util.dart';

import '../../services/api_service.dart';
import '../record/record_controller.dart';

class SignController extends GetxController {
  final signStore = Get.find<SignStore>();
  final userStore = Get.find<UserStore>();

  final TextEditingController addressController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  @override
  void onInit() {
    addressController.text = userStore.address;
    latitudeController.text = userStore.latitude;
    longitudeController.text = userStore.longitude;
    super.onInit();
  }

  void sign() async {
    final recordController = Get.find<RecordController>();

    if (latitudeController.text.isEmpty || longitudeController.text.isEmpty) {
      Get.snackbar('错误', '请填写经纬度');
      return;
    }
    if (addressController.text.isEmpty) {
      Get.snackbar('错误', '请填写地址');
      return;
    }
    if (signStore.isSigned.value) {
      Get.snackbar('错误', '今天已签到');
      return;
    }
    var latitude = latitudeController.text;
    var longitude = longitudeController.text;

    latitude = CryptoUtils.rsaEncrypt(latitude);
    longitude = CryptoUtils.rsaEncrypt(longitude);
    try {
      await ApiService.sign(
        userStore.userInfo!.userNumber,
        userStore.userInfo!.token,
        addressController.text,
        latitude,
        longitude,
      );
      Get.snackbar('签到成功', '签到成功');

      signStore.isSigned.value = true;
    } catch (e) {
      Get.snackbar('签到失败', e.toString());
    }
    recordController.fetchSignInfo();

    update();
  }

  Future<void> updateAddress() async {
    if (latitudeController.text.isEmpty || longitudeController.text.isEmpty) {
      Get.snackbar('错误', '请填写经纬度');
      return;
    }
    if (addressController.text.isEmpty) {
      Get.snackbar('错误', '请填写地址');
      return;
    }
    await userStore.saveAddress(
      addressController.text,
      latitudeController.text,
      longitudeController.text,
    );
    Get.snackbar('更新成功', '位置已更新');
  }
}
