import 'package:flutter/material.dart';

import '../utils/db_helper.dart';

class StudentsViewModel extends ChangeNotifier {
  String? studId;
  String? classId;
  String? sessionId;
  String? semesterId;
  String? studentName = '';
  String? studRoll = '';
  String? className = '';
  String? sessionName = '';
  String? semesterName = '';
  bool? isActive = true;

  var dbhelper = DBHelper.instance;
  StudentsViewModel({
    this.studId,
    this.studentName,
    this.studRoll,
    this.className,
    this.sessionName,
    this.semesterName,
    this.classId,
    this.semesterId,
    this.sessionId,
    this.isActive,
  });

  factory StudentsViewModel.fromMap(Map map) {
    bool active = false;
    if (map['isActive'] == 1 || map['isActive'] == true) {
      active = true;
    }
    return StudentsViewModel(
        studId: map['studId'].toString(),
        studentName: map['studentName'],
        studRoll: map['studRoll'],
        sessionName: map['sessionName'],
        className: map['className'],
        semesterName: map['semesterName'],
        isActive: active);
  }
  saveData() async {
    String query =
        "insert into Students (studentName,studRoll,isActive,sessionId,classId,semesterId) values('$studentName','$studRoll','$isActive','$sessionId','$classId','$semesterId' )";
    var id = await dbhelper.rawInsert(query: query);

    notifyListeners();
  }

  updateData() async {
    String query =
        "Update Students set studentName = '$studentName', studRoll = '$studRoll',isActive ='$isActive', sessionName = '$sessionName', className = '$className', semesterName = '$semesterName' where studId = '$studId'";
    var id = await dbhelper.rawUpdate(query: query);
    notifyListeners();
  }

  deletData() async {
    String query = "delete from Students where studId  = '$studId' ";
    var id = await dbhelper.rawDelete(query: query);
    notifyListeners();
  }

  Future<List<StudentsViewModel>> getData() async {
    List<StudentsViewModel> students = [];
    String query =
        " Select studId, studentName,studRoll, isActive, semesterName, sessionName, className from Students s left join Classes c on c.classId = s.classId left join Semester sm on sm.semesterId = s.semesterId left join Session ss on ss.sessionId = s.sessionId";
    var data = await dbhelper.getDataByQuery(query: query);
    students = data.map((i) => StudentsViewModel.fromMap(i)).toList();
    notifyListeners();
    return students;
  }
}
