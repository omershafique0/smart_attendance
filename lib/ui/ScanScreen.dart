import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:smart_attendance_system/models/attendance_model.dart';
import 'package:smart_attendance_system/utils/net_utils.dart';
import 'package:smart_attendance_system/utils/strings.dart';

import '../controllers/HomeController.dart';
import '../models/lecturesModel.dart';

class ScanScreen extends StatefulWidget {
  LecturesModel? lecturesModel;
  ScanScreen({Key? key, this.lecturesModel}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> implements Presenter {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var homeController = Get.put(HomeController());
  Barcode? result;

  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: homeController.loading.value,
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: (result != null)
                      ? Text(
                          'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                      : Text('Scan a code'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    StreamSubscription? subscription;
    subscription = controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if (result != null) {
        subscription?.cancel();
        var data = result?.code?.split(",");
        int studentId = int.parse(data![0].split(":")[1]);
        String studentName = data[1].split(":")[1];
        AttendanceModel attendanceModel = AttendanceModel(
            id: studentId,
            studentName: studentName,
            teacherId: widget.lecturesModel?.teacherId,
            teacherName: widget.lecturesModel?.teacherName,
            subjectName: widget.lecturesModel?.subjectName,
            timestamp: DateTime.now().millisecondsSinceEpoch.toString());
        homeController.markAttendance(this, attendanceModel);
      }
      // subscription?.cancel();
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void onClick(String action) {
    switch (action) {
      case onSuccess:
        showToastDialog(context, "Attendance marked successfully");
        Future.delayed(const Duration(seconds: 2), () {
          Get.back();
        });
        break;
    }
  }
}
