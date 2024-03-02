import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class PlatformAdmin {

  String getPlatformAdmin() {
    String nombre = "";

    if(isAndroidPlatform()) {
      nombre = "android";
    }
    else if (isIOSPlatform()) {
      nombre = "ios";
    }
    else
      nombre = "web";
    return nombre;
  }

  bool isAndroidPlatform(){
    return defaultTargetPlatform == TargetPlatform.android;
  }

  bool isIOSPlatform(){
    return defaultTargetPlatform == TargetPlatform.iOS;
  }

  bool isWebPlatform(){
    return defaultTargetPlatform != TargetPlatform.android
        && defaultTargetPlatform != TargetPlatform.iOS;
  }
}