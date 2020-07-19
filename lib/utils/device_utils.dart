import 'package:flutter/material.dart';

class DeviceUtils {
  static const kTabletMasterContainerWidth = 350.0;

  bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 768.0;
  }
}
