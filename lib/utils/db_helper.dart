import 'dart:io';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Database? _db;
  final dbName = 'UniMangementSystem ';

  Future<Database> get db async {
    if (_db == null) {
      return await initDB();
    }
    return _db!;
  }

  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, dbName);
    return await openDatabase(path, version: 2, onCreate: _onCreateDB);
  }

  FutureOr<void> _onCreateDB(Database db, int version) async {
    await db.execute('''
     create Table `Classes`(
     classId Integer primary key autoincrement,
     className text
     );
''');

    await db.execute('''
    create Table `Semester`(
      semesterId Integer primary key autoincrement,
      semesterName text
     );
    ''');

    await db.execute('''
      create Table `Session`(
      sessionId Integer primary key autoincrement,
      sessionName text
    );
      ''');
    await db.execute('''
  create Table `Assignments`(
   assignmentId Integer primary key autoincrement,
   assignmentNo text, 
   semesterId Integer,
   sessionId Integer,
   classId Integer
  
);
''');

    await db.execute('''
   create Table `Students`(
   studId Integer primary key autoincrement,
   semesterId Integer,
   sessionId Integer,
   classId Integer,
   studRoll text,  
   studentName text,
   isActive boolean default true
);
''');

    await db.execute('''
    create Table `Course`(

      courseId Integer primary key autoincrement,
      courseName text, 
      semesterId Integer,
      sessionId Integer,
      classId Integer

      );
''');
    await db.execute('''
    create Table `Notification`
      (

    notificationId Integer primary key autoincrement,
    notificationName text,
    notificationDes text, 
    semesterId Integer,
    sessionId Integer,
    classId Integer

      );
''');
    await db.execute('''
    create Table `Quiz`
      (
        
      quizId Integer primary key autoincrement,
      quizNo text,
      semesterId Integer,
      sessionId Integer,
      classId Integer
      );
''');
    await db.execute('''
    create Table `Teacher`
      (
        teacherId Integer primary key autoincrement,
        teacherName text,
        teacherEmail text,
        teacherPassword text,
        teacherDepartment text
      );
''');
    await db.execute('''
    create Table `TimeTable`
    ( 
      timeTableId Integer primary key autoincrement,
      timeTableDesc text,
      semesterId Integer,
      sessionId Integer,
      classId Integer
    );
''');
  }

  rawInsert({required String query}) async {
    Database database = await instance.db;
    int id = await database.rawInsert(query);

    return id;
  }

  rawUpdate({required String query}) async {
    Database database = await instance.db;
    int id = await database.rawUpdate(query);

    return id;
  }

  rawDelete({required String query}) async {
    Database database = await instance.db;
    int id = await database.rawDelete(query);
    return id;
  }

  Future<List<Map<String, dynamic>>> getDataByQuery(
      {required String query}) async {
    Database database = await instance.db;
    var res = await database.rawQuery(query);
    return res;
  }
}
