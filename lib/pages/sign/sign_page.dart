import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:xixyyy_sign/pages/sign/sign_controller.dart';
import 'package:gap/gap.dart';
import 'package:xixyyy_sign/pages/sign/ui/RippleAnimation.dart';
import 'package:xixyyy_sign/stores/sign_store.dart';

class SignPage extends GetView<SignController> {
  const SignPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignController());
    final signStore = Get.find<SignStore>();
    return SingleChildScrollView(
      child: [
        _buildHeader(context),
        const Gap(10),
        [
          _buildDateInfo(context),
          const Gap(20),
          Obx(() {
            final isSigned = signStore.isSigned.value;
            if (isSigned) {
              return _buildSignedIn();
            }
            return RippleAnimationButton();
          }),
          const Gap(20),
          // _buildSimulation(),
          _buildSimulation2(context),
        ].toColumn().paddingSymmetric(horizontal: 16),
      ].toColumn(),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Text(
          "XixyyySign",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          textAlign: TextAlign.center,
        )
        .padding(vertical: 20)
        .constrained(width: double.infinity)
        .decorated(color: Theme.of(context).colorScheme.secondary);
  }

  Widget _buildDateInfo(BuildContext context) {
    final signStore = Get.find<SignStore>();
    return [
          // 日期与签到信息
          [
                [
                  Icon(Icons.calendar_today, size: 14, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    "今日签到信息",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ].toRow(),
                const Gap(8),
                Obx(() {
                  final isSigned = signStore.isSigned.value;
                  return [
                        Icon(
                          isSigned ? Icons.check_circle : Icons.info_outline,
                          size: 12,
                          color: isSigned
                              ? const Color(0xFF4CAF50)
                              : Colors.amber[700],
                        ),
                        const Gap(8),
                        Text(
                          isSigned ? "当前状态: 已签到" : "当前状态: 未签到",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isSigned
                                ? const Color(0xFF4CAF50)
                                : Colors.amber[700],
                          ),
                        ),
                      ]
                      .toRow(mainAxisSize: MainAxisSize.min)
                      .padding(horizontal: 8, vertical: 4)
                      .decorated(borderRadius: BorderRadius.circular(8));
                }),
              ]
              .toColumn(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
              )
              .padding(all: 20)
              .flexible(flex: 0),
        ]
        .toColumn(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
        )
        .decorated(
          color: ShadTheme.of(context).colorScheme.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ShadTheme.of(context).colorScheme.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        )
        .clipRRect(clipBehavior: Clip.antiAlias)
        .parent(
          ({required child}) => LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) =>
                child,
          ),
        );
  }

  Widget _buildSimulation2(BuildContext context) {
    return ExpansionTile(
          title: [
            Icon(Icons.location_on, size: 24, color: Colors.blue.shade600),
            const Gap(8),
            const Text("位置模拟", style: TextStyle(fontSize: 16)),
          ].toRow(),
          shape: const Border(), // 去掉展开时的边框
          collapsedShape: const Border(), // 去掉折叠时的边框
          // collapsedBackgroundColor: ShadTheme.of(context).colorScheme.secondary,
          childrenPadding: EdgeInsets.all(12),
          children: [
            [
              [
                    const Text('经度'),
                    const Gap(5),
                    ShadInput(
                      controller: controller.latitudeController,
                      placeholder: const Text('输入经度'), // 建议改为 longitude
                      keyboardType: TextInputType.number,
                    ),
                  ]
                  .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
                  .expanded(),

              // 关键：替换 .constrained(width: 100)
              const Gap(12),
              // 使用 Expanded 包裹第二个输入框组合
              [
                    const Text('纬度'),
                    const Gap(5),
                    ShadInput(
                      controller: controller.longitudeController,
                      placeholder: const Text('输入纬度'),
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 16),
                    ),
                  ]
                  .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
                  .expanded(),
              // 关键：替换 .constrained(width: 100)
            ].toRow(),
            const Gap(8),
            // 使用 Expanded 包裹第一个输入框组合
            [
              const Text('签到地址'),
              const Gap(5),
              ShadInput(
                controller: controller.addressController,
                placeholder: const Text('输入签到地址'),
                keyboardType: TextInputType.number,
              ),
            ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
            const Gap(16),
            ShadButton(
              hoverBackgroundColor: Color(0xffe7f0fd),
              width: double.infinity,
              onPressed: controller.updateAddress,
              leading: Icon(
                Icons.refresh_outlined,
                color: Colors.blue.shade600,
                size: 18,
              ),
              decoration: ShadDecoration(
                border: ShadBorder.all(radius: BorderRadius.circular(8)),
              ),
              backgroundColor: Color(0xffe7f0fd),
              child: const Text(
                '更新模拟位置',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        )
        .clipRRect(clipBehavior: Clip.antiAlias)
        .padding(all: 12)
        .decorated(
          color: ShadTheme.of(context).colorScheme.card,
          borderRadius: BorderRadius.circular(12),
        );
  }

  Widget _buildSignedIn() {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.grey,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.fingerprint, color: Colors.white, size: 50),
          SizedBox(height: 8),
          Text(
            "SIGNED IN",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
