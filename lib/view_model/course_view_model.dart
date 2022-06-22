import 'package:flutter/material.dart';

import 'package:uni_mangement_system/utils/db_helper.dart';

class CourseViewModel extends ChangeNotifier {
  String? courseId = '';
  String? courseName = '';
  String? sessionId = '';
  String? classId = '';
  String? semesterId = '';

  var dbhelper = DBHelper.instance;

  CourseViewModel({
    this.courseId,
    this.courseName,
    this.sessionId,
    this.classId,
    this.semesterId,
  });

  factory CourseViewModel.fromMap(Map map) {
    return CourseViewModel(
      courseId: map['courseId'],
      courseName: map['courseName'],
      classId: map['classId'],
      sessionId: map['semesterId'],
      semesterId: map['semesterId'],
    );
  }
  saveData() async {
    String query = "Insert into Course (couserName) values ('$courseName')";
    var id = await dbhelper.rawInsert(query: query);
    notifyListeners();
  }

  updateData() async {
    String query =
        "Update Course set courseName = '$courseName', where cousreId = $courseId ";
    var id = await dbhelper.rawUpdate(query: query);
    notifyListeners();
  }

  deleteData() async {
    String query = "delete from Course where courseId";
    var id = await dbhelper.rawDelete(query: query);
    notifyListeners();
  }

  Future<List<CourseViewModel>> getData() async {
    List<CourseViewModel> courses = [];
    String query = "Select * from Course ";
    var data = await dbhelper.getDataByQuery(query: query);
    courses = data.map((i) => CourseViewModel.fromMap(i)).toList();
    notifyListeners();
    return courses;
  }
}
