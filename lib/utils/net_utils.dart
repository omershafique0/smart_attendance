import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'sp_utils.dart';

SpUtil? spUtil;
// CloudFunctions? cloudFunctions;
init() async {
  spUtil = await SpUtil.getInstance();
  // cloudFunctions = CloudFunctions.instance;
  // firebaseCloudMessaging_Listeners();
}

abstract class Presenter {
  void onClick(String action);
}

abstract class PresenterWithValue {
  void onClickWithValue(String action, dynamic value);
}

// getTimeZone() async {
//   final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
//   return currentTimeZone;
// }

hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);

  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

getTimeSlot(String time) {
  int hours = int.parse(time.split(":")[0]);
  int mins = int.parse(time.split(":")[1]);
  return hours;
  // int gmt = DateTime.now().timeZoneOffset.inHours;
  // hours = hours + gmt;
  // return DateFormat.jm().format(
  //     DateFormat("hh:mm").parse("${hours.toString()}:${mins.toString()}"));
}

bool checkEmail(String em) {
  String p =
      r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$";
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(em);
}

// int getNoOfDays(String type) {
//     int day = 0;
//     switch (type) {
//       case "Days":
//         day = 1;
//         break;
//       case "Weeks":
//         day = 7;
//         break;
//       case "Months":
//         day = 30;
//         break;
//       case "Quarters":
//         day = 90;
//         break;
//       case "Years":
//         day = 365;
//         break;
//     }
//     return day;
//   }

// Future<File> getImageFileFromAssets(String path) async {
//   final byteData = await rootBundle.load('$path');
//   final file = File('${(await getTemporaryDirectory()).path}/$path');
//   await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
//   return file;
// }

// Future<void> launchUrl(String url) async {
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

// spInit(BuildContext context) {
//   ScreenUtil.init(
//     context,
//     designSize: const Size(750, 1334),
//     minTextAdapt: true,
//     // orientation: Orientation.portrait,
//   );
// }

void logout() {
  // Timer.periodic(const Duration(seconds: 1), (time) {
  //   spUtil!.remove(keyUser);
  //   spUtil!.remove(keyToken);
  //   time.cancel();

  //   Get.offAll(() => HomeScreen());
  // });
}

timeStampToDate(int timeStamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timeStamp);
  return date;
}

void showErrorAlert(BuildContext context, String? errorMsg) {
  showAlert(context, null,
      onlyPositive: true, positiveText: "OK", title: errorMsg);
}

Future<bool?> showAlert(BuildContext context, Presenter? presenter,
        {String? title,
        String? subTitle = "",
        String negativeText = "Cancel",
        String positiveText = "Ok",
        bool onlyPositive = true,
        String negativeAction = "",
        String positiveAction = "",
        IconData? icon,
        bool showIcon = false}) =>
    _showAlert<bool>(
        context: context,
        child: Theme(
          data: ThemeData.dark(),
          child: CupertinoAlertDialog(
            title: (showIcon)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        icon,
                        size: 50,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Text(
                          title!,
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  )
                : Column(
                    children: [
                      Text(
                        title!,
                        style: TextStyle(fontSize: 16),
                      ),
                      Visibility(
                          visible: subTitle!.isNotEmpty,
                          child: Column(
                            children: [
                              spacerView(context, h: 10),
                              Text(
                                subTitle,
                                // style: Style_18_Bold_Primary,
                              )
                            ],
                          ))
                    ],
                  ),
            actions: _buildAlertActions(context, onlyPositive, negativeText,
                positiveText, presenter, negativeAction, positiveAction),
          ),
        ));

List<Widget> _buildAlertActions(
  BuildContext context,
  bool onlyPositive,
  String negativeText,
  String positiveText,
  Presenter? presenter,
  String negativeAction,
  String positiveAction,
) {
  if (onlyPositive) {
    return [
      CupertinoDialogAction(
        child: Text(
          "Ok",
          // style: TextStyle(fontSize: font_top_title, color: color_blue_dark),
        ),
        isDefaultAction: true,
        onPressed: () {
          // Navigator.pop(context, false);
          Navigator.of(context, rootNavigator: true).pop();
          if (presenter != null) presenter.onClick(positiveAction);
        },
      ),
    ];
  } else {
    return [
      CupertinoDialogAction(
        child: Text(
          "Cancel",
          // style: TextStyle(fontSize: font_top_title, color: color_blue_dark),
        ),
        isDefaultAction: true,
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
          presenter!.onClick(negativeAction);
        },
      ),
      CupertinoDialogAction(
        child: Text(
          positiveText,
          // style: TextStyle(fontSize: font_top_title, color: color_blue_dark),
        ),
        isDefaultAction: true,
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
          presenter!.onClick(positiveAction);
        },
      ),
    ];
  }
}

