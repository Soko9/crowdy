import "package:crowdy/src/config/routes/routes.dart";
import "package:flutter/material.dart";

typedef RouteType = Widget Function(BuildContext c, RouteSettings s);

class ROUTER {
  static Route onGenerateRoute(RouteSettings settings) {
    try {
      final child = ROUTES.getRoutes[settings.name];
      Widget builder(BuildContext context) => child!(context, settings);
      return MaterialPageRoute(builder: builder);
    } catch (e) {
      throw const FormatException("Route not found!");
    }
  }
}
