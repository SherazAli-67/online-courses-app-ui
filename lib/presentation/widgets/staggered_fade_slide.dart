import 'package:flutter/material.dart';
import 'package:online_course_app_ui/constants/number_constant.dart';

class StaggeredFadeSlide extends StatefulWidget {
  final Widget child;
  final int index;
  final Duration? duration;
  final Duration? staggerGap;
  final double slideOffset;
  final Curve curve;

  const StaggeredFadeSlide({
    super.key,
    required this.child,
    this.index = 0,
    this.duration,
    this.staggerGap,
    this.slideOffset = NumberConstant.animSlideOffset,
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<StaggeredFadeSlide> createState() => _StaggeredFadeSlideState();
}

class _StaggeredFadeSlideState extends State<StaggeredFadeSlide>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    final duration = widget.duration ??
        const Duration(milliseconds: NumberConstant.animNormalMs);
    final gap = widget.staggerGap ??
        const Duration(milliseconds: NumberConstant.animStaggerGapMs);

    _controller = AnimationController(vsync: this, duration: duration);
    _fade = CurvedAnimation(parent: _controller, curve: widget.curve);
    _slide = Tween<Offset>(
      begin: Offset(0, widget.slideOffset),
      end: Offset.zero,
    ).animate(_fade);

    Future<void>.delayed(gap * widget.index, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fade.value,
          child: Transform.translate(
            offset: _slide.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
