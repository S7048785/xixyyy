import 'package:get/get.dart';
import 'package:xixyyy_sign/models/sign_in.dart';

class SignStore extends GetxController {
  final signInfo = Rxn<SignInResponse>();
  final isLoading = false.obs;
  final isSigned = false.obs;

  /// 获取本月签到次数
  int get monthSignCount => signInfo.value?.signInMonth.length ?? 0;

  /// 获取连续签到天数
  int get continuousSignIn {
    final count = int.tryParse(signInfo.value?.continuousSignIn ?? '0') ?? 0;
    return count;
  }

  void setSignInfo(SignInResponse info) {
    final today = DateTime.now();
    final todayStr = '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}';

    isSigned.value = info.signInMonth.any((e) => e.signTimeText == todayStr);
    signInfo.value = info;
  }

  void setLoading(bool loading) {
    isLoading.value = loading;
  }

  void clear() {
    signInfo.value = null;
  }
}
