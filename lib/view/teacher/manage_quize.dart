import 'package:flutter/material.dart';
import 'package:uni_mangement_system/utils/constants.dart';

import '../../widgets/widget.dart';

class ManageQuize extends StatefulWidget {
  const ManageQuize({Key? key}) : super(key: key);

  @override
  State<ManageQuize> createState() => _ManageQuizeState();
}

class _ManageQuizeState extends State<ManageQuize> {
  final _quizSubjectNameController = TextEditingController();
  final _quizSubjectNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 2,
          backgroundColor: kPrimaryColor,
          title: const Text("Mange Quize ")),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: DropdownButtonFormField(
                        alignment: Alignment.center,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.book_outlined,
                          ),
                        ),
                        hint: const Text("Select Session"),
                        items: [
                          DropdownMenuItem(
                              value: "data",
                              child: Column(
                                children: const <Widget>[
                                  Text("2021-2023"),
                                ],
                              )),
                        ],
                        onChanged: (value) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value == null) {
                            return "please select your Session";
                          }
                          return null;
                        },
                      ),
                    ),
                    DropdownButtonFormField(
                      alignment: Alignment.center,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                        Icons.crisis_alert_outlined,
                      )),
                      hint: const Text("Select Class"),
                      items: [
                        DropdownMenuItem(
                            value: "data",
                            child: Column(
                              children: const <Widget>[
                                Text("BSCS"),
                              ],
                            ))
                      ],
                      onChanged: (value) {
                        setState(() {});
                      },
                      validator: (value) {
                        if (value == null) {
                          return "please select your class";
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField(
                      alignment: Alignment.center,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                        Icons.description_outlined,
                      )),
                      hint: const Text("Select Semeter"),
                      items: [
                        DropdownMenuItem(
                            value: "data",
                            child: Column(
                              children: const <Widget>[
                                Text("1st"),
                              ],
                            ))
                      ],
                      onChanged: (value) {
                        setState(() {});
                      },
                      validator: (value) {
                        if (value == null) {
                          return "please select your Semester";
                        }
                        return null;
                      },
                    ),
                    const Divider(
                      indent: 15,
                      endIndent: 15,
                    ),
                    InputField(
                      lableText: "Quiz No:",
                      hintText: "",
                      icon: const Icon(
                        Icons.library_books_rounded,
                        color: kSecondary,
                      ),
                      controller: _quizSubjectNoController,
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
                onPrseed: () {},
                height: 40,
                width: 120,
                fontsize: 14),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
