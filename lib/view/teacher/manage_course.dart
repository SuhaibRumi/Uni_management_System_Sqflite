import 'package:flutter/material.dart';
import 'package:uni_mangement_system/utils/constants.dart';
import 'package:uni_mangement_system/view_model/view_model.dart';

import '../../widgets/widget.dart';

class ManageCourse extends StatefulWidget {
  const ManageCourse({Key? key}) : super(key: key);

  @override
  State<ManageCourse> createState() => _ManageCourseState();
}

class _ManageCourseState extends State<ManageCourse> {
  final _courseNameController = TextEditingController();

  var courseViewModel = CourseViewModel();
  var semesterViewModel = SemesterViewModel();
  var sessionViewModel = SessionViewModel();
  var classViewModel = ClassViewModel();
  var classState = GlobalKey<FormFieldState>();
  var sessionState = GlobalKey<FormFieldState>();
  var semesterState = GlobalKey<FormFieldState>();
  bool isUpdate = false;
  String? classId;
  String? sessionId;
  String? semesterId;
  String? courseId;

  Future<List<CourseViewModel>>? data;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  _loadData() {
    data = courseViewModel.getData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _loadData();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text("Manage Course"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 4,
                  shadowColor: Colors.grey[500],
                  child: Column(
                    children: [
                      FutureBuilder(
                          future: sessionViewModel.getData(),
                          builder: (context,
                              AsyncSnapshot<List<SessionViewModel>> snapshot) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }

                            return DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.book_outlined,
                                      color: kSecondary)),
                              // value: sessionId,
                              // key: sessionState,
                              hint: const Text("Select Session"),
                              items: snapshot.data!.map((session) {
                                return DropdownMenuItem(
                                  value: session.sessionId.toString(),
                                  child: Text(session.sessionName ?? ""),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  sessionId = value.toString();
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "please select your session";
                                }
                                return null;
                              },
                            );
                          }),
                      FutureBuilder(
                          future: classViewModel.getData(),
                          builder: (context,
                              AsyncSnapshot<List<ClassViewModel>> snapshot) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            return DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.book_outlined,
                                      color: kSecondary)),

                              value: classId,
                              key: classState,
                              hint: const Text("Select Class"),
                              items: snapshot.data!.map((classes) {
                                return DropdownMenuItem(
                                  value: classes.classId.toString(),
                                  child: Text(classes.className ?? ""),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  classId = value!.toString();
                                });
                              },
                              // validator: (value) {
                              //   if (value == null) {
                              //     return "please select your class";
                              //   }
                              //   return null;
                              // },
                            );
                          }),
                      FutureBuilder(
                          future: semesterViewModel.getdata(),
                          builder: (context,
                              AsyncSnapshot<List<SemesterViewModel>> snapshot) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }
                            return DropdownButtonFormField(
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.description_outlined,
                                      color: kSecondary)),
                              key: semesterState,
                              value: semesterId,
                              hint: const Text("Select Semester"),
                              items: snapshot.data!.map((semester) {
                                return DropdownMenuItem(
                                  value: semester.semesterId.toString(),
                                  child: Text(semester.semesterName ?? ""),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  semesterId = value!.toString();
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "please select your semester";
                                }
                                return null;
                              },
                            );
                          }),
                      InputField(
                        lableText: "Course Name",
                        hintText: "Enter Course Name",
                        icon: const Icon(
                          Icons.library_books_rounded,
                        ),
                        controller: _courseNameController,
                      ),
                      const Divider(
                        indent: 15,
                        endIndent: 15,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Upload file",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MyButton(
                  color: kPrimaryColor,
                  text: "Save Data",
                  onPrseed: () {
                    if (isUpdate == false) {
                      _addData();
                    } else {
                      _updateDta();
                    }
                  },
                  height: 40,
                  width: 110,
                  fontsize: 14),
              const SizedBox(
                height: 50,
              ),
              FutureBuilder(
                  future: data,
                  builder:
                      (context, AsyncSnapshot<List<CourseViewModel>> snapshot) {
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text(
                          "No Data Found",
                          style: TextStyle(fontSize: 18),
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("Something went Wrong"),
                      );
                    }
                    List<CourseViewModel> courses = snapshot.data!;

                    return SizedBox(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text("Course ID")),
                            DataColumn(label: Text("Course Name")),
                            DataColumn(label: Text(" Class Name")),
                            DataColumn(label: Text(" Session Name")),
                            DataColumn(label: Text(" Semester No")),
                            DataColumn(label: Text("Edit")),
                            DataColumn(label: Text("Delete")),
                          ],
                          rows: courses.map((row) {
                            return DataRow(cells: [
                              DataCell(
                                Text(row.courseId.toString()),
                              ),
                              DataCell(
                                Text(
                                  row.courseName ?? "",
                                ),
                              ),
                              DataCell(
                                Text((row.className ?? "")),
                              ),
                              DataCell(
                                Text(row.sessionName ?? ""),
                              ),
                              DataCell(
                                Text(row.semesterName ?? ""),
                              ),
                              DataCell(IconButton(
                                onPressed: () async {
                                  setState(() {
                                    courseId = row.courseId;
                                    semesterId = row.semesterId;
                                    sessionId = row.sessionId;
                                    classId = row.classId;
                                    _courseNameController.text =
                                        row.courseName!;

                                    isUpdate = true;
                                  });

                                  // this Editig for sessionId

                                  // sessionViewModel = SessionViewModel(
                                  //   sessionName: row.sessionName,
                                  // );
                                  // var sId =
                                  //     await sessionViewModel.getSessionId();
                                  // sessionId = sId.toString();
                                  // sessionState.currentState!
                                  //     .didChange(sessionId);

                                  // this Editig for ClassId

                                  classViewModel = ClassViewModel(
                                    className: row.className,
                                  );
                                  var cId = await classViewModel.getClassId();
                                  classId = cId.toString();
                                  classState.currentState!.didChange(classId);

                                  // this Editig for SemesterId
                                  semesterViewModel = SemesterViewModel(
                                    semesterName: row.semesterName,
                                  );
                                  var ssId =
                                      await semesterViewModel.getSemesterId();
                                  semesterId = ssId.toString();
                                  semesterState.currentState!
                                      .didChange(semesterId);
                                },
                                icon: const Icon(Icons.edit),
                                splashRadius: 20,
                              )),
                              DataCell(IconButton(
                                onPressed: () {
                                  setState(() {
                                    courseId = row.courseId;
                                    _deleteDta();
                                  });
                                },
                                icon: const Icon(Icons.delete),
                                splashRadius: 20,
                              )),
                            ]);
                          }).toList(),
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ));
  }

  _addData() {
    courseViewModel = CourseViewModel(
        courseName: _courseNameController.text,
        semesterId: semesterId,
        sessionId: sessionId,
        classId: classId);

    courseViewModel.saveData();
    setState(() {});
    _clearData();
  }

  _updateDta() {
    courseViewModel = CourseViewModel(
        courseName: _courseNameController.text,
        sessionId: sessionId,
        semesterId: semesterId,
        classId: classId,
        courseId: courseId);
    courseViewModel.updateData();
    setState(() {
      isUpdate = false;
    });
    _clearData();
  }

  _deleteDta() {
    courseViewModel = CourseViewModel(
      courseId: courseId,
    );
    courseViewModel.deleteData();
  }

  _clearData() {
    _courseNameController.clear();
    classId = "";
    semesterId = '';
    sessionId = '';
    courseId = '';
  }
}
