import "package:crowdy/src/features/auth/domain/repos/geo_repo.dart";
import "package:geolocator/geolocator.dart";

class GetCurrentPosition {
  final GeoRepo _geoRepo;

  const GetCurrentPosition({required GeoRepo repo}) : _geoRepo = repo;

  Future<Position> call() async {
    return _geoRepo.getCurrentPosition();
  }
}
