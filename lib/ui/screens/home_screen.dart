import 'package:flutter/material.dart';
import 'package:flutter_demo/main.dart';
import 'package:flutter_demo/ui/widgets/custom_appbar.dart';
import '../../model/report_model.dart';
import '../utils/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'progress_screen.dart';
import 'time_line_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Report>>? _reportsFuture;

  @override
  void initState() {
    super.initState();
    _reportsFuture = fetchReports();
  }

  Future<void> _refreshReports() async {
    setState(() {
      _reportsFuture = fetchReports();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///bottomNavigationBar: ,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: RefreshIndicator(
            onRefresh: _refreshReports,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomAppbar(),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Text(
                      'Hello, ',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      myServices.sharedPreferences.getString('fullName') ??
                          'User',
                      style: const TextStyle(
                        fontSize: 22,
                        color: AppColors.yellowColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Text(
                  'See something wrong? Let’s report it',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF626262),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Icon(Icons.search, color: Colors.grey),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Icon(Icons.mic, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryItem(
                      title: 'Other',
                      image: 'assets/images/add_icon.png',
                      backgroundColor: Colors.green,
                    ),
                    CategoryItem(
                      title: 'Environmental',
                      image: 'assets/images/env_icon.png',
                      backgroundColor: Colors.yellow,
                    ),
                    CategoryItem(
                      title: 'Electric',
                      image: 'assets/images/elec_icon.png',
                      backgroundColor: Colors.orangeAccent,
                    ),
                    CategoryItem(
                      title: 'Road',
                      image: 'assets/images/road_icon.png',
                      backgroundColor: Colors.yellow,
                    ),
                  ],
                ),
                Divider(height: 52, color: Colors.grey.shade400),
                const Text(
                  'Recent Complaints',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<Report>>(
                    future: _reportsFuture,
                    builder: (context, snapshot) {
                      final now = DateTime.now();
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: Text('No reports found'));
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final report = snapshot.data![index];
                            return RecentComplaintItem(
                              category: report.category,
                              image: report.image,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => TimeLineScreen(
                                      category: report.category.toLowerCase(),
                                    ),
                                  ),
                                );
                              },
                              daysAgo: now
                                  .difference(report.createdAt)
                                  .inDays
                                  .toString(),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<List<Report>> fetchReports() async {
  final response = await http.get(
    Uri.parse('https://citizenconnect-plhr.onrender.com/report/last-reports/'),
    headers: {
      'Authorization':
          'token ${myServices.sharedPreferences.getString("token")}',
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((report) => Report.fromJson(report)).toList();
  } else {
    throw Exception('Failed to load reports');
  }
}

class RecentComplaintItem extends StatelessWidget {
  const RecentComplaintItem({
    super.key,
    required this.image,
    required this.category,
    required this.onTap,
    required this.daysAgo,
  });

  final String image;
  final String daysAgo;
  final String category;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Image.network(
              image,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$category | $daysAgo',
                  style:
                      const TextStyle(fontSize: 14, color: AppColors.greyColor),
                ),
                const SizedBox(height: 10),
              ],
            ),
            const Spacer(),
            InkWell(
              onTap: () => onTap(),
              child: const Row(
                children: [
                  Text(
                    'See All',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.yellowColor,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    size: 15,
                    color: AppColors.yellowColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.title,
    required this.image,
    required this.backgroundColor,
  });

  final String title;
  final String image;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProgressScreen(
              category: title,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              width: 45,
              height: 45,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: backgroundColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Image.asset(image),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
