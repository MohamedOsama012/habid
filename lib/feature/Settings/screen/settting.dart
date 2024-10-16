import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_track/core/theme/color.dart';
import 'package:habit_track/core/theme/screen_size.dart';
import 'package:habit_track/core/theme/style.dart';
import 'package:habit_track/feature/Auth/cubit/cubit/auth_cubit.dart';
import 'package:habit_track/feature/Auth/ui/screen/register_screen.dart';
import 'package:habit_track/feature/Settings/screen/account.dart';
import 'package:habit_track/feature/Settings/screen/chang_password.dart';
import 'package:habit_track/feature/Settings/widget/CustomTextWithHint.dart';
import 'package:habit_track/feature/Settings/widget/notfication_widget.dart';
import 'package:habit_track/feature/Settings/widget/setting_widgets.dart';
import 'package:habit_track/feature/Settings/widget/top_page.dart';
import 'package:habit_track/feature/Settings/widget/user_habit_goal.dart';
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
          const SizedBox(
            height: 10,
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
          InkWell(
            onTap: () {
              // Navigate to AccountPage and listen for the result
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountPage(),
                ),
              );
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
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangePasswordScreen(),
                ),
              );
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
          const NotficationWidget(),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              String sharedText =
                  r' "Make your mark, cast your vote." Share via iDemocracy application';
              Share.share(sharedText);
            },
            child: const SettingWidget(
              tittel: 'Sahre App',
              icon: Icons.share,
              show: false,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
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
          InkWell(
            onTap: () {
              _showDeletDialog(context);
            },
            child: const LogOutWidget(
              title: 'Delet Account',
              icon: Icons.delete_sharp,
              show: false,
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.warning, color: Colors.red),
              SizedBox(width: 10),
              Text('Confirm Deletion',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          content: Text(
            'Are you sure you want to delete your account? This action cannot be undone.',
            style: TextStyle(fontSize: 16),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Cancel
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pop();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                    (Route<dynamic> route) => false,
                  );
                } on FirebaseAuthException catch (e) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${e.message}')),
                  );
                }
              },
              child: Text('Sign Out', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  void _showDeletDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.warning_amber_sharp, color: Colors.red),
              SizedBox(width: 10),
              Text('Confirm Deletion',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          content: Text(
            'Are you sure you want to delete your account? This action cannot be undone.(You will lose All Data)',
            style: TextStyle(fontSize: 16),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Cancel
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.currentUser!.delete();
                  Navigator.of(context).pop();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                    (Route<dynamic> route) => false,
                  );
                } on FirebaseAuthException catch (e) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${e.message}')),
                  );
                }
              },
              child:
                  Text('Delet Account ', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
