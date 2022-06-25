import 'package:flutter/material.dart';
import 'package:uni_mangement_system/utils/db_helper.dart';

class QuizViewModel extends ChangeNotifier {
  String? quizId = '';
  String? quizNo = '';
  String? sessionId = '';
  String? classId = '';
  String? semesterId = '';
  String? sessionName = '';
  String? semesterName = '';
  String? className = '';

  var dbhelper = DBHelper.instance;
  QuizViewModel({
    this.quizId,
    this.quizNo,
    this.sessionId,
    this.classId,
    this.semesterId,
    this.className,
    this.semesterName,
    this.sessionName,
  });

  factory QuizViewModel.fromMap(Map map) {
    return QuizViewModel(
      quizId: map['quizId'],
      quizNo: map['quizNo'],
      classId: map['className'],
      sessionId: map['semesterName'],
      semesterId: map['sessionName'],
    );
  }
  saveData() async {
    String query =
        "Insert into Quiz (quizNo,classId,semesterId,sessionId) values ('$quizNo','$classId','$semesterId','$sessionId')";
    var id = await dbhelper.rawInsert(query: query);
    notifyListeners();
  }

  updateData() async {
    String query =
        "Update Quiz set quizNo = '$quizNo', classId = '$classId',semesterId = '$semesterId' ,sessionId '$sessionId' where quizId = '$quizId'";
    var id = await dbhelper.rawUpdate(query: query);
    notifyListeners();
  }

  deleteData() async {
    String query = "delete from Quiz where quizId = '$quizId'";
    var id = await dbhelper.rawDelete(query: query);
    notifyListeners();
  }

  Future<List<QuizViewModel>> getData() async {
    List<QuizViewModel> quiz = [];
    String query =
        "Select quizId ,quizNo,semesterName, sessionName, className from Quiz co left join Classes c on c.classId = q.classId  left join Semester sm on sm.semesterId = q.semesterId left join Session ss on ss.sessionId = q.sessionId";
    var data = await dbhelper.getDataByQuery(query: query);
    quiz = data.map((i) => QuizViewModel.fromMap(i)).toList();
    notifyListeners();
    return quiz;
  }
}
