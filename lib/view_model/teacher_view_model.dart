import 'package:flutter/material.dart';
import 'package:uni_mangement_system/utils/db_helper.dart';

class TeacherViewModel extends ChangeNotifier {
  String? teacherId;
  String? teacherName;
  String? teacherEmail;
  String? teacherPassword;
  String? teacherDepartment;

  var dbhelper = DBHelper.instance;
  TeacherViewModel({
    this.teacherId,
    this.teacherName,
    this.teacherEmail,
    this.teacherPassword,
    this.teacherDepartment,
  });
  
  factory TeacherViewModel.fromMap(Map map) {
    return TeacherViewModel(
      teacherId: map['teacherId'],
      teacherName: map['teacherName'],
      teacherEmail: map['teacherEmail'],
      teacherPassword: map['teacherPassword'],
      teacherDepartment: map['teacherDepartment'],
    );
 
  }


  saveData() async {
    String query = "Insert into Teacher (teacherName,teacherEmail,teacherPassword,teacherDepartment) values ('$teacherName','$teacherEmail','$teacherPassword','$teacherDepartment')";
    var id = await dbhelper.rawInsert(query: query);
    notifyListeners();
  }

  updateData() async {
    String query = "Update Teacher set teacherName = '$teacherName',teacherEmail ='$teacherEmail', teacherPassword='$teacherPassword',teacherDepartment='$teacherDepartment'  where teacherId = $teacherId "  ;
    var id = await dbhelper.rawUpdate(query: query);
    notifyListeners();
  }

  deleteData() async {
    String query = "delete from Teacher where teacherId = '$teacherId'";
    var id = await dbhelper.rawDelete(query: query);
    notifyListeners();
  }

  Future<List<TeacherViewModel>> getData() async {
    List<TeacherViewModel> teachers = [];
    String query = "Select * from Teacher ";
    var data = await dbhelper.getDataByQuery(query: query);
    teachers = data.map((i) => TeacherViewModel.fromMap(i)).toList();
    notifyListeners();
    return teachers;
  }

}
