import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
  const Constants({this.text, this.icon});

  final String text;
  final IconData icon;
}

const List<Constants> constants = const <Constants>[
  const Constants(text: 'แก้ไข', icon: Icons.mode_edit),
  const Constants(text: 'ลบ', icon: Icons.delete_outline),
];