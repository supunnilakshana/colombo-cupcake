import 'package:cackeapp/ui/styles/app_styles.dart';
import 'package:flutter/material.dart';

Widget buildChip(String label) {
  return Chip(
    labelPadding: const EdgeInsets.all(2.0),
    avatar: CircleAvatar(
      backgroundColor: kPrimaryColorlight,
      child: Text(label[0].toUpperCase(),
          style: const TextStyle(color: kPrimaryColordark)),
    ),
    label: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: kPrimaryColordark,
    elevation: 6.0,
    shadowColor: Colors.orange.shade100,
    padding: const EdgeInsets.all(8.0),
  );
}
