import 'package:flutter/material.dart';

final textFieldDecoration = InputDecoration(
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Colors.grey,
      width: 0.7,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Colors.grey,
      width: 0.7,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(
      color: Colors.red,
      width: 0.7,
    ),
  ),
);

RegExp emailRegex = RegExp(r'(^[a-zA-Z\d+_.-]+@[a-zA-Z\d.-]+.[a-z]$)');
