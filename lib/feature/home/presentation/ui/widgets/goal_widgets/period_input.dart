import 'package:flutter/material.dart';

class PeriodInput extends StatelessWidget {
  final Function(int?) onPeriodChanged;

  const PeriodInput({required this.onPeriodChanged, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Period (Days)",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        Container(
          width: 150,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter days',
              border: InputBorder.none,
            ),
            onChanged: (value) {
              final parsedValue = int.tryParse(value);
              onPeriodChanged(parsedValue);
            },
          ),
        ),
      ],
    );
  }
}
