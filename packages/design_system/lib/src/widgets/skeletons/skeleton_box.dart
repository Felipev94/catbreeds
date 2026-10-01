import 'package:flutter/material.dart';

import '../../extensions/context_extensions.dart';
import '../../tokens/durations.dart';
import '../../tokens/radius.dart';

class SkeletonBox extends StatefulWidget {
  static const Color _BASE_LIGHT = Color(0xFFE0E0E0);
  static const Color _HIGHLIGHT_LIGHT = Color(0xFFF5F5F5);
  static const Color _BASE_DARK = Color(0xFF2E2E2E);
  static const Color _HIGHLIGHT_DARK = Color(0xFF3D3D3D);

  final double? width;
  final double? height;
  final BorderRadius borderRadius;

  const SkeletonBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius = AppRadius.RADIUS_SM,
  });

  @override
  State<SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<SkeletonBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppDurations.VERY_SLOW,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: AppCurves.STANDARD,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    final Color base = isDark ? SkeletonBox._BASE_DARK : SkeletonBox._BASE_LIGHT;
    final Color highlight =
        isDark ? SkeletonBox._HIGHLIGHT_DARK : SkeletonBox._HIGHLIGHT_LIGHT;

    return AnimatedBuilder(
      animation: _animation,
      builder: (_, _) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Color.lerp(base, highlight, _animation.value),
          borderRadius: widget.borderRadius,
        ),
      ),
    );
  }
}
