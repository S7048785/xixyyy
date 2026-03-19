import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:xixyyy_sign/stores/theme_store.dart';
import 'package:xixyyy_sign/stores/user_store.dart';

class MePage extends StatelessWidget {
  const MePage({super.key});

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      _buildHeader(context),
      _buildUserInfo(context),
      _buildSettings(context),
      _buildDisclaimer(context),
      _buildFooter(),
    ].toColumn().scrollable();
  }

  Widget _buildHeader(BuildContext context) {
    return Text(
          "个人信息",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          textAlign: TextAlign.center,
        )
        .padding(vertical: 20)
        .constrained(width: double.infinity)
        .decorated(color: ShadTheme.of(context).colorScheme.secondary)
        .border(bottom: 1, color: Colors.grey);
  }

  Widget _buildUserInfo(BuildContext context) {
    final userStore = Get.find<UserStore>();
    return [
          Text(
            "ID: ${userStore.userInfo?.userNumber}",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text("学校: ${userStore.userInfo?.schoolId}"),
          Text("姓名: ${userStore.userInfo?.userName}"),
        ]
        .toColumn(separator: const Gap(8))
        .width(double.infinity)
        .padding(vertical: 16)
        .backgroundColor(ShadTheme.of(context).colorScheme.card);
  }

  Widget _buildSettings(BuildContext context) {
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
        context,
        icon: Icons.switch_account,
        iconColor: primaryColor,
        title: "账号管理",
        onTap: () {},
      ),
      _buildThemeSwitch(
        context,
        icon: Icons.brightness_6,
        iconColor: primaryColor,
        title: "切换主题",
      ),

      // About App
      _buildSettingItem(
        context,
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
      _buildLogoutButton(context),
    ].toColumn().padding(vertical: 16);
  }

  Widget _buildSettingItem(
    BuildContext context, {
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ).expanded(),
          Icon(Icons.chevron_right, color: Colors.grey[400]),
        ]
        .toRow()
        .padding(horizontal: 24, vertical: 16)
        .ripple()
        .backgroundColor(ShadTheme.of(context).colorScheme.card)
        .gestures(onTap: onTap);
  }

  Widget _buildLogoutButton(BuildContext context) {
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
        .backgroundColor(ShadTheme.of(context).colorScheme.card)
        .gestures(onTap: () {});
  }

  Widget _buildThemeSwitch(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Switch(
            value: Get.find<ThemeStore>().isDarkMode,
            onChanged: (value) {
              Get.find<ThemeStore>().toggleTheme();
            },
          ),
        ]
        .toRow()
        .backgroundColor(ShadTheme.of(context).colorScheme.card)
        .padding(horizontal: 24, vertical: 16)
        .backgroundColor(ShadTheme.of(context).colorScheme.card);
  }

  Widget _buildDisclaimer(BuildContext context) {
    return Obx(() {
      final themeStore = Get.find<ThemeStore>();
      final isDarkMode = themeStore.isDarkMode;
      return [
            Icon(
              Icons.warning_amber_rounded,
              color: Colors.yellow.shade700,
              size: 24,
            ).constrained(width: 40, height: 40),
            const Gap(8),
            [
              Text(
                "免责声明",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: ShadTheme.of(context).colorScheme.primary,
                ),
              ),
              const Gap(8),
              Text(
                "1. 本项目仅供学习和研究技术交流使用。\n"
                "2. 请勿将本项目用于任何商业用途或违反规章制度的代签、作弊等行为。\n"
                "3. 因使用本软件产生的任何意外后果，由使用者自行承担。",
                style: TextStyle(
                  fontSize: 12,
                  height: 1.5,
                  color: ShadTheme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.8),
                ),
              ),
            ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).expanded(),
          ]
          .toRow(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          )
          .padding(horizontal: 8, vertical: 12)
          .decorated(
            color: !isDarkMode
                ? const Color(0xfffffbe6)
                : const Color(0xff2b2111),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.yellow.shade700.withValues(alpha: 0.5),
            ),
          )
          .constrained(width: MediaQuery.of(context).size.width * 0.8)
          .center();
    });
  }

  Widget _buildFooter() {
    return Text(
      "xixyyysign_flutter v0.2",
      style: TextStyle(color: Colors.grey[500], fontSize: 12),
    ).center().padding(bottom: 32, top: 16);
  }
}
