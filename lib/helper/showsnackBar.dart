import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 600),
      backgroundColor: Colors.deepPurple,
      content: Text(title),
    ),
  );
}

Color Kprimarycolor = const Color(0xff284461);

const CollectionName = 'Messages';
