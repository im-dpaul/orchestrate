import 'package:flutter/material.dart';
import 'package:orchestrate/core/responsive/size_extension.dart';
import 'package:orchestrate/core/themes/app_colors.dart';

class HDivider extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;

  const HDivider({
    super.key,
    this.width,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 1.h,
      width: width ?? double.maxFinite,
      color: color ?? AppColors.softGray,
    );
  }
}
