import "package:crowdy/src/features/auth/domain/repos/geo_repo.dart";
import "package:geolocator/geolocator.dart";

class GetAddessFromPosition {
  final GeoRepo _geoRepo;

  const GetAddessFromPosition({required GeoRepo repo}) : _geoRepo = repo;

  Future<String> call({required Position position}) async {
    return _geoRepo.getAddressFromPosition(position: position);
  }
}
