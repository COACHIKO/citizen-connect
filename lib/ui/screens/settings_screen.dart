import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/utils/colors.dart';
import 'package:flutter_demo/ui/widgets/small_appbar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
                const SmallAppbar(title: 'Settings'),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 7,
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
                          SettingItem(
                            title: 'Notification Settings',
                            icon: 'assets/images/Group 364.png',
                            onTap: () {
                              Navigator.of(context).pushNamed('/notification-settings');
                            },
                          ),
                          const SizedBox(height: 20),
                          SettingItem(
                            title: 'Password Settings',
                            icon: 'assets/images/Group 365.png',
                            onTap: () {
                              Navigator.of(context).pushNamed('/password-settings');
                            },
                          ),
                          const SizedBox(height: 20),
                          SettingItem(
                            title: 'Delete account',
                            icon: 'assets/images/Group 421.png',
                            onTap: () {},
                          ),
                          const SizedBox(height: 20),
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
}

class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 50,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_outlined)
        ],
      ),
    );
  }
}
