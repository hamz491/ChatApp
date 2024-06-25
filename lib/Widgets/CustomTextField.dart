import 'package:flutter/material.dart';

class Custom_TextField extends StatelessWidget {
  Custom_TextField(
      {super.key,
      required this.hint,
      this.onChanged,
      this.obscuretext = false});
  bool? obscuretext;
  String hint = 'Unknown';
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscuretext!,
      validator: (value) {
        if (value!.isEmpty) {
          return 'The value is required';
        }
        return null;
      },
      style: const TextStyle(color: Colors.white),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xffC7EDE6),
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
