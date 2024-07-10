import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final double borderRadius;
  final double height;
  final double width;
  final Color backgroundColor;
  final void Function() onPressed;
  final Widget widget;
  const CustomButton({
    super.key,
    required this.widget,
    required this.onPressed,
    required this.height,
    required this.width,
    required this.backgroundColor,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
      height: height.h,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: WidgetStateProperty.all(
            5,
          ), // Add elevation to see the shadow
          shadowColor: WidgetStateProperty.all(Colors.black),
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          side: WidgetStateBorderSide.resolveWith(
            (states) {
              if (states.contains(WidgetState.pressed)) {
                return const BorderSide(color: Color(0xFFEB650D));
              }
              return BorderSide(color: backgroundColor);
            },
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius)),
          ),
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.pressed)) {
                return const Color(0xFFEB650D);
              }
              return backgroundColor;
            },
          ),
        ),
        onPressed: onPressed,
        child: widget,
      ),
    );
  }
}
