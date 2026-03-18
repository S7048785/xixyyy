import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:xixyyy_sign/pages/record/record_controller.dart';

class RecordPage extends GetView<RecordController> {
  const RecordPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RecordController());

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F8),
      appBar: AppBar(
        title: const Text('签到记录'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.signStore.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final signInfo = controller.signStore.signInfo;

        return RefreshIndicator(
          onRefresh: controller.fetchSignInfo,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // 统计卡片
              Row(
                children: [
                  _buildStatCard(
                    '本月签到',
                    '${controller.signStore.monthSignCount}',
                    '次',
                    Icons.calendar_month,
                    const Color(0xFF4A90E2),
                  ),
                  const Gap(12),
                  _buildStatCard(
                    '连续签到',
                    '${controller.signStore.continuousSignIn}',
                    '天',
                    Icons.local_fire_department,
                    const Color(0xFFFF9800),
                  ),
                ],
              ),
              const Gap(20),
              // 签到记录列表
              const Text(
                '签到记录',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF333333),
                ),
              ),
              const Gap(12),
              if (signInfo.value!.signInMonth.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      '本月暂无签到记录',
                      style: TextStyle(color: Color(0xFF999999)),
                    ),
                  ),
                )
              else
                ...?signInfo.value?.signInMonth.map((item) => _buildSignItem(item)),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStatCard(String title, String value, String unit, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const Gap(8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF999999),
                  ),
                ),
              ],
            ),
            const Gap(8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const Gap(4),
                Text(
                  unit,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF999999),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignItem(dynamic item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFEEF5FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.check_circle,
              color: Color(0xFF4A90E2),
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.signTimeText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF333333),
                  ),
                ),
                const Gap(4),
                Text(
                  _formatSignTime(item.signTime),
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF999999),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF4A90E2).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              '已签到',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF4A90E2),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatSignTime(String timestamp) {
    try {
      final time = int.tryParse(timestamp) ?? 0;
      final dateTime = DateTime.fromMillisecondsSinceEpoch(time * 1000);
      final hour = dateTime.hour.toString().padLeft(2, '0');
      final minute = dateTime.minute.toString().padLeft(2, '0');
      return '$hour:$minute';
    } catch (e) {
      return '';
    }
  }
}
