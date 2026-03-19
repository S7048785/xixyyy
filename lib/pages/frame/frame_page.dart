import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:xixyyy_sign/pages/me/me_page.dart';
import 'package:xixyyy_sign/pages/record/record_page.dart';
import 'package:xixyyy_sign/pages/sign/sign_page.dart';

import 'frame_controller.dart';

class FramePage extends GetView<FrameController> {
  const FramePage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FrameController());
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => IndexedStack(
            index: controller.selectedIndex.value,
            children: [const SignPage(), const RecordPage(), const MePage()],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.selectedIndex.value,
          backgroundColor: ShadTheme.of(context).colorScheme.secondary,
          onDestinationSelected: (index) => controller.changeIndex(index),
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.event_available_outlined),
              label: '签到',
              selectedIcon: Icon(Icons.event_available),
            ),
            NavigationDestination(
              icon: Icon(Icons.history_outlined),
              label: '记录',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outlined),
              label: '我的',
              selectedIcon: Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }
}
