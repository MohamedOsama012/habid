import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habit_track/core/theme/style.dart';
import 'package:habit_track/feature/Auth/presentation/ui/screen/register_screen.dart';
import 'package:habit_track/feature/Settings/presentation/screen/account.dart';
import 'package:habit_track/feature/Settings/presentation/screen/chang_password.dart';
import 'package:habit_track/feature/Settings/presentation/widget/delet_and_logout.dart';
import 'package:habit_track/feature/Settings/presentation/widget/logout_dialog.dart';
import 'package:habit_track/feature/Settings/presentation/widget/notfication_widget.dart';
import 'package:habit_track/feature/Settings/presentation/widget/setting_widgets.dart';
import 'package:habit_track/feature/Settings/presentation/widget/top_page.dart';
import 'package:habit_track/routes/routes_manag.dart';
import 'package:habit_track/routes/routes_name.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TopSettingPage(),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Settings",
              style: TextAppStyle.subMainTittel.copyWith(
                fontSize: 30,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          //! edit profile
          InkWell(
            onTap: () {
              context.push(Routes.updateAccountScreen);
            },
            child: const SettingWidget(
              tittel: 'Edit Profile',
              icon: Icons.person_outline,
              show: true,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //! change password
          InkWell(
            onTap: () {
              context.push(Routes.changPasswordScreen);
            },
            child: const SettingWidget(
              tittel: 'Change Password',
              icon: Icons.lock_outline,
              show: true,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //!notfication
          const NotficationWidget(),
          const SizedBox(
            height: 20,
          ),
          //!shar app
          InkWell(
            onTap: () {
              String sharedText =
                  r' "Make your mark, cast your vote." Share via habit track application';
              Share.share(sharedText);
            },
            child: const SettingWidget(
              tittel: 'Share App',
              icon: Icons.share,
              show: false,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //!logout
          InkWell(
            onTap: () {
              _showLogoutDialog(context);
            },
            child: const LogOutWidget(
              title: 'log Out',
              icon: Icons.logout_outlined,
              show: false,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //!delete account
        ],
      ),
    );
  }

//! logout dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LogoutDialog(
          onSignOut: () async {
            try {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pop();
              // Navigator.of(context).pushAndRemoveUntil(
              //   MaterialPageRoute(builder: (context) => const RegisterScreen()),
              //   (Route<dynamic> route) => false,
              // );
              context.go(Routes.registerScreen);
            } on FirebaseAuthException catch (e) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${e.message}')),
              );
            }
          },
        );
      },
    );
  }
}
