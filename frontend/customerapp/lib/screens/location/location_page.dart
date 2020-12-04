import 'package:customerapp/screens/location/location_content.dart';
import 'package:flutter/material.dart';

class LocationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(padding: EdgeInsets.all(30), child: LocationContent()));
  }
}
