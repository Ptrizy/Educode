import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quiz/common/theme/app_font_style.dart';

class PasswordPrefixTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool obscureText;
  final bool numberOnly;
  final bool alphabetOnly;
  final bool isEnabled;

  const PasswordPrefixTextField({
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
  State<PasswordPrefixTextField> createState() =>
      _PasswordPrefixTextFieldState();
}

class _PasswordPrefixTextFieldState extends State<PasswordPrefixTextField> {
  bool _isObscured = true;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.h),
        TextField(
          obscureText: _isObscured,
          enabled: widget.isEnabled,
          focusNode: _focusNode,
          maxLines: widget.maxLines,
          showCursor: true, // Changed from false to true
          controller: widget.controller,
          keyboardType:
              widget.numberOnly ? TextInputType.phone : TextInputType.text,
          style: AppFontStyle.mediumLargeText,
          inputFormatters: [
            if (widget.alphabetOnly)
              FilteringTextInputFormatter.allow(RegExp('^[A-Za-z]+[A-Za-z ]*')),
            if (widget.numberOnly)
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.-]')),
          ],
          decoration: InputDecoration(
            fillColor: widget.isEnabled
                ? Colors.white
                : const Color(0xFFCCCCCC).withOpacity(0.2),
            filled: widget.isEnabled,
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            hintText: widget.hintText,
            hintStyle: widget.isEnabled
                ? AppFontStyle.regularLargeText
                    .copyWith(color: const Color(0xFFB9B9B9))
                : AppFontStyle.mediumLargeText,
            suffixIcon: GestureDetector(
              onTap: _togglePasswordVisibility,
              child: Icon(
                _isObscured ? Icons.visibility : Icons.visibility_off,
                color: _isFocused
                    ? const Color(0xFFD9872A)
                    : const Color(0xFFD9D9D9),
              ),
            ),
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
