import "package:crowdy/src/core/extensions/extensions.dart";
import "package:crowdy/src/features/auth/domain/entities/location_entity.dart";

class CrowdyUserEntity {
  String? id;
  String? name;
  DateTime? dob;
  String? email;
  String? password;
  String? phone;
  LocationEntity? location;
  List<String>? favs;

  CrowdyUserEntity({
    this.id,
    this.name,
    this.dob,
    this.email,
    this.password,
    this.phone,
    this.location,
    this.favs,
  });

  @override
  String toString() =>
      "id: $id\nname: $name\nemail: $email\npassword: $password\nphone: $phone\ndob: ${dob?.format}\nlocation: $location\nFavs: $favs";
}
