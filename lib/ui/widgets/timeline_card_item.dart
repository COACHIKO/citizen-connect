import 'package:flutter/material.dart';
import 'package:flutter_demo/model/report_model.dart';
import 'package:intl/intl.dart';

class TimelineCardItem extends StatelessWidget {
  final Report report;
  const TimelineCardItem({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(report.createdAt);

    return Card(
      color: Colors.white,
      elevation: 5,
      child: Column(
        children: [
          Image.network(
            report.image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        report.description,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: null,
                        overflow: TextOverflow.visible,
                      ),
                      Column(
                        children: [
                          Text(
                            '$formattedDate | Egypt',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFFAB6585),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
