import 'package:flutter/material.dart';

class CheckCircle extends StatelessWidget {
  const CheckCircle({super.key, this.type = 1});

  final Color greenColor = const Color(0xFF18DC2B);

  final int type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: getColor(),
      ),
      child: Icon(
        type == 3 ? Icons.close : Icons.check,
        color: Colors.white,
        size: 15,
      ),
    );
  }

  Color getColor() {
    if (type == 1) {
      return greenColor;
    } else if (type == 2) {
      return Colors.grey.shade300;
    } else {
      return Colors.red;
    }
  }
}
