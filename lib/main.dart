import "package:flutter/material.dart";
import "package:flutter_config/flutter_config.dart";

import "package:crowdy/src/app.dart";
import "package:crowdy/src/core/resources/local_storage/local_prefs.dart";
import "package:crowdy/src/features/auth/data/sources/supabase_services.dart";

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await SupabaseServices.initServices();
  await LocalPrefs.initLocalPrefs();
  LocalPrefs.removeFirstTime();
  runApp(const App());
}
