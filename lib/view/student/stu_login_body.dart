import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import 'stu_sign_form.dart';

class StudentLoginBody extends StatelessWidget {
  const StudentLoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Column(
            children: const [
              SizedBox(
                height: 20,
              ),
              Text(
                "STUDENT'S ",
                style: TextStyle(
                    fontSize: 25,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                " Sign in with your email and password ",
                style: TextStyle(
                    fontSize: 18,
                    color: kTextColor,
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              StudentSignForm(),
            ],
          ),
        ),
      ),
    );
  }
}
