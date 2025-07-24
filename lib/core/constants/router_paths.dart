class RouterPaths {
  static const String personBasicInfo = '/person-basic-info/:id';
  static String personBasicInfoPath(String id) => '/person-basic-info/$id';
  static const String fullPersonImage =
      '/full-person-image/:image/:width/:height';
  static String fullPersonImagePath(
    String image,
    double width,
    double height,
  ) => '/full-person-image/:image/:width/:height';
}
