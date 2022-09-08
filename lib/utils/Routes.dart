import 'package:flutter/material.dart';
import 'package:smart_attendance_system/ui/LectureScreen.dart';
import 'package:smart_attendance_system/ui/ScanScreen.dart';

import '../ui/Homescreen.dart';
import '../ui/LoginScreen.dart';

class Routes {
  // Route name constants
  static const String login = '/login';
  static const String scan = '/scanscreen';
  static const String home = '/homescreen';
  static const String lectures = '/letcturecreen';

  /// The map used to define our routes, needs to be supplied to [MaterialApp]
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      Routes.login: (context) => const LoginScreen(),
      Routes.scan: (context) => ScanScreen(),
      Routes.home: (context) => const HomeScreen(),
      Routes.lectures: (context) => const LectureScreen(),
    };
  }
}
