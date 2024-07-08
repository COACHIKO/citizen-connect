import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/utils/colors.dart';
import 'package:flutter_demo/ui/widgets/timeline_card_item.dart';

import '../../model/report_model.dart';
import '../widgets/custom_appbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ElectricScreen extends StatefulWidget {
  final String category;
  const ElectricScreen({super.key, required this.category});

  @override
  _ElectricScreenState createState() => _ElectricScreenState();
}

class _ElectricScreenState extends State<ElectricScreen> {
  late Future<List<Report>> futureReports;

  @override
  void initState() {
    super.initState();
    futureReports = fetchReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CustomAppbar(
                title: widget.category,
                withBackButton: true,
              ),
              FutureBuilder<List<Report>>(
                future: futureReports,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Failed to load reports'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No reports found'));
                  } else {
                    final reports = snapshot.data!;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: reports.length,
                        itemBuilder: (context, index) {
                          final report = reports[index];
                          return Column(
                            children: [
                              const SizedBox(
                                height: 35,
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 12,
                                      color: AppColors.greyColor,
                                    ),
                                    Text(
                                      report.user.fullName,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.greyColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              TimelineCardItem(
                                report: report,
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<List<Report>> fetchReports() async {
  final response = await http.get(
    Uri.parse(
        'https://citizenconnect-plhr.onrender.com/report/electric/timeline/'),
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((report) => Report.fromJson(report)).toList();
  } else {
    throw Exception('Failed to load reports');
  }
}
