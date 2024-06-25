import 'package:chat_app/helper/showsnackBar.dart';
import 'package:flutter/material.dart';

class CustomBuble extends StatelessWidget {
  const CustomBuble({
    Key? key,
    required this.message,
  }) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Kprimarycolor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class CustomBubleForFriend extends StatelessWidget {
  const CustomBubleForFriend({
    Key? key,
    required this.message,
  }) : super(key: key);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
            bottomLeft: Radius.circular(40),
          ),
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
