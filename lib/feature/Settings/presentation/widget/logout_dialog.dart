import 'dart:ui';

import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onSignOut;

  const LogoutDialog({Key? key, required this.onSignOut}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.warning, color: Colors.red),
          SizedBox(width: 10),
          Text('Confirm Deletion',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      content: const Text(
        'Are you sure you want to delete your account? This action cannot be undone.',
        style: TextStyle(fontSize: 16),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Cancel
          child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
        ),
        TextButton(
          onPressed: onSignOut,
          child: const Text('Sign Out', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
