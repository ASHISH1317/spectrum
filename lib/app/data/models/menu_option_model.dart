import 'package:flutter/material.dart';

// ignore_for_file: public_member_api_docs
// Model class to hold menu option data (language and theme)
class MenuOptionsModel {
  MenuOptionsModel({required this.key, required this.value, this.icon});

  final ThemeMode key;
  final String value;
  final IconData? icon;
}
