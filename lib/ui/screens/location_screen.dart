import 'package:flutter/material.dart';
import 'package:flutter_demo/ui/utils/colors.dart';
import 'package:flutter_demo/ui/widgets/back_button.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  CustomBackButton(),
                  Text(
                    'Enter your location',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: CurrentLocationWidget()),
          ],
        ),
      ),
    );
  }
}

class CurrentLocationWidget extends StatefulWidget {
  const CurrentLocationWidget({super.key});

  @override
  CurrentLocationWidgetState createState() => CurrentLocationWidgetState();
}

class CurrentLocationWidgetState extends State<CurrentLocationWidget> {
  String location = 'Press button to get location';

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    /// Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      /// Location services are not enabled don't continue
      /// accessing the position and request users of the
      /// App to enable the location services.
      setState(() {
        location = 'Location services are disabled.';
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        /// Permissions are denied, next time you could try
        /// requesting permissions again (this is also where
        /// Android's shouldShowRequestPermissionRationale
        /// returned true. According to Android guidelines
        /// your App should show an explanatory UI now.
        setState(() {
          location = 'Location permissions are denied';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      /// Permissions are denied forever, handle appropriately.
      setState(() {
        location = 'Location permissions are permanently denied, we cannot request permissions.';
      });
      return;
    }

    /// When we reach here, permissions are granted and we can
    /// continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      location = 'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
      Navigator.of(context).pop(position);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amberAccent.shade100,
              ),
              child: const Icon(
                Icons.location_on,
                size: 50,
                color: AppColors.yellowColor,
              ),
            ),
            const SizedBox(height: 20),
            Text(location, style: const TextStyle(color: Colors.white)),
            const Text(
              'What is Your Location?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'We need to know your location in order to suggest nearby services.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.greyColor,
              ),
            ),
            const SizedBox(height: 20),
            Material(
              borderRadius: BorderRadius.circular(30),
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.amberAccent,
                ),
                child: MaterialButton(
                  onPressed: _getCurrentLocation,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    child: Text(
                      'Allow Location Access',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
