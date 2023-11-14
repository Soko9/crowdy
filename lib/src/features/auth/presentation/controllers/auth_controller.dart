import "package:crowdy/src/config/routes/routes.dart";
import "package:crowdy/src/core/extensions/extensions.dart";
import "package:crowdy/src/core/helpers/helpers.dart";
import "package:crowdy/src/features/auth/domain/entities/crowdy_user_entity.dart";
import "package:crowdy/src/features/auth/domain/entities/location_entity.dart";
import "package:crowdy/src/features/auth/domain/repos/auth_repo.dart";
import "package:crowdy/src/features/auth/domain/repos/geo_repo.dart";
import "package:crowdy/src/features/auth/domain/usecases/auth/sign_in_user.dart";
import "package:crowdy/src/features/auth/domain/usecases/auth/sign_out_user.dart";
import "package:crowdy/src/features/auth/domain/usecases/auth/sign_up_user.dart";
import "package:crowdy/src/features/auth/domain/usecases/geo/get_address_from_position.dart";
import "package:crowdy/src/features/auth/domain/usecases/geo/get_current_position.dart";
import "package:geolocator/geolocator.dart";
import "package:get/get.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:supabase_flutter/supabase_flutter.dart";
import "package:uuid/uuid.dart";

import "../../../../core/enums/enums.dart";
import "../../../../core/resources/local_storage/local_prefs.dart";

class AuthController extends GetxController {
  final AuthRepo _authRepo;
  final GeoRepo _geoRepo;

  AuthController({required GeoRepo geoRepo, required AuthRepo authRepo})
      : _authRepo = authRepo,
        _geoRepo = geoRepo;

  @override
  void onClose() {
    clearAttributes();
    super.onClose();
  }

  void clearAttributes() {
    // name.value = "";
    // email.value = "";
    // password.value = "";
    // phone.value = "";
    // dob.value = DateTime.now();
    // favs.clear();
    isLoading = false;
    error = "";
  }

  final Rx<String> name = "".obs;
  final Rx<String> email = "".obs;
  final Rx<String> password = "".obs;
  final Rx<DateTime> dob = DateTime.now().obs;
  final Rx<String> phone = "".obs;
  final List<String> favs = List.empty(growable: true);
  LocationEntity? locationEntity;
  final Rx<LatLng> latlng = Rx<LatLng>(const LatLng(88.0, -44));
  final Rx<double> zoom = 5.0.obs;
  RxSet<Marker> markers = <Marker>{}.obs;

  final Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  final Rx<String> _error = "".obs;
  String get error => _error.value;
  set error(String value) => _error.value = value;

  String printUserInfo() =>
      "name: ${name.value}\nemail: ${email.value}\npassword: ${password.value}\nphone: ${phone.value}\ndob: ${dob.value}\nLocation: $locationEntity";

  bool fillUserBasicInfo({
    required String name,
    required String email,
    required String password,
    required String phone,
    required DateTime dob,
  }) {
    try {
      if (name.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty) {
        throw ("Fill all empty fields");
      }
      if (!email.isEmail) {
        throw ("Invalid email");
      }
      if (!phone.isPhoneNumber) {
        throw ("Invalid Phone number");
      }
      if (password.length <= 5 ||
          password.isAlphabetOnly ||
          password.isNumericOnly) {
        throw ("Password needs to be stronger");
      }
      this.name.value = name;
      this.email.value = email;
      this.password.value = password;
      this.phone.value = phone;
      this.dob.value = dob;
      return true;
    } catch (e) {
      error = e.toString();
      return false;
    }
  }

  void fillFavList({required List<Interests> interests}) {
    isLoading = true;
    for (Interests interest in interests) {
      favs.add(interest.name.capital);
    }
    // signUp();
    isLoading = false;
    print(printUserInfo());
  }

  void updateMarkers({required Set<Marker> marks}) {
    markers.update((value) {
      value = marks;
    });
  }

  Future signIn({required String email, required String password}) async {
    isLoading = true;
    try {
      final AuthResponse response = await SignInUser(repo: _authRepo).call(
        email: email,
        password: password,
      );
      if (response.session != null) {
        Get.offAllNamed(ROUTES.dashboard);
      }
    } on AuthException catch (e) {
      error = e.message;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  Future<void> signUp() async {
    final CrowdyUserEntity user = CrowdyUserEntity(
      id: const Uuid().v4(),
      name: name.value,
      email: email.value,
      password: password.value,
      phone: phone.value,
      dob: dob.value,
      favs: favs,
    );
    try {
      final AuthResponse response = await SignUpUser(repo: _authRepo).call(
        user: user,
      );
      if (response.session != null) {
        LocalPrefs.firstTime = true;
        Get.offAllNamed(ROUTES.dashboard);
      }
    } on AuthException catch (e) {
      error = e.message;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  Future<void> signOut() async {
    isLoading = true;
    try {
      await SignOutUser(repo: _authRepo).call();
      Get.offAllNamed(ROUTES.auth);
    } on AuthException catch (e) {
      error = e.message;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }

  Future<void> getCurrentPosition() async {
    isLoading = true;
    try {
      final Position position = await GetCurrentPosition(
        repo: _geoRepo,
      ).call();
      final String address = await GetAddessFromPosition(repo: _geoRepo).call(
        position: position,
      );
      locationEntity = LocationEntity(
        lat: position.latitude,
        lon: position.longitude,
        address: address,
      );
      latlng.value = LatLng(position.latitude, position.longitude);
      zoom.value = 19.0;
      HELPERS.showSnackBar(
        message:
            "Latitude: ${position.latitude}\nLongitude: ${position.longitude}\nAddress: $address",
        type: SnackType.success,
      );
      markers.add(
        Marker(
          markerId: const MarkerId("myLocation"),
          position: latlng.value,
        ),
      );
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
    }
  }
}
