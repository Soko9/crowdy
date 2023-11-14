import "package:crowdy/src/config/routes/routes.dart";
import "package:crowdy/src/core/helpers/helpers.dart";
import "package:crowdy/src/core/widgets/input_field_widget.dart";
import "package:crowdy/src/features/auth/data/repos/auth_repo_impl.dart";
import "package:crowdy/src/features/auth/data/repos/geo_repo_impl.dart";
import "package:crowdy/src/features/auth/presentation/controllers/auth_controller.dart";
import "package:crowdy/src/features/auth/presentation/widgets/error_box_widget.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final AuthController _authController = Get.put(
    AuthController(authRepo: AuthRepoImpl(), geoRepo: GeoRepoImpl()),
  );

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _authController.onClose();
    super.dispose();
  }

  void signInPressed() {
    _authController.signIn(email: _email.text, password: _password.text);
  }

  void goToSignup() {
    Navigator.pushReplacementNamed(context, ROUTES.authSignUp);
    _authController.onClose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Obx(
            () => _authController.isLoading
                ? const CircularProgressIndicator(strokeWidth: 0.75)
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _authController.error.isNotEmpty
                          ? ErrorBoxWidget(error: _authController.error)
                          : const SizedBox(),
                      HELPERS.gap(axis: Axis.vertical),
                      InputFieldWidget(
                        controller: _email,
                        hint: "email",
                        icon: Icons.email_outlined,
                        input: TextInputType.emailAddress,
                      ),
                      HELPERS.gap(axis: Axis.vertical),
                      InputFieldWidget(
                        controller: _password,
                        hint: "password",
                        icon: Icons.password,
                        input: TextInputType.visiblePassword,
                        isSecure: true,
                      ),
                      HELPERS.gap(axis: Axis.vertical, count: 2),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: signInPressed,
                              child: const Text("sign in"),
                            ),
                          ),
                          HELPERS.gap(axis: Axis.horizontal, size: 8.0),
                          IconButton(
                            onPressed: goToSignup,
                            icon: const Icon(
                              Icons.arrow_right_alt_rounded,
                              size: 26.0,
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
