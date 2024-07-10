import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/common/theme/app_font_style.dart';

class CustomFieldForm extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  final int maxLines;
  final bool obscureText;
  final bool numberOnly;
  final bool alphabetOnly;
  final bool isEnabled;

  const CustomFieldForm({
    super.key,
    required this.controller,
    required this.hintText,
    required this.maxLines,
    required this.obscureText,
    required this.isEnabled,
    required this.alphabetOnly,
    required this.numberOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.h),
        TextField(
          obscureText: obscureText,
          enabled: isEnabled,
          maxLines: maxLines,
          showCursor: true, // Changed from false to true
          controller: controller,
          keyboardType: numberOnly ? TextInputType.phone : TextInputType.text,
          style: AppFontStyle.mediumLargeText,
          inputFormatters: [
            if (alphabetOnly)
              FilteringTextInputFormatter.allow(RegExp('^[A-Za-z]+[A-Za-z ]*')),
            if (numberOnly)
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.-]')),
          ],
          decoration: InputDecoration(
            fillColor: isEnabled
                ? Colors.white
                : const Color(0xFFCCCCCC).withOpacity(0.2),
            filled: isEnabled,
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            hintText: hintText,
            hintStyle: isEnabled
                ? AppFontStyle.regularLargeText
                    .copyWith(color: const Color(0xFFB9B9B9))
                : AppFontStyle.mediumLargeText,
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
              borderRadius: BorderRadius.circular(8),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFCCCCCC)),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFD9872A)),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
