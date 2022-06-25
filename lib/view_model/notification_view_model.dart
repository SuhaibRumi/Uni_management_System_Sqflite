import 'package:flutter/material.dart';
import 'package:uni_mangement_system/utils/db_helper.dart';

class NotificationViewModel extends ChangeNotifier {
  String? notificationId = '';
  String? notificationDes = '';
  String? notificationName = '';
  String? sessionName = '';
  String? semesterName = '';
  String? className = '';
  String? sessionId = '';
  String? classId = '';
  String? semesterId = '';

  var dbhelper = DBHelper.instance;

  NotificationViewModel({
    this.notificationId,
    this.notificationName,
    this.notificationDes,
    this.semesterName,
    this.sessionName,
    this.className,
    this.sessionId,
    this.classId,
    this.semesterId,
  });

  factory NotificationViewModel.fromMap(Map map) {
    return NotificationViewModel(
      notificationId: map['notificationId'].toString(),
      notificationName: map['notificationName'],
      notificationDes: map['notificationDes'],
      classId: map['className'],
      sessionId: map['semesterName'],
      semesterId: map['semesterName'],
    );
  }
  saveData() async {
    String query =
        "Insert into Notification (notificationName,notificationDes,classId,semesterId,sessionId) values ('$notificationName','$notificationDes','$semesterId','$sessionId','$classId')";
    var id = await dbhelper.rawInsert(query: query);
    notifyListeners();
  }

  updateData() async {
    String query =
        "Update Notification set notificationId = '$notificationName',notificationDes = '$notificationDes',classId = '$classId',semesterId = '$semesterId',  SessionId ='$sessionId'     where notificationId = $notificationId ";
    var id = await dbhelper.rawUpdate(query: query);
    notifyListeners();
  }

  deleteData() async {
    String query =
        "delete from Notification where notificationId = '$notificationId'";
    var id = await dbhelper.rawDelete(query: query);
    notifyListeners();
  }

  Future<List<NotificationViewModel>> getData() async {
    List<NotificationViewModel> notifications = [];
    String query =
        "Select notificationId ,notificationName,notificationDes,semesterName,sessionName,className from Notification no left join Classes c on c.classId = no.classId  left join Semester sm on sm.semesterId = no.semesterId left join Session ss on ss.sessionId = no.sessionId";
    var data = await dbhelper.getDataByQuery(query: query);
    notifications = data.map((i) => NotificationViewModel.fromMap(i)).toList();
    notifyListeners();
    return notifications;
  }
}
