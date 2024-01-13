class SpecializedRoute {
  final String name;
  final String path;
  String? viewName;

  SpecializedRoute(
    this.name, {
    required this.path,
    this.viewName,
  });
}

class Routes {
  static SpecializedRoute home = SpecializedRoute(
    "home",
    path: "/",
    viewName: "Converter"
  );

  static SpecializedRoute saved = SpecializedRoute(
    "saved",
    path: "/saved",
    viewName: "Stored"
  );
}
