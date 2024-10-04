import 'package:flutter/material.dart';
import 'package:habit_track/feature/Settings/widget/SettingOption.dart';
import 'package:habit_track/feature/Settings/screen/account.dart';


class settingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 20),
          child: AppBar(
            title: const Text("Setting" , style: TextStyle(fontSize: 30),),
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: const IconThemeData(color: Colors.black),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 10, top: 40, right: 20, bottom: 20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'Hello, ',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: 'Gasser',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: [
                  // Account
                  buildSettingsOption(
                    title: 'Account',
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AccountPage(),
                        ),
                      );
                    },
                  ),
                  // Notifications
                  buildSettingsOption(
                    title: 'Notifications',
                    onTap: () {
                      // Navigate to notifications settings
                    },
                  ),
                  // Terms and Conditions
                  buildSettingsOption(
                    title: 'Term and Condition',
                    onTap: () {
                      // Navigate to terms and conditions
                    },
                  ),
                  // Policy
                  buildSettingsOption(
                    title: 'Policy',
                    onTap: () {
                      // Navigate to policy
                    },
                  ),
                  // About App
                  buildSettingsOption(
                    title: 'About App',
                    onTap: () {
                      // Navigate to about app
                    },
                  ),
                  // Logout
                  buildSettingsOption(
                    title: 'Logout',
                    titleColor: Colors.red,
                    onTap: () {
                      // Logout function
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


}
