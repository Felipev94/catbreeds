abstract final class AppRoutes {
  static const String CATS = '/cats';
  static const String CAT_DETAIL = 'detail/:catId';
  static String catDetailPath(String catId) => '/cats/detail/$catId';
}
