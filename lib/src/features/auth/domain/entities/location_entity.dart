class LocationEntity {
  final double? lat;
  final double? lon;
  final String? address;

  const LocationEntity({
    this.lat,
    this.lon,
    this.address,
  });

  @override
  String toString() =>
      "LocationEntity(lat: $lat, lon: $lon, address: $address)";
}
