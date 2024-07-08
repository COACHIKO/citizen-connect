import 'package:flutter/material.dart';

import '../../model/report_model.dart';

class MyReportScreen extends StatelessWidget {
  final Report report;

  const MyReportScreen({Key? key, required this.report}) : super(key: key);

  final Color greyColor = const Color(0xFF878787);
  final Color greenColor = const Color(0xFF18DC2B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button and report title
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomBackButton(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Report',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 21,
                          ),
                        ),
                        Text(
                          'Status',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Report image and description
                // Report image and description
                // Report image and description
                Row(
                  children: [
                    SizedBox(
                      width: 117,
                      child: Image.network(
                        report.image,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(report.description,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18)),
                          const SizedBox(height: 10),
                          Text(report.location,
                              maxLines:
                                  null, // Allows the text to expand vertically
                              textDirection: TextDirection
                                  .rtl, // Set text direction for Arabic
                              textAlign: TextAlign
                                  .start, // Ensure text starts from the right
                              style: TextStyle(color: greyColor, fontSize: 13)),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: greyColor,
                                size: 14,
                              ),
                              Text(
                                report.createdAt.timeZoneName,
                                style: TextStyle(
                                  color: greyColor,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),

                // Report details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Report Details',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Report ID',
                          style: TextStyle(
                            fontSize: 15,
                            color: greyColor,
                          ),
                        ),
                        Text(
                          report.id,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Report category',
                          style: TextStyle(
                            fontSize: 15,
                            color: greyColor,
                          ),
                        ),
                        Text(
                          report.category,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),

                // Report status
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Report Status',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Column(
                          children: [
                            CheckCircle(
                                type: report.status == 'solved' ? 1 : 0),
                            Container(
                              width: 5,
                              height: 80,
                              color: greenColor,
                            ),
                            const CheckCircle(type: 2),
                            Container(
                              width: 5,
                              height: 80,
                              color: greenColor,
                            ),
                            const CheckCircle(type: 3),
                          ],
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Reported',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    report.createdAt.timeZoneName,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: greyColor,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Approved',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    '26 Apr 2024, 0.26 pm',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: greyColor,
                                    ),
                                  ),
                                ],
                              ),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Submitted',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  // Add your submitted date here
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Define the CheckCircle widget
class CheckCircle extends StatelessWidget {
  final int type;

  const CheckCircle({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.check_circle,
      color: type == 1 ? Colors.green : Colors.red,
    );
  }
}

// Define the CustomBackButton widget (placeholder for the actual implementation)
class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}