Future<T?> _showAlert<T>({required BuildContext context, Widget? child}) =>
    showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => child!,
    );
Widget spacerView(BuildContext context, {double? h, double? w, Color? color}) {
  return Container(
    height: h ?? 0,
    width: w ?? 0,
    color: color,
  );
}

Future<bool?> showToastDialog(BuildContext context, String title,
    {int timeSec = 2}) async {
  _showAlert<bool>(
    context: context,
    child: CupertinoAlertDialog(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w400)),
    ),
  );
  Timer.periodic(Duration(seconds: timeSec), (time) {
    Navigator.of(context, rootNavigator: true).pop();
    time.cancel();
  });
}

// Future<BitmapDescriptor> getBitmapDescriptorFromSVGAsset(
//   BuildContext context,
//   String svgAssetLink, {
//   Size size = const Size(50, 50),
// }) async {
//   String svgString = await DefaultAssetBundle.of(context).loadString(
//     svgAssetLink,
//   );
//   final drawableRoot = await svg.fromSvgString(
//     svgString,
//     'debug: $svgAssetLink',
//   );
//   final ratio = ui.window.devicePixelRatio.ceil();
//   final width = size.width.ceil() * ratio;
//   final height = size.height.ceil() * ratio;
//   final picture = drawableRoot.toPicture(
//     colorFilter: ColorFilter.mode(
//         Colors.red, ui.BlendMode.colorBurn), //TODO: Remove this
//     size: Size(
//       width.toDouble(),
//       height.toDouble(),
//     ),
//   );
//   final image = await picture.toImage(width, height);
//   final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//   final uInt8List = await byteData?.buffer.asUint8List();
//   return await BitmapDescriptor.fromBytes(uInt8List!);
// }

getAppBarHeight(BuildContext context) {
  return 50.0 + MediaQuery.of(context).padding.top;
}

////////////////////// FCM Token ////////////////////////////
// FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
// FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
// }

// // ignore: non_constant_identifier_names
// Future<File?> firebaseCloudMessaging_Listeners() async {
//   // if (Platform.isIOS) iOS_Permission();
//   if (Platform.isIOS) {
//     // Permissions();
//     await _firebaseMessaging.requestPermission(
//         announcement: true,
//         carPlay: true,
//         criticalAlert: true,
//         sound: true,
//         badge: true,
//         alert: true,
//         provisional: false);
//   }

//   await _firebaseMessaging.getToken().then((token) {
//     print("=====================================================");
//     print("=======================FCM Token=====================");
//     print("=====================================================");
//     print("FCM_Token: " + token!);
//     print("=====================================================");
//     spUtil!.putString(keyFCM, token);
//   });

//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   /// Update the iOS foreground notification presentation options to allow
//   /// heads up notifications.
//   await _firebaseMessaging.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );

//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     print("Message" + message.toString());

//     showNotification(message);
//   });

//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     print(message);
//   });
//   return null;
// }

// void showNotification(message) async {
//   var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
//       "Smart Reminder", 'Smart Reminder',
//       channelDescription: 'Smart Reminder',
//       playSound: true,
//       enableVibration: true,
//       importance: Importance.max,
//       priority: Priority.high,
//       icon: '@mipmap/ic_launcher');
//   var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
//   var platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics);

//   await flutterLocalNotificationsPlugin!.show(
//     2,
//     message['notification']['title'].toString(),
//     message['notification']['body'].toString(),
//     platformChannelSpecifics,
//     payload: '@mipmap/ic_launcher',
//   );
// }

// void configLocalNotification() {
//   var initializationSettingsAndroid =
//       const AndroidInitializationSettings("@mipmap/ic_launcher");
//   var initializationSettingsIOS = const IOSInitializationSettings(
//     requestAlertPermission: true,
//     requestBadgePermission: true,
//     requestSoundPermission: true,
//   );
//   var initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//   flutterLocalNotificationsPlugin?.initialize(initializationSettings);
// }





////////////////////// FCM Token ////////////////////////////
// FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
// FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
// }

// // ignore: non_constant_identifier_names
// Future<File?> firebaseCloudMessaging_Listeners() async {
//   // if (Platform.isIOS) iOS_Permission();
//   if (Platform.isIOS) {
//     // Permissions();
//     await _firebaseMessaging.requestPermission(
//         announcement: true,
//         carPlay: true,
//         criticalAlert: true,
//         sound: true,
//         badge: true,
//         alert: true,
//         provisional: false);
//   }

