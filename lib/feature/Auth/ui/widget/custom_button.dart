import 'package:flutter/material.dart';
import 'package:habit_track/core/theme/style.dart';

class CustomButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        gradient: const LinearGradient(
          begin: Alignment(-0.75, -1.0),
          end: Alignment(1.0, 1.0),
          colors: [
            Color(0xFF0083B0),
            Color(0xFF00B4DB),
          ],
        ),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            buttonName,
            style: TextAppStyle.subTittel.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}