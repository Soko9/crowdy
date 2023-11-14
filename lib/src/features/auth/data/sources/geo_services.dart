import "package:geocoding/geocoding.dart";
import "package:geolocator/geolocator.dart";

class GeoServices {
  GeoServices._();

  static Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    bool output = false;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      output = false;
    } else {
      output = true;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw "Location permission was denied";
      }
    } else {
      output = true;
    }
    if (permission == LocationPermission.deniedForever) {
      throw "Location permission was denied forever";
    } else {
      output = true;
    }
    return output;
  }

  static Future<Position> getCurrentPosition() async {
    bool isPermissionHandled = await _handleLocationPermission();
    if (!isPermissionHandled) {
      throw "Error handeling permission";
    }
    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position;
  }

  static Future<String> getAddressFromPosition({
    required Position position,
  }) async {
    final List<Placemark> places = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    final Placemark location = places.first;
    return "${location.country}, ${location.administrativeArea == null ? "" : "${location.administrativeArea}, "}${location.street == null ? "" : "${location.street}, "}${location.locality == null ? "" : "${location.locality}, "}${location.subLocality == null ? "" : "${location.subLocality}"}";
  }
}
