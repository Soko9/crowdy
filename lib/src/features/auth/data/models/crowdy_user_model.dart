import "dart:convert";

import "package:crowdy/src/features/auth/data/models/location_model.dart";
import "package:crowdy/src/features/auth/domain/entities/crowdy_user_entity.dart";

class CrowdyUserModel extends CrowdyUserEntity {
  final LocationModel? locationM;

  CrowdyUserModel({
    super.id,
    super.name,
    super.dob,
    super.email,
    super.password,
    super.phone,
    this.locationM,
    super.favs,
  });

  factory CrowdyUserModel.fromEntity({required CrowdyUserEntity entity}) =>
      CrowdyUserModel(
        id: entity.id,
        name: entity.name,
        dob: entity.dob,
        email: entity.email,
        password: entity.password,
        phone: entity.phone,
        locationM: LocationModel.fromEntity(entity: entity.location!),
        favs: entity.favs,
      );

  Map<String, dynamic> toMap() => <String, dynamic>{
        "id": id,
        "name": name,
        "dob": dob?.millisecondsSinceEpoch,
        "email": email,
        "password": password,
        "phone": phone,
        "location": locationM?.toMap(),
        "favs": favs,
      };

  factory CrowdyUserModel.fromMap(Map<String, dynamic> map) => CrowdyUserModel(
        id: map["id"] != null ? map["id"] as String : null,
        name: map["name"] != null ? map["name"] as String : null,
        dob: map["dob"] != null
            ? DateTime.fromMillisecondsSinceEpoch(map["dob"] as int)
            : null,
        email: map["email"] != null ? map["email"] as String : null,
        password: map["password"] != null ? map["password"] as String : null,
        phone: map["phone"] != null ? map["phone"] as String : null,
        locationM: map["location"] != null
            ? LocationModel.fromMap(map["location"] as Map<String, dynamic>)
            : null,
        favs: map["favs"] != null
            ? List<String>.from((map["favs"] as List<String>))
            : null,
      );

  String toJson() => json.encode(toMap());

  factory CrowdyUserModel.fromJson(String source) =>
      CrowdyUserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
