import 'package:get/get.dart';
import 'package:xixyyy_sign/services/api_service.dart';
import 'package:xixyyy_sign/stores/sign_store.dart';
import 'package:xixyyy_sign/stores/user_store.dart';

class RecordController extends GetxController {
  final signStore = Get.find<SignStore>();
  final userStore = Get.find<UserStore>();

  Future<void> fetchSignInfo() async {
    if (userStore.userInfo == null) return;

    signStore.setLoading(true);
    try {
      final info = await ApiService.getSignInInfo(
        account: userStore.userInfo!.userNumber,
        token: userStore.userInfo!.token,
        schoolId: userStore.userInfo!.schoolId,
      );
      signStore.setSignInfo(info);
    } catch (e) {
      Get.snackbar('错误', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      signStore.setLoading(false);
    }
  }
}
