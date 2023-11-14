import "package:crowdy/src/features/auth/data/sources/geo_services.dart";
import "package:crowdy/src/features/auth/domain/repos/geo_repo.dart";
import "package:geolocator/geolocator.dart";

class GeoRepoImpl implements GeoRepo {
  @override
  Future<Position> getCurrentPosition() async {
    return GeoServices.getCurrentPosition();
  }

  @override
  Future<String> getAddressFromPosition({required Position position}) async {
    return GeoServices.getAddressFromPosition(position: position);
  }
}
