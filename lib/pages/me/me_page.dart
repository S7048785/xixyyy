import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:xixyyy_sign/stores/user_store.dart';

class MePage extends StatelessWidget {
  const MePage({super.key});

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      _buildHeader(),
      _buildUserInfo(),
      _buildSettings(),
      _buildFooter(),
    ].toColumn().scrollable();
  }

  Widget _buildHeader() {
    return Text(
          "个人信息",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          textAlign: TextAlign.center,
        )
        .padding(vertical: 20)
        .constrained(width: double.infinity)
        .decorated(color: Colors.white)
        .border(bottom: 1, color: Colors.grey);
  }

  Widget _buildUserInfo() {
    final userStore = Get.find<UserStore>();
    return [
          Text(
            "ID: ${userStore.userInfo?.userNumber}",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("学校: ${userStore.userInfo?.schoolId}"),
          Text("姓名: ${userStore.userInfo?.userName}"),
        ]
        .toColumn(separator: const Gap(8))
        .width(double.infinity)
        .padding(vertical: 16)
        .backgroundColor(Colors.white);
  }

  Widget _buildSettings() {
    const primaryColor = Color(0xFF6366F1); // Primary color from HTML

    return [
      // General section
      Text(
        "General",
        style: TextStyle(
          color: Colors.grey[500],
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ).padding(horizontal: 24, vertical: 8),

      // Multi-account Management
      _buildSettingItem(
        icon: Icons.switch_account,
        iconColor: primaryColor,
        title: "账号管理",
        onTap: () {},
      ),

      // About App
      _buildSettingItem(
        icon: Icons.info,
        iconColor: primaryColor,
        title: "关于应用",
        onTap: () {},
      ),

      const Gap(16),

      // Account section
      Text(
        "Account",
        style: TextStyle(
          color: Colors.grey[500],
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ).padding(horizontal: 24, vertical: 8),

      // Logout
      _buildLogoutButton(),
    ].toColumn().padding(vertical: 16);
  }

  Widget _buildSettingItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return [
      Icon(icon, color: iconColor, size: 24)
          .constrained(width: 40, height: 40)
          .decorated(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      const Gap(16),
      Text(
        title,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ).expanded(),
      Icon(Icons.chevron_right, color: Colors.grey[400]),
    ].toRow().padding(horizontal: 24, vertical: 16).ripple().backgroundColor(Colors.white).gestures(onTap: onTap);
  }

  Widget _buildLogoutButton() {
    return [
          Icon(Icons.logout, color: Colors.red, size: 24)
              .constrained(width: 40, height: 40)
              .decorated(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
          const Gap(16),
          Text(
            "退出登录",
            style: TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ).expanded(),
        ]
        .toRow()
        .padding(horizontal: 24, vertical: 16)
        .ripple()
        .backgroundColor(Colors.white)
        .gestures(onTap: () {});
  }

  Widget _buildFooter() {
    return Text(
      "xixunyunsign_flutter v0.0.1",
      style: TextStyle(color: Colors.grey[500], fontSize: 12),
    ).center().padding(vertical: 32);
  }
}
