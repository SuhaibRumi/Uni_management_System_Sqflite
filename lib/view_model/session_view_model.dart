import 'package:flutter/material.dart';
import 'package:uni_mangement_system/utils/db_helper.dart';

class SessionViewModel extends ChangeNotifier {
  int? sessionId;
  String? sessionName = '';

  var dbHelper = DBHelper.instance;

  SessionViewModel({
    this.sessionId,
    this.sessionName,
  });

  factory SessionViewModel.fromMap(Map map) {
    return SessionViewModel(
      sessionId: map['sessionId'],
      sessionName: map['sessionName'],
    );
  }
  saveData() async {
    String query = "Insert into Session (sessionName) values('$sessionName')";
    var id = await dbHelper.rawInsert(query: query);
    notifyListeners();
  }

  getSessionId() async {
    String query = "Select * from Session where sessionName = '$sessionName'";
    List<SessionViewModel> sessions = [];
    var data = await dbHelper.getDataByQuery(query: query);
   
    sessions = data.map((i) => SessionViewModel.fromMap(i)).toList();
    notifyListeners();
    return sessions[0].sessionId;
  }

  updateData() async {
    String query =
        "Update Session set sessionName = '$sessionName' where sessionId = '$sessionId'";
    var id = await dbHelper.rawUpdate(query: query);
    notifyListeners();
  }

  deleteData() async {
    String query = "delete from Session where sessionId = '$sessionId'";
    var id = await dbHelper.rawDelete(query: query);
    notifyListeners();
  }

  Future<List<SessionViewModel>> getData() async {
    List<SessionViewModel> sessions = [];
    String query = "Select * from Session";
    var data = await dbHelper.getDataByQuery(query: query);
    sessions = data.map((i) => SessionViewModel.fromMap(i)).toList();
    notifyListeners();
    return sessions;
  }
}
