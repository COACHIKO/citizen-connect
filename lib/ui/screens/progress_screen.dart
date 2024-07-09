import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/screens/home_screen.dart';
import 'package:flutter_demo/ui/utils/colors.dart';
import 'package:flutter_demo/ui/widgets/back_button.dart';
import 'package:flutter_demo/ui/widgets/check_circle.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import '../../main.dart';

class ProgressScreen extends StatefulWidget {
  final String category;
  const ProgressScreen({super.key, required this.category});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  XFile? pickedImage;
  String? description;
  Position? location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomBackButton(),
                      Center(
                        child: Image.asset(
                          'assets/images/vector.png',
                          width: 178,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Column(
                        children: [
                          CheckCircle(type: pickedImage == null ? 2 : 1),
                          Container(
                            width: 5,
                            height: 80,
                            color: pickedImage == null
                                ? Colors.grey.shade300
                                : AppColors.greenColor,
                          ),
                          CheckCircle(type: description == null ? 2 : 1),
                          Container(
                            width: 5,
                            height: 80,
                            color: description == null
                                ? Colors.grey.shade300
                                : AppColors.greenColor,
                          ),
                          CheckCircle(type: location == null ? 2 : 1),
                        ],
                      ),
                      const SizedBox(width: 15),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Upload the photo',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                            height: 85,
                          ),
                          Text(
                            'Write your description',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                            height: 85,
                          ),
                          Text(
                            'Locate your location',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                    borderRadius: BorderRadius.circular(30),
                    elevation: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.yellowColor,
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          if (pickedImage == null) {
                            final image = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (image != null) {
                              print('Image picked: ${image.path}');
                              setState(() => pickedImage = image);
                            } else {
                              print('No image picked.');
                            }
                          } else if (description == null) {
                            final desc = await Navigator.of(context)
                                .pushNamed('/description') as String?;
                            if (desc != null) {
                              print('Description entered: $desc');
                              setState(() => description = desc);
                            } else {
                              print('No description entered.');
                            }
                          } else if (location == null) {
                            final position = await checkLocationPermission();
                            print('Location obtained: $position');
                            setState(() => location = position);
                          }

                          // Check if all fields are filled before submitting
                          if (pickedImage != null &&
                              description != null &&
                              location != null) {
                            await uploadingImage(
                              description,
                              pickedImage!.path,
                              widget.category == "Road"
                                  ? "road"
                                  : widget.category == "Environmental"
                                      ? "env"
                                      : widget.category == "Electric"
                                          ? "electric"
                                          : "other",
                              location,
                            );
                          } else {
                            print('Form is incomplete.');
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 100),
                          child: Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

Future<Position> checkLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  return position;
}

Future<void> uploadingImage(
    descrtiption, String filePath, cat, posistion) async {
  var headers = {
    'Authorization': 'token ${myServices.sharedPreferences.getString("token")}'
  };

  var uri =
      Uri.parse('https://citizenconnect-plhr.onrender.com/report/$cat/create/');
  var request = http.MultipartRequest('POST', uri);

  request.headers.addAll(headers);

  // Validate if the file exists
  var file = File(filePath);
  if (!file.existsSync()) {
    print("File does not exist");
    return;
  }

  request.fields.addAll({
    'description':
        descrtiption.toString(), // Replace with actual description if needed
    'latitude':
        posistion.latitude.toString(), // Replace with actual latitude if needed
    'longitude': posistion.longitude
        .toString() // Replace with actual longitude if needed
  });

  request.files.add(await http.MultipartFile.fromPath('image', filePath));

  try {
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      Fluttertoast.showToast(
        msg: "Report Submitted",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      Get.offAll(const HomeScreen());
    } else {
      Fluttertoast.showToast(
        msg: "Error Occured",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  } catch (e) {
    Fluttertoast.showToast(
      msg: e.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }
}
