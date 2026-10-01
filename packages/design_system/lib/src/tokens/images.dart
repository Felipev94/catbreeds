import 'package:flutter/material.dart';

abstract final class AppImages {
  AppImages._();

  static const String _pkg = 'design_system';

  static const AssetImage fallbackAvatarCat = AssetImage(
    'assets/images/fallback_avatar_cat_image.jpg',
    package: _pkg,
  );

  static const AssetImage errorImage = AssetImage(
    'assets/images/error_image.png',
    package: _pkg,
  );
}
