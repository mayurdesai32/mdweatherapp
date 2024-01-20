import 'package:flutter/material.dart';

class AdditionInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const AdditionInfo({
    required this.icon,
    required this.label,
    required this.value,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Icon(
        icon,
        size: 46,
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        label,
        style: TextStyle(fontSize: 23),
      ),
      const SizedBox(
        height: 8,
      ),
      Text(
        value,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    ]);
  }
}
