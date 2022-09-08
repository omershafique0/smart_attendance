class LecturesModel {
  int? id;
  String? teacherName;
  int? teacherId;
  String? subjectName;
  String? startTime;
  String? endTime;

  LecturesModel(
      {this.id,
      this.teacherName,
      this.teacherId,
      this.subjectName,
      this.startTime,
      this.endTime});

  LecturesModel.fromJson(dynamic json) {
    id = json['id'];
    teacherName = json['teacher_name'];
    teacherId = json['teacher_id'];
    subjectName = json['subject_name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['teacher_name'] = teacherName;
    data['teacher_id'] = teacherId;
    data['subject_name'] = subjectName;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    return data;
  }
}
