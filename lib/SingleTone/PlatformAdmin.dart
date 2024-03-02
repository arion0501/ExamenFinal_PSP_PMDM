import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class PlatformAdmin {

  double dSCREEN_WIDTH=0;
  double dSCREEN_HEIGHT=0;
  late BuildContext context;

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

  double getScreenWidth(BuildContext context){
    dSCREEN_WIDTH=MediaQuery.of(context).size.width;
    return dSCREEN_WIDTH;
  }

  double getScreenHeight(BuildContext context){
    dSCREEN_HEIGHT=MediaQuery.of(context).size.height;
    return dSCREEN_HEIGHT;
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