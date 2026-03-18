import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import '../sign_controller.dart';

class RippleAnimationButton extends StatefulWidget {
  const RippleAnimationButton({super.key});

  @override
  State<RippleAnimationButton> createState() => _RippleAnimationButtonState();
}

class _RippleAnimationButtonState extends State<RippleAnimationButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // 1. 将时间拉长，让波纹有足够的时间扩散
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(); // 2. 直接使用 repeat，不再需要 Timer
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void handleSign() {
    Get.find<SignController>().sign();
  }
  // 核心方法：构建带偏移量的波纹
  Widget _buildRipple(double offset) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // 使用 (当前值 + 偏移量) % 1.0 得到一个新的 0.0 ~ 1.0 的进度
        // 这样多个波纹就会在时间上“错开”
        double progress = (_controller.value + offset) % 1.0;

        // 自定义曲线效果 (模拟 easeOut)
        double curveProgress = Curves.easeOut.transform(progress);

        return Transform.scale(
          scale: 1.0 + (0.8 * curveProgress), // 从 1.0 放大到 2.2
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.withOpacity(0.4 * (1.0 - curveProgress)), // 逐渐透明
            ),
          ),
        );
      },
    ).positioned(top: 0, right: 0, left: 0, bottom: 0);
  }

  @override
  Widget build(BuildContext context) {
    return [
      <Widget>[
        // 这里的 0.0, 0.3, 0.6 代表三个波纹出现的间距
        _buildRipple(0.0),
        _buildRipple(0.6),
        _buildCenterButton(),
      ].toStack(alignment: Alignment.center),
      const Gap(40),
      Text("点击以记录您的签到情况")
    ].toColumn().padding(all: 20);
  }

  Widget _buildCenterButton() {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: const Color(0xFF0066FF),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 5,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.fingerprint, color: Colors.white, size: 50),
          SizedBox(height: 8),
          Text(
            "SIGN IN",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    ).gestures(
      onTap: handleSign,
    );
  }
}