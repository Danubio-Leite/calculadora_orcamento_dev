import 'package:flutter/material.dart';
import '../app_colors.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double borderRadius;
  final double borderWidth;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.borderRadius = 8.0,
    this.borderWidth = 1.0,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = TextStyle(color: AppColors.white);
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppColors.primaryBlue,
              AppColors.secondaryBlue,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: AppColors.white,
            width: borderWidth,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onPressed,
          child: Container(
            padding: padding,
            alignment: Alignment.center,
            child: Text(
              text,
              style: textStyle ?? defaultTextStyle,
            ),
          ),
        ),
      ),
    );
  }
}
