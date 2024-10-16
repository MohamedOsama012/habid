import 'package:flutter/material.dart';
import 'package:habit_track/core/theme/color.dart';

class NotficationWidget extends StatefulWidget {
  const NotficationWidget({
    super.key,
  });

  @override
  _NotficationWidgetState createState() => _NotficationWidgetState();
}

class _NotficationWidgetState extends State<NotficationWidget> {
  bool _isNotificationEnabled = false; // Initial state for the switch

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4), // Shadow color with opacity
              spreadRadius: 2, // How much the shadow spreads
              blurRadius: 1, // The blur radius of the shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.notifications_none_outlined,
                    size: 30,
                    color: AppColor.primeColor,
                  ),
                  const SizedBox(
                    width: 8, // Adds some spacing between the icon and the text
                  ),
                  Text(
                    "Notfication",
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              // Removed the arrow icon and kept the Switch
              Switch(
                value: _isNotificationEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _isNotificationEnabled = value; // Toggle switch state
                  });
                },
                activeTrackColor: AppColor.primeColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
