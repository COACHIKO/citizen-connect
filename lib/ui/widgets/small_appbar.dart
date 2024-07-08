import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/widgets/back_button.dart';

class SmallAppbar extends StatelessWidget {
  const SmallAppbar({super.key, required this.title, this.color = Colors.white});

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CustomBackButton(color: color),
        ),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        const SizedBox(width: 80),
      ],
    );
  }
}
