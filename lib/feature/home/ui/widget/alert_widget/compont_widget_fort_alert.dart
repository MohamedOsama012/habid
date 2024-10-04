import 'package:flutter/material.dart';
import 'package:habit_track/feature/Auth/ui/widget/custom_text.dart';

class TopPartInAlert extends StatelessWidget {
  const TopPartInAlert({super.key, required this.nameOfAlert});
  final String nameOfAlert;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          nameOfAlert,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          child: const Icon(Icons.close),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class TextPartInAlert extends StatelessWidget {
  const TextPartInAlert(
      {super.key, required this.habitNameController, required this.hintText});
  final TextEditingController habitNameController;
  final String hintText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${hintText} :",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        const SizedBox(height: 4),
        TextFormField(
            controller: habitNameController, decoration: decorationField()),
      ],
    );
  }
}