//   // ignore: unused_local_variable
//   // final DioClient _dioClient = DioClient(Dio());

//   await _firebaseMessaging.getToken().then((token) async {
//     print("FCM_Token: " + token!);
//     spUtil?.putString(keyFCM, token.toString());
//     // spUtil!.putString(Preferences.KEY_FCM, token);
//     // if (spUtil?.getString(Preferences.user_token) != null) {
//     //   ApiHandler().sendFCMToken();
//     // }
//   });

  

//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   /// Update the iOS foreground notification presentation options to allow
//   /// heads up notifications.
//   await _firebaseMessaging.setForegroundNotificationPresentationOptions(
//     alert: false,
//     badge: true,
//     sound: true,
//   );

//   // RemoteMessage? initialMessage =
//   //     await FirebaseMessaging.instance.getInitialMessage();
//   // if (initialMessage != null) {
//   //   _handleMessage(initialMessage);
//   // }

//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     print("Message" + message.toString());
//     showNotification(message);
//     print(message);
//   });

//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     // FlutterAppBadger.removeBadge();
//     print("A new onMessageOpenedApp event was published!");
//   });
// }

// void configLocalNotification() {
//   var initializationSettingsAndroid =
//       new AndroidInitializationSettings("@mipmap/ic_launcher");
//   var initializationSettingsIOS = new IOSInitializationSettings(
//     requestAlertPermission: true,
//     requestBadgePermission: true,
//     requestSoundPermission: true,
//   );
//   var initializationSettings = new InitializationSettings(
//     android: initializationSettingsAndroid,
//     iOS: initializationSettingsIOS,
//   );
//   flutterLocalNotificationsPlugin?.initialize(initializationSettings);
// }


// void showNotification(message) async {
//   var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
//       "Smart Reminder", 'Smart Reminder',
//       channelDescription: 'Smart Reminder',
//       playSound: true,
//       enableVibration: true,
//       importance: Importance.max,
//       priority: Priority.high,
//       icon: '@mipmap/ic_launcher');
//   var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
//   var platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics);

//   RemoteNotification notification = message.notification;
//   await flutterLocalNotificationsPlugin!.show(
//     2,
//     notification.title,
//     notification.body,
//     platformChannelSpecifics,
//     payload: '@mipmap/ic_launcher',
//   );
// }


// void showNotification(message) async {
//   final sound = "notification.wav";
//   var androidDefaultPlatformSpecific;
//   var androidCustomPlatformSpecific;
//   var iosDefulatPlatformSpecific;
//   var iosCustomPlatformSpecific;

//   androidDefaultPlatformSpecific = new AndroidNotificationDetails(
//       "BBM Business Default", 'BBM Business Default',
//       playSound: true,
//       enableVibration: true,
//       importance: Importance.max,
//       priority: Priority.high,
//       icon: '@mipmap/ic_notification');

//   androidCustomPlatformSpecific = new AndroidNotificationDetails(
//       "BBM Business Custom", 'BBM Business Custom',
//       sound: RawResourceAndroidNotificationSound(sound.split(".").first),
//       playSound: true,
//       enableVibration: true,
//       importance: Importance.max,
//       priority: Priority.high,
//       icon: '@mipmap/ic_notification');

//   iosCustomPlatformSpecific = new IOSNotificationDetails(sound: sound);
//   iosDefulatPlatformSpecific = new IOSNotificationDetails();
//   var platformChannelSpecifics = new NotificationDetails(
//       android: (message.data['type'] == 'new_order' ||
//               message.data['type'] == 'new_order_request')
//           ? androidCustomPlatformSpecific
//           : androidDefaultPlatformSpecific,
//       iOS: (message.data['type'] == 'new_order' ||
//               message.data['type'] == 'new_order_request')
//           ? iosCustomPlatformSpecific
//           : iosDefulatPlatformSpecific);

//   RemoteNotification notification = message.notification;

//   await flutterLocalNotificationsPlugin?.show(
//     2,
//     notification.title,
//     notification.body,
//     platformChannelSpecifics,
//     payload: '@mipmap/ic_launcher',
//   );
// }




// readTimestamp(creationTime) {
//   var timestamp = creationTime;
//   var now = DateTime.now();
//   var format = DateFormat('HH:mm a');
//   var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
//   var diff = now.difference(date);
//   var time = '';
//   return date;
// }

// ageFromDOB(String dateOfBirth) {
//   DateTime dob = DateFormat('MM/dd/yyyy').parse(dateOfBirth);
//   Duration age = DateTime.now().difference(dob);
//   return (age.inDays / 365).floor();
// }