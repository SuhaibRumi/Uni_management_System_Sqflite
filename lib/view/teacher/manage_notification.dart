import 'package:flutter/material.dart';
import 'package:uni_mangement_system/utils/constants.dart';

import '../../view_model/view_model.dart';
import '../../widgets/widget.dart';

class ManageNotification extends StatefulWidget {
  const ManageNotification({Key? key}) : super(key: key);

  @override
  State<ManageNotification> createState() => _ManageNotificationState();
}

class _ManageNotificationState extends State<ManageNotification> {
  final _notificationNameController = TextEditingController();
  final _notificationDesController = TextEditingController();
  var notificationViewModel = NotificationViewModel();
  var semesterViewModel = SemesterViewModel();
  var sessionViewModel = SessionViewModel();
  var classViewModel = ClassViewModel();
  bool isUpdate = false;
  String? notificationId;
  String? sessionId = '';
  String? semesterId;
  String? courseId;
  String? classId;

  Future<List<NotificationViewModel>>? data;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  _loadData() {
    data = notificationViewModel.getData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _loadData();
    return Scaffold(
      appBar: AppBar(
          elevation: 2,
          backgroundColor: kPrimaryColor,
          title: const Text("Manage Notification")),
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
                            autofocus: true,
                            hint: const Text("Select Session"),
                            items: snapshot.data!.map((session) {
                              return DropdownMenuItem(
                                value: session.sessionId,
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
                            autofocus: true,
                            hint: const Text("Select Class"),
                            items: snapshot.data!.map((classes) {
                              return DropdownMenuItem(
                                value: classes.classId,
                                child: Text(classes.className ?? ""),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                classId = value!.toString();
                                print(value);
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
                            hint: const Text("Select Semester"),
                            items: snapshot.data!.map((semester) {
                              return DropdownMenuItem(
                                value: semester.semesterId,
                                child: Text(semester.semesterName ?? ""),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                semesterId = value!.toString();
                                print(value);
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
                      lableText: "Title",
                      hintText: "Enter Notification",
                      icon: const Icon(
                        Icons.library_books_rounded,
                        color: kSecondary,
                      ),
                      controller: _notificationNameController,
                    ),
                    const Divider(
                      indent: 15,
                      endIndent: 15,
                    ),
                    InputField(
                      lableText: " Notification Description:",
                      hintText: "",
                      icon: const Icon(
                        Icons.library_books_rounded,
                        color: kSecondary,
                      ),
                      controller: _notificationDesController,
                    ),
                    const Divider(
                      thickness: 1.2,
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
              height: 20,
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
                width: 150,
                fontsize: 14),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: data,
                builder: (context,
                    AsyncSnapshot<List<NotificationViewModel>> snapshot) {
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
                  List<NotificationViewModel> notification = snapshot.data!;

                  return SizedBox(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text("Notification ID")),
                          DataColumn(label: Text("Notification Title")),
                          DataColumn(label: Text(" Notification Desc")),
                          DataColumn(label: Text(" Session Name")),
                          DataColumn(label: Text(" Class Name")),
                          DataColumn(label: Text(" Semester No")),
                          DataColumn(label: Text("Edit")),
                          DataColumn(label: Text("Delete")),
                        ],
                        rows: notification.map((row) {
                          return DataRow(cells: [
                            DataCell(
                              Text(row.notificationId.toString()),
                            ),
                            DataCell(
                              Text(
                                row.notificationName ?? "",
                              ),
                            ),
                            DataCell(
                              Text(
                                row.notificationDes ?? "",
                              ),
                            ),
                            DataCell(
                              Text((row.sessionName ?? "")),
                            ),
                            DataCell(
                              Text(row.className ?? ""),
                            ),
                            DataCell(
                              Text(row.semesterName ?? ""),
                            ),
                            DataCell(IconButton(
                              onPressed: () {
                                setState(() {
                                  notificationId = row.notificationId;
                                  semesterId = row.semesterId;
                                  sessionId = row.sessionId;
                                  classId = row.classId;
                                  _notificationNameController.text =
                                      row.notificationName!;
                                  _notificationDesController.text =
                                      row.notificationDes!;

                                  isUpdate = true;
                                });
                              },
                              icon: const Icon(Icons.edit),
                              splashRadius: 20,
                            )),
                            DataCell(IconButton(
                              onPressed: () {
                                setState(() {
                                  notificationId = row.notificationId;

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
      ),
    );
  }

  _addData() {
    notificationViewModel = NotificationViewModel(
        notificationName: _notificationNameController.text,
        notificationDes: _notificationDesController.text,
        semesterId: semesterId,
        sessionId: sessionId,
        classId: classId);

    notificationViewModel.saveData();
    setState(() {});
    _clearData();
  }

  _updateDta() {
    notificationViewModel = NotificationViewModel(
      notificationName: _notificationNameController.text,
      notificationDes: _notificationDesController.text,
      notificationId: notificationId,
      sessionId: sessionId,
      semesterId: semesterId,
      classId: classId,
    );
    notificationViewModel.updateData();
    setState(() {
      isUpdate = false;
    });
    _clearData();
  }

  _deleteDta() {
    notificationViewModel = NotificationViewModel(
      notificationId: notificationId,
    );
    notificationViewModel.deleteData();
  }

  _clearData() {
    _notificationNameController.clear();
    _notificationDesController.clear();
    classId = "";
    semesterId = '';
    sessionId = '';
    courseId = '';
  }
}
