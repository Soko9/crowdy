import "package:flutter/material.dart";

class ROUTER {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        return _noRoute();
    }
  }

  static Route _route({required Widget screen}) =>
      MaterialPageRoute(builder: (_) => screen);
  // To add navigation transitions and animations easily

  static Route _noRoute() => MaterialPageRoute(
        builder: (context) => Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error.withOpacity(0.2),
              border: Border.all(
                width: 1.0,
                color: Theme.of(context).colorScheme.error,
              )),
          child: Center(
            child: Text(
              "No Route Found!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ),
      );
}
