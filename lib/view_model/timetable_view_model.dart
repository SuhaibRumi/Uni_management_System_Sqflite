import 'package:flutter/cupertino.dart';
import 'package:uni_mangement_system/utils/db_helper.dart';

class TimeTableViewModel extends ChangeNotifier {
  String? timeTableId = '';
  String? timeTableDesc = '';
  String? sessionId = '';
  String? classId = '';
  String? semesterId = '';
  String? sessionName = '';
  String? semesterName = '';
  String? className = '';

  var dbhelper = DBHelper.instance;

  TimeTableViewModel({
    this.timeTableId,
    this.timeTableDesc,
    this.sessionId,
    this.classId,
    this.semesterId,
    this.className,
    this.semesterName,
    this.sessionName,
  });

  factory TimeTableViewModel.fromMap(Map map) {
    return TimeTableViewModel(
      timeTableId: map['timeTableId'],
      timeTableDesc: map['timeTableDesc'],
      classId: map['className'],
      sessionId: map['sessionName'],
      semesterId: map['semesterName'],
    );
  }
  saveData() async {
    String query =
        "Insert into TimeTable (timeTableDesc,classId,semesterId,sessionId) values ('$timeTableDesc','$classId','$semesterId','$sessionId')";
    var id = await dbhelper.rawInsert(query: query);
    notifyListeners();
  }

  updateData() async {
    String query =
        "Update TimeTable set timeTableDesc = '$timeTableDesc', classId = '$classId,'semesterId = '$semesterId', sessionId= '$sessionId ' where timeTableId = $timeTableId ";
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
    String query =
        "Select timeTableId ,timeTableDesc,semesterName, sessionName, className from TimeTable tt left join Classes c on c.classId = tt.classId  left join Semester sm on sm.semesterId = tt.semesterId left join Session ss on ss.sessionId = tt.sessionId";
    var data = await dbhelper.getDataByQuery(query: query);
    timeTable = data.map((i) => TimeTableViewModel.fromMap(i)).toList();
    notifyListeners();
    return timeTable;
  }
}
