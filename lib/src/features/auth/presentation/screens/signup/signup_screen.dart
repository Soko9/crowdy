import "package:crowdy/src/features/auth/presentation/screens/signup/signup_favs_screen.dart";
import "package:crowdy/src/features/auth/presentation/screens/signup/signup_info_screen.dart";
import "package:crowdy/src/features/auth/presentation/screens/signup/signup_location_screen.dart";
import "package:flutter/material.dart";

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeIn,
    );
  }

  void prevPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      pageSnapping: true,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        SignupInfoScreen(next: nextPage),
        SignUpLocationScreen(
          next: nextPage,
          prev: prevPage,
        ),
        SignupFavScreen(prev: prevPage),
      ],
    );
  }
}
