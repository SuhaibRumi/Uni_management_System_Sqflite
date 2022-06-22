import 'package:flutter/material.dart';
import 'package:uni_mangement_system/utils/db_helper.dart';


class NotificationViewModel extends ChangeNotifier {
  String? notificationId = '';
  String? notificationDes = '';
  String? notificationName = '';
  String? sessionId = '';
  String? classId = '';
  String? semesterId = '';

  var dbhelper = DBHelper.instance;

  NotificationViewModel({
    this.notificationId,
    this.notificationName,
    this.notificationDes,
    this.sessionId,
    this.classId,
    this.semesterId,
  });

  factory NotificationViewModel.fromMap(Map map) {
    return NotificationViewModel(
      notificationId: map['notificationId'],
      notificationName: map['notificationName'],
      notificationDes: map['notificationDes'],
      classId: map['classId'],
      sessionId: map['semesterId'],
      semesterId: map['semesterId'],
    );
  }
  saveData() async {
    String query = "Insert into Notification (notificationName,notificationDes) values ('$notificationName','$notificationDes')";
    var id = await dbhelper.rawInsert(query: query);
    notifyListeners();
  }

  updateData() async {
    String query = "Update Notification set notificationName = '$notificationName',notificationDes = '$notificationDes', where notificationId = $notificationId "  ;
    var id = await dbhelper.rawUpdate(query: query);
    notifyListeners();
  }

  deleteData() async {
    String query = "delete from Notification where notificationId = '$notificationId'";
    var id = await dbhelper.rawDelete(query: query);
    notifyListeners();
  }

  Future<List<NotificationViewModel>> getData() async {
    List<NotificationViewModel> notifications = [];
    String query = "Select * from Notification ";
    var data = await dbhelper.getDataByQuery(query: query);
    notifications = data.map((i) => NotificationViewModel.fromMap(i)).toList();
    notifyListeners();
    return notifications;
  }
}
