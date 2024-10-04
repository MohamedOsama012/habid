import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habit_track/core/theme/color.dart';
import 'package:habit_track/core/theme/screen_size.dart';
import 'package:habit_track/core/theme/style.dart';
import 'package:habit_track/feature/Auth/ui/screen/register_screen.dart';
import 'package:habit_track/feature/Auth/ui/widget/custom_button.dart';
import 'package:habit_track/feature/Auth/ui/widget/custom_text.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      print("Sending password reset instructions to: $email");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Instructions sent to $email")),
      );
      // Delay for 5 seconds before navigating back
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pop(context); // Navigate back after the delay
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 120.h, horizontal: 20.w),
          child: Form(
            key: _formKey, // Form key for validation
            child: Column(
              children: [
                Text(
                  "Enter your email below, we will send instructions to reset your password",
                  style: TextAppStyle.subTittel,
                ),
                AppScreenUtil.hight(30),
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: decorationField(),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
                AppScreenUtil.hight(30),
                CustomButton(
                  buttonName: 'Submit',
                  onPressed: _handleSubmit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
