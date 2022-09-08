import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:smart_attendance_system/models/student_model.dart';

import '../utils/FirestorePath.dart';

class StudentController extends GetxController {
  var loading = false.obs;
  final auth = FirebaseAuth.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  var students = [].obs;

  Future getStudents() async {
    try {
      loading(true);
      database
          .ref()
          .child(FirestorePath.getStudents())
          .onValue
          .listen((event) async {
        if (event.snapshot.value != null) {
          // var data = Map<String, dynamic>.from(event.snapshot.value as Map);

          students.value = (event.snapshot.value as List)
              .map((i) => StudentModel.fromJson(i))
              .toList();
          // allRecords.sort((a, b) => (a.startTime!).compareTo(b.startTime!));
          print(students);
        }
        loading(false);
      });
    } catch (error) {
      print(error);
      loading(false);
    }
    return null;
  }
}
