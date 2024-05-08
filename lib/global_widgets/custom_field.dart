import 'package:flutter/material.dart';

class CustomField extends StatefulWidget {
  final String title;
  final bool ? secured;
  const CustomField({Key? key, required this.title,this.secured}) : super(key: key);

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.secured ?? false,
      decoration: InputDecoration(
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
