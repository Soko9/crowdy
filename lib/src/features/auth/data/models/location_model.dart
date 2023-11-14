import "dart:convert";
import "package:crowdy/src/features/auth/domain/entities/location_entity.dart";

class LocationModel extends LocationEntity {
  LocationModel({
    super.lat,
    super.lon,
    super.address,
  });

  factory LocationModel.fromEntity({required LocationEntity entity}) =>
      LocationModel(
        lat: entity.lat,
        lon: entity.lon,
        address: entity.address,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        "lat": lat,
        "lon": lon,
        "address": address,
      };

  factory LocationModel.fromMap(Map<String, dynamic> map) => LocationModel(
        lat: map["lat"] as double,
        lon: map["lon"] as double,
        address: map["address"] as String,
      );

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) =>
      LocationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
