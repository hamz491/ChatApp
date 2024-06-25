import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.title, this.onPressed});
  String title = 'UnKnown';
  VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      minWidth: double.infinity,
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
