import "package:crowdy/src/features/auth/data/repos/auth_repo_impl.dart";
import "package:crowdy/src/features/auth/data/repos/geo_repo_impl.dart";
import "package:crowdy/src/features/auth/presentation/controllers/auth_controller.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final AuthController _authController = Get.put(
    AuthController(authRepo: AuthRepoImpl(), geoRepo: GeoRepoImpl()),
  );

  @override
  void dispose() {
    _authController.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(
            onPressed: () {
              _authController.signOut();
            },
            icon: const Icon(
              Icons.logout_rounded,
              size: 26.0,
            ),
          ),
        ],
      ),
      body: const Center(
        child: OutlinedButton(
          onPressed: null,
          child: Text("print data"),
        ),
      ),
    );
  }
}
