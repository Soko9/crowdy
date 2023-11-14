import "package:geolocator/geolocator.dart";

abstract class GeoRepo {
  Future<Position> getCurrentPosition();
  Future<String> getAddressFromPosition({required Position position});
}
