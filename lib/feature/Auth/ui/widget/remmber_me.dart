import 'package:flutter/material.dart';
import 'package:habit_track/core/theme/style.dart';
import 'package:habit_track/feature/Auth/ui/screen/forget_password.dart';

class RememberMeForgotPasswordRow extends StatefulWidget {
  @override
  _RememberMeForgotPasswordRowState createState() =>
      _RememberMeForgotPasswordRowState();
}

class _RememberMeForgotPasswordRowState
    extends State<RememberMeForgotPasswordRow> {
  bool _isRememberMeChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceBetween, // Spaces out the widgets
      children: [
        Row(
          children: [
            Checkbox(
                value: _isRememberMeChecked,
                onChanged: (value) {
                  setState(() {
                    _isRememberMeChecked = value!;
                  });
                },
                activeColor: Colors.lightBlue),
            Text(
              "Remember Me",
              style: TextAppStyle.subTittel,
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ForgetPassword(),
              ),
            );
          },
          child: Text(
            "Forgot Password ?",
            style: TextAppStyle.subTittel,
          ),
        ),
      ],
    );
  }
}
