import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMaps extends StatefulWidget {
  dynamic lat;
  dynamic long;
  GoogleMaps({this.lat, this.long, Key? key}) : super(key: key);

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  var myMarkers = HashSet<Marker>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            minMaxZoomPreference: MinMaxZoomPreference(7, 17),
            zoomGesturesEnabled: true,
            initialCameraPosition: CameraPosition(
              target: LatLng(double.parse(widget.lat!.toString()),
                  double.parse(widget.long!.toString())),
              zoom: 7,
            ),
            myLocationButtonEnabled: false,
            onMapCreated: (GoogleMapController googleMapController) {
              setState(() {
                myMarkers.add(
                  Marker(
                    markerId: MarkerId("1"),
                    position: LatLng(double.parse(widget.lat!.toString()),
                        double.parse(widget.long!.toString())),
                    // onTap: () {
                    //   setState(() {
                    //     status = !status;
                    //   });
                    // }
                  ),
                );
              });
            },
            markers: myMarkers,
          ),
          // Container(
          //   margin: EdgeInsets.symmetric(vertical: 30.h),
          //   child: IconButton(
          //       onPressed: () {
          //         Navigator.pushReplacementNamed(
          //             context, '/BootomNaviagtionScreen');
          //         // Navigator.pushReplacementNamed(context, '/Home');
          //       },
          //       icon: Icon(
          //         Icons.arrow_back_ios,
          //         size: 30.h,
          //         color: Colors.black,
          //       )),
          // ),
        ],
      ),
    );
  }
}
