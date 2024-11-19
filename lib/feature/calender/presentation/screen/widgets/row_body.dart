import 'package:flutter/material.dart';

class RowBody extends StatelessWidget {
  const RowBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem(Colors.blue, "Current Day"),
        const SizedBox(width: 10),
        _buildLegendItem(const Color.fromARGB(255, 147, 221, 149), "Completed"),
        const SizedBox(width: 10),
        _buildLegendItem(Colors.red, "Incomplete"),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
