import 'package:flutter/material.dart';

class CustomField extends StatefulWidget {
  final String title;
  final bool? secured;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;

  const CustomField({
    super.key,
    required this.title,
    this.secured,
    this.prefixIcon,
    this.keyboardType,
  });

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType:
          widget.keyboardType, // Correctly reference widget.keyboardType
      obscureText: widget.secured ?? false,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color: Colors.black.withOpacity(.5),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: const BorderSide(
            color: Colors.blueAccent,
          ),
        ),
        hintText: widget.title,
      ),
    );
  }
}
