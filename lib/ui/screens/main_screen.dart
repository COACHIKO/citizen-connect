import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/screens/home_screen.dart';
import 'package:flutter_demo/ui/screens/profile_screen.dart';
import 'package:flutter_demo/ui/utils/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: const Icon(Icons.call, color: AppColors.greyColor),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shadowColor: Colors.black,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () => setState(() => _selectedIndex = 0),
              child: Column(
                children: [
                  Icon(
                    Icons.home_outlined,
                    size: 30,
                    color: _selectedIndex == 0 ? AppColors.yellowColor : Colors.grey,
                  ),
                  Text(
                    'Home',
                    style: TextStyle(
                      color: _selectedIndex == 0 ? AppColors.yellowColor : Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () => setState(() => _selectedIndex = 1),
              child: Column(
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 30,
                    color: _selectedIndex == 1 ? AppColors.yellowColor : Colors.grey,
                  ),
                  Text(
                    'Profile',
                    style: TextStyle(
                      color: _selectedIndex == 1 ? AppColors.yellowColor : Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: _selectedIndex == 0 ? const HomeScreen() : const ProfileScreen(),
    );
  }
}
