import "package:crowdy/src/config/routes/routes.dart";
import "package:crowdy/src/features/auth/data/sources/supabase_services.dart";
import "package:flutter/material.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    if (!mounted) return;
    if (SupabaseServices.session != null) {
      Navigator.pushReplacementNamed(context, ROUTES.dashboard);
    } else {
      Navigator.pushReplacementNamed(context, ROUTES.auth);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 0.75,
        ),
      ),
    );
  }
}
