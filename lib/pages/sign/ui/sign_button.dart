import 'dart:async';

import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class SignButton extends StatefulWidget {
  const SignButton({super.key});

  @override
  State<SignButton> createState() => _SignButtonState();
}

class _SignButtonState extends State<SignButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // 创建动画控制器（800ms 动画）
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    // 缩放动画：1.0 → 2.0
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 2.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // 透明度动画：0.4 → 0.0
    _opacityAnimation = Tween<double>(
      begin: 0.4,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // 启动定时器：每 3 秒触发一次
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!_controller.isAnimating) {
        _controller.forward(from: 0.0); // 从头开始播放
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildCheckInButton();
  }

  /// 构建签到按钮
  Widget _buildCheckInButton() {
    return <Widget>[
      // 波浪涟漪背景
      AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Styled.widget()
                .padding(all: 69)
                .decorated(
                  color: Colors.blue.withAlpha(0x50),
                  shape: BoxShape.circle,
                )
                .opacity(_opacityAnimation.value),
          );
        },
      ).positioned(top: 0, right: 0, left: 0, bottom: 0),
      AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Styled.widget()
                .padding(all: 69)
                .decorated(
                  color: Colors.blue.withAlpha(0x50),
                  shape: BoxShape.circle,
                )
                .opacity(_opacityAnimation.value),
          );
        },
      ).positioned(top: 0, right: 0, left: 0, bottom: 0),
      _buildCenterButton(),
    ].toStack();
  }

  // 中心蓝色按钮
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
    );
  }
}
