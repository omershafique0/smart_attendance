import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:smart_attendance_system/controllers/HomeController.dart';
import 'package:smart_attendance_system/ui/ScanScreen.dart';
import 'package:smart_attendance_system/utils/net_utils.dart';

class LectureScreen extends StatefulWidget {
  const LectureScreen({Key? key}) : super(key: key);

  @override
  State<LectureScreen> createState() => _LectureScreenState();
}

class _LectureScreenState extends State<LectureScreen> {
  var homeController = Get.put(HomeController());
  int currentHour = DateTime.now().hour;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeController.getLectures();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Lectures"),
        centerTitle: true,
      ),
      body: Obx(
        () => ModalProgressHUD(
            inAsyncCall: homeController.loading.value,
            child: SingleChildScrollView(child: _bodyView())),
      ),
    );
  }

  Widget _bodyView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.r, vertical: 20.r),
      child: _lecturesView(),
    );
  }

  Widget _lecturesView() {
    return ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Get.to(
                  () => ScanScreen(
                        lecturesModel: homeController.allLectures[index],
                      ),
                  transition: Transition.fadeIn);
              // if ((currentHour >=
              //         getTimeSlot(
              //             homeController.allLectures[index].startTime)) &&
              //     (currentHour <
              //         getTimeSlot(homeController.allLectures[index].endTime))) {
              //   // mark attendance
              //   Get.to(() => const ScanScreen(), transition: Transition.fadeIn);
              // } else {
              //   showToastDialog(context, "Lecture time is over.");
              // }
            },
            child: Container(
              padding: EdgeInsets.all(10.r),
              width: ScreenUtil().screenWidth,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          homeController.allLectures[index].subjectName,
                        ),
                        5.verticalSpace,
                        Text(
                          homeController.allLectures[index].teacherName,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(homeController.allLectures[index].startTime +
                          " - " +
                          homeController.allLectures[index].endTime),
                      5.horizontalSpace,
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                        color: Colors.grey,
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.grey,
          );
        },
        itemCount: homeController.allLectures.length);
  }
}
