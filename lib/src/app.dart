import "package:crowdy/src/config/routes/router.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

import "config/themes/themes.dart";

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Crowdy App",
      debugShowCheckedModeBanner: false,
      theme: THEMES.lightTheme,
      onGenerateRoute: ROUTER.onGenerateRoute,
    );
  }
}
