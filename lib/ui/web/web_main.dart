import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:smart_attendance_system/utils/net_utils.dart';
import 'package:intl/intl.dart';
import '../../controllers/student_controller.dart';

class WebMain extends StatefulWidget {
  const WebMain({Key? key}) : super(key: key);

  @override
  _WebMainState createState() => _WebMainState();
}

class _WebMainState extends State<WebMain> {
  var _controller = Get.put(StudentController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getStudents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Records"),
        centerTitle: true,
      ),
      body: Obx(
        () => ModalProgressHUD(
          inAsyncCall: _controller.loading.value,
          child: _bodyView(),
        ),
      ),
    );
  }

  Widget _bodyView() {
    return Container(
      height: ScreenUtil().screenHeight,
      width: ScreenUtil().screenWidth,
      padding: EdgeInsets.all(5.r),
      child: _studentListView(),
    );
  }

  Widget _studentListView() {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.all(10.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _controller.students[index].records.first.studentName,
              ),
              _recordsListView(index),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return 10.verticalSpace;
      },
      itemCount: _controller.students.length,
    );
  }

  Widget _recordsListView(index) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, i) {
        return Container(
          padding: EdgeInsets.all(10.r),
          color: Colors.grey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Subject: " +
                        _controller.students[index].records[i].subjectName,
                  ),
                  2.verticalSpace,
                  Text(
                    "Instructor: " +
                        _controller.students[index].records[i].teacherName,
                  ),
                ],
              ),
              Text(
                DateFormat('yyyy-MM-dd – kk:mm')
                    .format(timeStampToDate(
                      int.parse(
                          _controller.students[index].records[i].timestamp),
                    ))
                    .toString(),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return 10.verticalSpace;
      },
      itemCount: _controller.students[index].records.length,
    );
  }
}
