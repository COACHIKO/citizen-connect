import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/utils/colors.dart';
import 'package:flutter_demo/ui/widgets/small_appbar.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  bool generalNotification = true;
  bool sound = true;
  bool soundCall = true;
  bool vibrate = true;
  bool reportUpdate = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.yellowColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                const SmallAppbar(title: 'Notification Settings'),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 25),
                          buildSettingItem(
                            'General notifications',
                            generalNotification,
                            (value) {
                              setState(() => generalNotification = value);
                            },
                          ),
                          buildSettingItem(
                            'Sound',
                            sound,
                            (value) {
                              setState(() => sound = value);
                            },
                          ),
                          buildSettingItem(
                            'Sound Call',
                            soundCall,
                            (value) {
                              setState(() => soundCall = value);
                            },
                          ),
                          buildSettingItem(
                            'Vibrate',
                            vibrate,
                            (value) {
                              setState(() => vibrate = value);
                            },
                          ),
                          buildSettingItem(
                            'Report Update',
                            reportUpdate,
                            (value) {
                              setState(() => reportUpdate = value);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSettingItem(
    String title,
    bool value,
    Function(bool) onChanged,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF01BF92),
          thumbColor: WidgetStateProperty.all(Colors.white),
          inactiveTrackColor: Colors.grey.shade300,
        ),
      ],
    );
  }
}
