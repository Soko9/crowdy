import "dart:async";
import "package:crowdy/src/features/auth/data/repos/auth_repo_impl.dart";
import "package:crowdy/src/features/auth/data/repos/geo_repo_impl.dart";
import "package:crowdy/src/features/auth/presentation/controllers/auth_controller.dart";
import "package:crowdy/src/features/auth/presentation/widgets/error_box_widget.dart";
import "package:crowdy/src/features/auth/presentation/widgets/page_nav_widget.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

class SignUpLocationScreen extends StatefulWidget {
  final VoidCallback next;
  final VoidCallback prev;

  const SignUpLocationScreen({
    super.key,
    required this.next,
    required this.prev,
  });

  @override
  State<SignUpLocationScreen> createState() => _SignUpLocationScreenState();
}

class _SignUpLocationScreenState extends State<SignUpLocationScreen> {
  final AuthController _authController = Get.put(
    AuthController(authRepo: AuthRepoImpl(), geoRepo: GeoRepoImpl()),
  );

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();

  @override
  void dispose() {
    _authController.onClose();
    super.dispose();
  }

  void getMyLocationPressed() async {
    _authController.updateMarkers(marks: {});
    await _authController.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Where are you located"),
        titleTextStyle: TextStyle(
          fontFamily: "Hermit",
          fontSize: 18.0,
          fontWeight: FontWeight.w300,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      bottomNavigationBar: SizedBox(
        height: kBottomNavigationBarHeight,
        child: PageNavWidget(
          next: () {
            _authController.onClose();
            widget.next();
          },
          prev: () {
            _authController.onClose();
            widget.prev();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: FloatingActionButton(
        onPressed: getMyLocationPressed,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        foregroundColor: Theme.of(context).colorScheme.tertiary,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 2.0,
            color: Theme.of(context).colorScheme.tertiary,
          ),
          borderRadius: BorderRadius.circular(100.0),
        ),
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightElevation: 0,
        child: Obx(
          () => _authController.isLoading
              ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(strokeWidth: 2.5),
                )
              : const Icon(
                  Icons.my_location_rounded,
                  size: 26.0,
                ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Obx(
              () => _authController.error.isNotEmpty
                  ? Center(child: ErrorBoxWidget(error: _authController.error))
                  : GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: _authController.latlng.value,
                        zoom: _authController.zoom.value,
                      ),
                      onMapCreated: (controller) {
                        _mapController.complete(controller);
                      },
                      markers: _authController.markers,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
