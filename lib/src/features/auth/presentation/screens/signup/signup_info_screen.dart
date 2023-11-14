import "package:crowdy/src/core/extensions/extensions.dart";
import "package:crowdy/src/features/auth/data/repos/auth_repo_impl.dart";
import "package:crowdy/src/features/auth/data/repos/geo_repo_impl.dart";
import "package:crowdy/src/features/auth/presentation/controllers/auth_controller.dart";
import "package:crowdy/src/features/auth/presentation/widgets/page_nav_widget.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "../../../../../config/routes/routes.dart";
import "../../../../../core/helpers/helpers.dart";
import "../../../../../core/widgets/input_field_widget.dart";
import "../../widgets/error_box_widget.dart";

class SignupInfoScreen extends StatefulWidget {
  final VoidCallback next;

  const SignupInfoScreen({
    super.key,
    required this.next,
  });

  @override
  State<SignupInfoScreen> createState() => _SignupInfoScreenState();
}

class _SignupInfoScreenState extends State<SignupInfoScreen> {
  final AuthController _authController = Get.put(
    AuthController(authRepo: AuthRepoImpl(), geoRepo: GeoRepoImpl()),
  );
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _dob = TextEditingController(
    text: DateTime.now().format,
  );

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _email.dispose();
    _password.dispose();
    _dob.dispose();
    super.dispose();
  }

  void showCalendarDialog() async {
    DateTime? dob = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2025),
      helpText: "When's your birthday",
    );
    setState(() {
      _dob.text = dob!.format;
    });
  }

  void goToSignin() {
    Navigator.pushReplacementNamed(context, ROUTES.auth);
  }

  void goNext() {
    bool isValid = _authController.fillUserBasicInfo(
      name: _name.text,
      email: _email.text,
      password: _password.text,
      phone: _phone.text,
      dob: _dob.text.date,
    );
    if (isValid) {
      _authController.onClose();
      widget.next();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basic Info"),
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
          next: goNext,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RotatedBox(
                quarterTurns: 2,
                child: IconButton(
                  onPressed: goToSignin,
                  icon: const Icon(
                    Icons.arrow_right_alt_rounded,
                    size: 26.0,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
              ),
              Obx(
                () => Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: _authController.isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                              strokeWidth: 0.75,
                            ))
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _authController.error.isNotEmpty
                                    ? ErrorBoxWidget(
                                        error: _authController.error,
                                      )
                                    : const SizedBox(),
                                HELPERS.gap(axis: Axis.vertical),
                                InputFieldWidget(
                                  controller: _name,
                                  hint: "name",
                                  icon: Icons.text_fields_rounded,
                                  input: TextInputType.name,
                                ),
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
                                  isSecure: true,
                                ),
                                HELPERS.gap(axis: Axis.vertical),
                                InputFieldWidget(
                                  controller: _phone,
                                  hint: "phone with country code",
                                  icon: Icons.numbers_rounded,
                                  input: TextInputType.phone,
                                ),
                                HELPERS.gap(axis: Axis.vertical),
                                Row(
                                  children: [
                                    Expanded(
                                      child: InputFieldWidget(
                                        controller: _dob,
                                        isEnabled: false,
                                        icon: Icons.date_range_rounded,
                                      ),
                                    ),
                                    HELPERS.gap(
                                        axis: Axis.horizontal, size: 8.0),
                                    IconButton(
                                      onPressed: showCalendarDialog,
                                      icon: Icon(
                                        Icons.open_in_browser_rounded,
                                        size: 32.0,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
