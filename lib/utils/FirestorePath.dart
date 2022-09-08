class FirestorePath {
  static String getLectures() => '/lectures';
  static String getStudents() => '/students';
  static String studentTable(int id) => '/students/$id/records';
}
