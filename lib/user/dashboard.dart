import 'dart:async';

import 'package:admin_block/pages/download_standardized_document_five.dart';
import 'package:admin_block/pages/download_standardized_document_four.dart';
import 'package:admin_block/pages/download_standardized_document_one.dart';
import 'package:admin_block/pages/download_standardized_document_six.dart';
import 'package:admin_block/pages/download_standardized_document_three.dart';
import 'package:admin_block/pages/download_standardized_document_two.dart';
import 'package:admin_block/pages/service/notifications_api.dart';
import 'package:admin_block/user/calculate_maintenance.dart';
import 'package:admin_block/user/complaints.dart';
import 'package:admin_block/user/pay_bill.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  double _lat = 44.4268;
  double _lng = 26.1025;
  Completer<GoogleMapController> _controller = Completer();
  Location location = new Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late CameraPosition _currentPosition;

  void listenNotifications() => NotificationApi.onNotificationsCallback.stream
      .listen(onClickedNotification);

  void onClickedNotification(String? payload) => Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => PayBill()));

  @override
  void initState() {
    _currentPosition = CameraPosition(
      target: LatLng(_lat, _lng),
      zoom: 12,
    );
    super.initState();

    NotificationApi.init();
    listenNotifications();
  }

  _locateMe() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    await location.getLocation().then((res) async {
      final GoogleMapController controller = await _controller.future;
      final _position = CameraPosition(
        target: LatLng(res.latitude!, res.longitude!),
        zoom: 12,
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(_position));
      setState(() {
        _lat = res.latitude!;
        _lng = res.longitude!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFFFDC1A0),
            Color(0xFFF8D8A1),
          ],
        )),
        child: Column(
          children: [
            Container(
              height: 190,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                initialCameraPosition: _currentPosition,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: true,
                markers: {
                  Marker(
                    markerId: MarkerId('current'),
                    position: LatLng(_lat, _lng),
                  )
                },
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CalculateMaintenance()));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                height: MediaQuery.of(context).size.height / 14,
                decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'CALCULATE MAINTENANCE',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                'Standardized applications',
                style: GoogleFonts.inter(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFEC936E),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: 120,
                      height: 120,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DocumentOne()));
                        },
                        child: Center(
                          child: Text(
                            'Remove person from house-keeping',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF795C48),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: 120,
                      height: 120,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DocumentTwo()));
                        },
                        child: Center(
                          child: Text(
                            'Meter reading form',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFEE882F),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: 120,
                      height: 120,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DocumentThree()));
                        },
                        child: Center(
                          child: Text(
                            'Returning working capital',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF993737),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: 120,
                      height: 120,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DocumentFour()));
                        },
                        child: Text(
                          'Sale-purchase certificate',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0x88A56333),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: 120,
                      height: 120,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DocumentFive()));
                        },
                        child: Text(
                          'Owners association application',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFE7C878),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: 120,
                      height: 120,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DocumentSix()));
                        },
                        child: Text(
                          'Add person for house-keeping',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                'Complaints',
                style: GoogleFonts.inter(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              height: MediaQuery.of(context).size.height / 13,
              decoration: BoxDecoration(
                  color: Color(0xFFAC4B32),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Complaints()));
                  },
                  child: Text(
                    'Complaints related to neighbours',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 140.0),
        child: Container(
          width: 160,
          height: 40,
          child: FloatingActionButton.extended(
            backgroundColor: Colors.deepOrange,
            onPressed: () {
              _locateMe();
            },
            label: Text(
              'My Location',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            icon: Icon(Icons.location_on),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
    );
  }

  Future notificationSelected(String payload) async {}
}
