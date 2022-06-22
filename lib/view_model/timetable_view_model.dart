import 'package:flutter/cupertino.dart';
import 'package:uni_mangement_system/utils/db_helper.dart';

class TimeTableViewModel extends  ChangeNotifier {
  String? timeTableId;
  String? timeTableDesc;
  String? sessionId;
  String? classId;
  String? semesterId;

  var dbhelper = DBHelper.instance;

  TimeTableViewModel({
    this.timeTableId,
    this.timeTableDesc,
    this.sessionId,
    this.classId,
    this.semesterId,
  });

  factory TimeTableViewModel.fromMap(Map map) {
    return TimeTableViewModel(
      timeTableId: map['timeTableId'],
      timeTableDesc: map['timeTableDesc'],
      classId: map['classId'],
      sessionId: map['semesterId'],
      semesterId: map['semesterId'],
    );
  }
  saveData() async {
    String query = "Insert into TimeTable (timeTableDesc) values ('$timeTableDesc')";
    var id = await dbhelper.rawInsert(query: query);
    notifyListeners();
  }

  updateData() async {
    String query = "Update TimeTable set timeTableDesc = '$timeTableDesc', where timeTableId = $timeTableId "  ;
    var id = await dbhelper.rawUpdate(query: query);
    notifyListeners();
  }

  deleteData() async {
    String query = "delete from TimeTable where timeTableId = '$timeTableId'";
    var id = await dbhelper.rawDelete(query: query);
    notifyListeners();
  }

  Future<List<TimeTableViewModel>> getData() async {
    List<TimeTableViewModel> timeTable = [];
    String query = "Select * from TimeTable ";
    var data = await dbhelper.getDataByQuery(query: query);
    timeTable = data.map((i) => TimeTableViewModel.fromMap(i)).toList();
    notifyListeners();
    return timeTable;
  }
}
