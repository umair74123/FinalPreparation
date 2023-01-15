import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../db/database_helper.dart';
import '../models/teacher_model.dart';


class UpdateTeacher extends StatefulWidget {
  final Teacher teacher;
  const UpdateTeacher({Key? key, required this.teacher}) : super(key: key);

  @override
  State<UpdateTeacher> createState() => _UpdateTeacherState();
}

class _UpdateTeacherState extends State<UpdateTeacher> {
  late String name;
  late String designation;
  late String dept;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Teacher'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.teacher.name,
                  decoration: const InputDecoration(hintText: 'Teacher Name'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide Teacher Name';
                    }

                    name = value;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: widget.teacher.designation,
                  decoration: const InputDecoration(hintText: 'Teacher Designation'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide Teacher Designation';
                    }
                    designation = value;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: widget.teacher.dept,
                  decoration: const InputDecoration(hintText: 'Teacher Department'),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide Teacher Department';
                    }
                    dept = value;
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        // var tch = Teacher(id: widget.teacher.id,name: widget.teacher.name,
                        //     designation: widget.teacher.designation,
                        //     dept: widget.teacher.dept);

                        var tch = Teacher(id: widget.teacher.id,name: name,
                            designation: designation,
                            dept: dept);


                        // print(tch.toMap());

                        var dbHelper = DatabaseHelper.instance;
                        int result = await dbHelper.updateTeacher(tch);

                        // print("Result = " + result.toString());
                        if (result > 0) {
                          Fluttertoast.showToast(msg: 'Teacher Updated');
                          Navigator.pop(context, 'done');

                        }
                      }
                    },
                    child: const Text('Update')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
