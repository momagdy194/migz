import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UrlLauncherMap extends StatelessWidget {
  final String latitude;
  final String longitude;
  final String address;
  final Widget child;

  UrlLauncherMap(
      {required this.latitude,
      required this.longitude,
      required this.child,
      required this.address});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        launchURL() async {
          const String homeLat = "37.3230";
          const String homeLng = "-122.0312";

          final String googleMapslocationUrl =
              "https://www.google.com/maps/search/?api=1&query=${latitude},${ longitude}";

          final String encodedURl = Uri.encodeFull(googleMapslocationUrl);
print("googleMapslocationUrl ${googleMapslocationUrl}");
          if (await canLaunch(encodedURl)) {
            await launch(encodedURl);
          } else {
            print('Could not launch $encodedURl');
            throw 'Could not launch $encodedURl';
          }
        }

        // late String gMapsUrl;
        // if (latitude.isEmpty || longitude.isEmpty) {
        //   String query = Uri.encodeComponent(address);
        //   gMapsUrl = 'https://www.google.com/maps/search/?api=1&query=$query';
        // } else {
        //   gMapsUrl =
        //   'https://www.google.com/maps/dir/api=1&destination=$latitude,$longitude&travelmode=driving';
        // }
        //
        //
        // launchUrlString('$gMapsUrl');

        launchURL();
      },
      child: child,
    );
  }
}
