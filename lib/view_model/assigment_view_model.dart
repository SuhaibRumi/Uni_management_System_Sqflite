import 'package:flutter/material.dart';

import '../utils/db_helper.dart';

class AssigmentViewModel extends ChangeNotifier {
  String? assignmentId = "";
  String? assignmentNo = "";
  String? sessionId = "";
  String? classId = "";
  String? semesterId = "";

  var dbhelper = DBHelper.instance;

  AssigmentViewModel(
      {this.sessionId,
      this.classId,
      this.semesterId,
      this.assignmentId,
      this.assignmentNo});
  factory AssigmentViewModel.fromMap(Map map) {
    return AssigmentViewModel(
      assignmentId: map['assignmentid'],
      assignmentNo: map['assignmentNo'],
      classId: map['classId'],
      semesterId: map['semesterId'],
      sessionId: map['semesterId'],
    );
  }
  saveData() async {
    String query =
        "Insert into Assignments (assignmentNo) values ('$assignmentNo',)";
    var id = await dbhelper.rawInsert(query: query);
    notifyListeners();
  }

  updateData() async {
    String query =
        "Update Assignments set assignmentNo  = '$assignmentNo', where assignmentId = '$assignmentId'";
    var id = await dbhelper.rawUpdate(query: query);
    notifyListeners();
  }

  deleteData() async {
    String query =
        "delete from Assignments where assignmentId = '$assignmentId'";
    var id = await dbhelper.rawDelete(query: query);
    notifyListeners();
  }

  Future<List<AssigmentViewModel>> getData() async {
    List<AssigmentViewModel> assignments = [];
    String query = "Select * from Assignments";
    var data = await dbhelper.getDataByQuery(query: query);
    assignments = data.map((i) => AssigmentViewModel.fromMap(i)).toList();
    notifyListeners();
    return assignments;
  }
}
