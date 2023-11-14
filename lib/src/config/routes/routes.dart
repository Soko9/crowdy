import "package:crowdy/src/features/auth/presentation/screens/signin_screen.dart";
import "package:crowdy/src/features/auth/presentation/screens/signup/signup_screen.dart";
import "package:crowdy/src/features/dashboard/presentation/screens/dashboard_screen.dart";
import "package:crowdy/src/splash_screen.dart";

import "router.dart";

class ROUTES {
  static const String splash = "/";
  static const String auth = "/auth";
  static const String authSignUp = "/auth-signup";
  static const String dashboard = "/dashboard";

  static Map<String, RouteType> getRoutes = <String, RouteType>{
    splash: (c, s) => const SplashScreen(),
    auth: (c, s) => const SignInScreen(),
    authSignUp: (c, s) => const SignupScreen(),
    dashboard: (c, s) => const DashboardScreen(),
  };
}
