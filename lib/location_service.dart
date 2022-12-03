import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geolocator;
import 'package:location/location.dart' as location;
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  static geolocator.Position? position;
  static PermissionStatus? permissionStatus;
  static ServiceStatus? serviceStatus;
  static bool? serviceEnabled;

  static Future<PermissionStatus> functionPermissionStatus(
      BuildContext context) async {
    SnackBar snackBar;
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);
    permissionStatus = await Permission.location.request();

    switch (permissionStatus) {
      case PermissionStatus.denied:
        snackBar = const SnackBar(
          content: Text('Location permissions are denied.'),
        );
        scaffoldMessenger.showSnackBar(snackBar);
        break;
      case PermissionStatus.granted:
        break;
      case PermissionStatus.restricted:
        snackBar = const SnackBar(
          content: Text('Location permissions are restricted.'),
        );
        scaffoldMessenger.showSnackBar(snackBar);
        break;
      case PermissionStatus.limited:
        snackBar = const SnackBar(
          content: Text('Location permissions are limited.'),
        );
        scaffoldMessenger.showSnackBar(snackBar);
        break;
      case PermissionStatus.permanentlyDenied:
        snackBar = const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.'),
          action: SnackBarAction(
            label: 'CHANGE SETTINGS',
            onPressed: openAppSettings,
          ),
        );
        scaffoldMessenger.showSnackBar(snackBar).setState;
        break;

      default:
        snackBar = const SnackBar(
          content: Text('Unknown error.'),
        );
        scaffoldMessenger.showSnackBar(snackBar);
        break;
    }
    return Future.value(permissionStatus);
  }

  static Future<ServiceStatus> functionServiceStatus(
      BuildContext context) async {
    location.Location locationObject = location.Location();
    SnackBar snackBar;
    ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(context);

    serviceStatus = await Permission.location.serviceStatus;

    switch (serviceStatus) {
      case ServiceStatus.disabled:
        serviceEnabled = await locationObject.requestService();
        if (serviceEnabled == false) {
          snackBar = const SnackBar(
            content: Text('Location service request are denied.'),
            action: SnackBarAction(
              label: 'CHANGE SETTINGS',
              onPressed: geolocator.Geolocator.openLocationSettings,
            ),
          );
          scaffoldMessenger.showSnackBar(snackBar).setState;
        } else if (serviceEnabled == true) {
          serviceStatus = ServiceStatus.enabled;
        } else {
          snackBar = const SnackBar(
            content: Text('Location service request are null.'),
          );
          scaffoldMessenger.showSnackBar(snackBar);
        }
        break;
      case ServiceStatus.enabled:
        break;
      case ServiceStatus.notApplicable:
        snackBar = const SnackBar(
          content: Text('Location service are not applicable.'),
        );
        scaffoldMessenger.showSnackBar(snackBar);
        break;

      default:
        snackBar = const SnackBar(
          content: Text('Unknown error.'),
        );
        scaffoldMessenger.showSnackBar(snackBar);
        break;
    }
    return Future.value(serviceStatus);
  }

  static Future<geolocator.Position> determinePosition({
    required BuildContext context,
    required bool mounted,
  }) async {
    await functionPermissionStatus(context);
    if (permissionStatus == PermissionStatus.granted) {
      log("PermissionStatus.granted");
      if (!mounted) return Future.error('Error: The Widget has not mounted.');
      await functionServiceStatus(context);
      if (serviceStatus == ServiceStatus.enabled) {
        log("ServiceStatus.enabled");
        return await geolocator.Geolocator.getCurrentPosition();
      } else {
        log('Error occurred because functionServiceStatus() not returned ServiceStatus.enabled');
        return Future.error('Error occurred while fetching the location.');
      }
    } else {
      log('Error occurred because functionPermissionStatus() not returned PermissionStatus.granted');
      return Future.error('Error occurred while fetching the location.');
    }
  }
}
