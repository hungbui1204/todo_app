import 'package:flutter/material.dart';

AppBar taskAppBar(String title) {
  return AppBar(
    title: Text(
      title,
      style: const TextStyle(color: Colors.white),
    ),
  );
}
