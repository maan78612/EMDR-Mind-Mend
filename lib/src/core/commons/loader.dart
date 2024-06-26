import 'package:emdr_mindmend/src/core/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class CustomLoader extends StatefulWidget {
  final bool isLoading;
  final Widget child;
  final Widget? loader;

  const CustomLoader(
      {super.key, required this.isLoading, required this.child, this.loader});

  @override
  State<StatefulWidget> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true); // Alternate direction
    _animation = Tween<double>(begin: 1.0, end: 0.6).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: widget.isLoading,
      opacity: 0.5,
      progressIndicator: ScaleTransition(
        scale: _animation,
        child: widget.loader ??
            Image.asset(
              AppImages.logo,
              width: 100.sp,
            ),
      ),
      child: widget.child,
    );
  }
}
