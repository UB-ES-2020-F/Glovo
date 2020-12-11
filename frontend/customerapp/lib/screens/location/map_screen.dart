import 'dart:math';

import 'package:customerapp/models/location.dart';
import 'package:customerapp/models/logged.dart';
import 'package:customerapp/models/map_location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:google_maps/google_maps.dart' as mapsOriginal;

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapLocationModel = context.watch<MapLocationModel>();
    final geocoder = mapsOriginal.Geocoder();
    return Container(
      width: 350,
      height: 350,
      padding: EdgeInsets.only(left: 30, top: 30, bottom: 30, right: 0),
      child: GoogleMap(
        initialCameraPosition:
            const CameraPosition(target: LatLng(41.4, 2.15), zoom: 12),
        onTap: (LatLng positionTapped) {
          setLocationAddressFromCoordinates(
              geocoder, positionTapped, mapLocationModel);
        },
        markers: (mapLocationModel.formValid)
            ? {
                Marker(
                    position: LatLng(
                        mapLocationModel.currentCoordinates.latitude,
                        mapLocationModel.currentCoordinates.longitude),
                    markerId: MarkerId(mapLocationModel
                            .currentCoordinates.latitude
                            .toString() +
                        mapLocationModel.currentCoordinates.longitude
                            .toString()))
              }
            : null,
      ),
    );
  }
}

void setLocationAddressFromCoordinates(mapsOriginal.Geocoder geocoder,
    LatLng position, MapLocationModel mapLocationModel) {
  geocoder.geocode(
      mapsOriginal.GeocoderRequest()
        ..location = mapsOriginal.LatLng(position.latitude, position.longitude),
      (results, status) {
    if (status == mapsOriginal.GeocoderStatus.OK) {
      if (results[3] != null) {
        mapLocationModel.name = results[3].formattedAddress;
      } else {
        throw Exception("No valid place for this place");
      }
    } else {
      throw Exception("No valid call for maps");
    }
  });
}

void getAddress_fromPos(mapsOriginal.Geocoder geocoder, LatLng position,
    MapLocationModel mapLocationModel, LoggedModel loggedModel) {
  geocoder.geocode(
      mapsOriginal.GeocoderRequest()
        ..location = mapsOriginal.LatLng(position.latitude, position.longitude),
      (results, status) {
    if (status == mapsOriginal.GeocoderStatus.OK) {
      if (results[3] != null) {
        loggedModel.getUser().location =
            Location(position.latitude, position.longitude);
        loggedModel.getUserAndNotify().direction = results[3].formattedAddress;
        return;
      } else {
        throw Exception("No valid place for this place");
      }
    } else {
      return;
    }
  });
}
