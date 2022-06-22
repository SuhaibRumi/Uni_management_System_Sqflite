import 'package:flutter/material.dart';
import 'package:uni_mangement_system/utils/db_helper.dart';

class QuizViewModel extends ChangeNotifier {
  String? quizId;
  String? quizNo;
  String? sessionId;
  String? classId;
  String? semesterId;

  var dbhelper = DBHelper.instance;
  QuizViewModel({
    this.quizId,
    this.quizNo,
    this.sessionId,
    this.classId,
    this.semesterId,
  });

  factory QuizViewModel.fromMap(Map map) {
    return QuizViewModel(
      quizId: map['quizId'],
      quizNo: map['quizNo'],
      classId: map['classId'],
      sessionId: map['semesterId'],
      semesterId: map['semesterId'],
    );
  }
  saveData() async {
    String query =
        "Insert into Quiz (quizNo) values ('$quizNo',)";
    var id = await dbhelper.rawInsert(query: query);
    notifyListeners();
  }

  updateData() async {
    String query =
        "Update Quiz set quizNo  = '$quizNo', where quizId = '$quizId'";
    var id = await dbhelper.rawUpdate(query: query);
    notifyListeners();
  }

  deleteData() async {
    String query =
        "delete from Quiz where quizId = '$quizId'";
    var id = await dbhelper.rawDelete(query: query);
    notifyListeners();
  }

  Future<List<QuizViewModel>> getData() async {
    List<QuizViewModel> quiz = [];
    String query = "Select * from Quiz";
    var data = await dbhelper.getDataByQuery(query: query);
    quiz = data.map((i) => QuizViewModel.fromMap(i)).toList();
    notifyListeners();
    return quiz;
  }
}
