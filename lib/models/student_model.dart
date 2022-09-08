import 'package:smart_attendance_system/models/attendance_model.dart';

class StudentModel {
  List<AttendanceModel>? records = [];

  StudentModel({
    this.records,
  });

  StudentModel.fromJson(dynamic json) {
    var data = Map<String, dynamic>.from(json['records'] as Map);
    data.forEach((key, value) async {
      final rec = AttendanceModel.fromJson(value);
      records?.add(rec);
    });

    print(records);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['records'] = records;

    return data;
  }
}
