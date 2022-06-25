import 'package:flutter/material.dart';

import 'package:uni_mangement_system/utils/db_helper.dart';

class CourseViewModel extends ChangeNotifier {
  String? courseId = '';
  String? classId = '';
  String? sessionId = '';
  String? semesterId = '';
  String? courseName = '';
  String? className = '';
  String? sessionName = '';
  String? semesterName = '';

  var dbhelper = DBHelper.instance;
  CourseViewModel({
    this.courseId,
    this.courseName,
    this.className,
    this.sessionName,
    this.semesterName,
    this.classId,
    this.semesterId,
    this.sessionId,
  });

  factory CourseViewModel.fromMap(Map map) {
    return CourseViewModel(
      courseId: map['courseId'].toString(),
      courseName: map['courseName'],
      className: map['className'],
      sessionName: map['semesterName'],
      semesterName: map['semesterName'],
    );
  }
  saveData() async {
    String query =
        "Insert into Course (courseName,sessionId,classId,semesterId) values('$courseName','$sessionId','$classId','$semesterId' )";
    var id = await dbhelper.rawInsert(query: query);

    notifyListeners();
  }

  updateData() async {
    String query =
        "Update Course set courseName = '$courseName', sessionId = '$sessionId',classId ='$classId', semesterId='$semesterId' where courseId = '$courseId'";
    var id = await dbhelper.rawUpdate(query: query);
    print(id);
    notifyListeners();
  }

  deleteData() async {
    String query = "delete from Course where courseId = '$courseId'";
    var id = await dbhelper.rawDelete(query: query);
    notifyListeners();
  }

  deleteAllData() async {
    await dbhelper.rawDelete(query: '$courseId');
  }

  Future<List<CourseViewModel>> getData() async {
    List<CourseViewModel> courses = [];
    String query =
 "Select courseId ,courseName,semesterName, sessionName, className from Course co left join Classes c on c.classId = co.classId  left join Semester sm on sm.semesterId = co.semesterId left join Session ss on ss.sessionId = co.sessionId";
    var data = await dbhelper.getDataByQuery(query: query);
    courses = data.map((i) => CourseViewModel.fromMap(i)).toList();
    notifyListeners();
    return courses;
  }
}
