import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_track/core/theme/style.dart';
import 'package:habit_track/feature/Auth/presentation/ui/screen/forget_password.dart';
import 'package:habit_track/routes/routes_name.dart';

class RememberMeForgotPasswordRow extends StatefulWidget {
  @override
  _RememberMeForgotPasswordRowState createState() =>
      _RememberMeForgotPasswordRowState();
}

class _RememberMeForgotPasswordRowState
    extends State<RememberMeForgotPasswordRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end, // Spaces out the widgets
      children: [
        TextButton(
          onPressed: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => const ForgetPassword(),
            //   ),
            // );
            context.push(Routes.forgetPasswordScreen);
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
