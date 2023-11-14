import "package:crowdy/src/core/enums/interests_enum.dart";
import "package:crowdy/src/features/auth/data/repos/auth_repo_impl.dart";
import "package:crowdy/src/features/auth/data/repos/geo_repo_impl.dart";
import "package:crowdy/src/features/auth/presentation/controllers/auth_controller.dart";
import "package:crowdy/src/features/auth/presentation/widgets/error_box_widget.dart";
import "package:crowdy/src/features/auth/presentation/widgets/interests_picker_widget.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "../../widgets/page_nav_widget.dart";

class SignupFavScreen extends StatefulWidget {
  final VoidCallback prev;

  const SignupFavScreen({
    super.key,
    required this.prev,
  });

  @override
  State<SignupFavScreen> createState() => _SignupFavScreenState();
}

class _SignupFavScreenState extends State<SignupFavScreen> {
  final AuthController _authController = Get.put(
    AuthController(authRepo: AuthRepoImpl(), geoRepo: GeoRepoImpl()),
  );

  final List<Interests> _interests = List.empty(growable: true);

  void finish() {
    _authController.fillFavList(interests: _interests);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("What're you interested in?"),
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
          prev: () {
            _authController.onClose();
            widget.prev();
          },
          next: _interests.length < 3 ? null : finish,
          nextLabel: "finish",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(
            () => _authController.isLoading
                ? const Center(
                    child: CircularProgressIndicator(strokeWidth: 0.75))
                : _authController.error.isNotEmpty
                    ? ErrorBoxWidget(error: _authController.error)
                    : Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: Interests.values
                            .map(
                              (interest) => InterestsPickerWidget(
                                interest: interest,
                                isSelected: false,
                                onSelect: (value) {
                                  if (value) {
                                    setState(() {
                                      _interests.add(interest);
                                    });
                                  } else {
                                    setState(() {
                                      _interests.remove(interest);
                                    });
                                  }
                                },
                              ),
                            )
                            .toList(),
                      ),
          ),
        ),
      ),
    );
  }
}
