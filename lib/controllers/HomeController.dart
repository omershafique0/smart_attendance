import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:smart_attendance_system/models/attendance_model.dart';
import 'package:smart_attendance_system/models/lecturesModel.dart';
import 'package:smart_attendance_system/utils/net_utils.dart';

import '../utils/FirestorePath.dart';
import '../utils/strings.dart';

class HomeController extends GetxController {
  var loading = false.obs;
  final auth = FirebaseAuth.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  var allLectures = [].obs;

  Future getLectures() async {
    try {
      loading(true);
      database
          .ref()
          .child(FirestorePath.getLectures())
          .onValue
          .listen((event) async {
        if (event.snapshot.value != null) {
          // var data = Map<String, dynamic>.from(event.snapshot.value as Map);
          allLectures.value = (event.snapshot.value as List)
              .map((i) => LecturesModel.fromJson(i))
              .toList();
          allLectures.sort((a, b) => (a.startTime!).compareTo(b.startTime!));
          print(allLectures);
        }
        loading(false);
      });
    } catch (error) {
      print(error);
      loading(false);
    }
    return null;
  }

  // addCategory(
  //     {Presenter? presenter,
  //     String? name,
  //     String? remindValue,
  //     int? reminderNo,
  //     List<DocTypeModel>? addedCategories}) async {
  //   loading(true);
  //   var category = CategoryTypeModel(
  //     categoryName: name,
  //     predefined: false,
  //     remindValue: remindValue,
  //     reminderNo: reminderNo,
  //     creationTime: DateTime.now().millisecondsSinceEpoch.toString(),
  //     docType: addedCategories ?? [],
  //   );
  //   try {
  //     final user = await auth.currentUser;
  //     final uid = user?.uid;
  //     final databaseRef = database
  //         .ref()
  //         .child(FirestorePath.setCategories(uid!))
  //         .push()
  //         .set(category.toJson());
  //     presenter?.onClick(actionOnSuccess);
  //     loading(false);
  //   } on Exception catch (e) {
  //     print(e);
  //     loading(false);
  //   } finally {
  //     loading(false);
  //   }
  // }

  Future markAttendance(Presenter presenter, AttendanceModel? model) async {
    try {
      loading(true);
      await database
          .ref()
          .child(FirestorePath.studentTable(model?.id ?? 0))
          .push()
          .set(model?.toJson());
      presenter.onClick(onSuccess);
    } catch (e) {
      loading(false);
    } finally {
      loading(false);
    }
  }
}
