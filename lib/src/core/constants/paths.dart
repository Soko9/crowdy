class PATHS {
  static const String _mainRoute = "assets";
  static const String _logosRoute = "logos";

  static String getLogoPath({required String logo}) =>
      "$_mainRoute/$_logosRoute/${logo}_logo.png";
}
