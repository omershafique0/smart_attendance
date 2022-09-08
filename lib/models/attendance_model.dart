class AttendanceModel {
  int? id;
  String? studentName;
  int? teacherId;
  String? teacherName;
  String? subjectName;
  dynamic timestamp;

  AttendanceModel(
      {this.id,
      this.studentName,
      this.teacherId,
      this.teacherName,
      this.subjectName,
      this.timestamp});

  AttendanceModel.fromJson(dynamic json) {
    id = json['id'];
    studentName = json['student_name'];
    teacherId = json['teacher_id'];
    teacherName = json['teacher_name'];
    subjectName = json['subject_name'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['student_name'] = this.studentName;
    data['teacher_id'] = this.teacherId;
    data['teacher_name'] = this.teacherName;
    data['subject_name'] = this.subjectName;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
