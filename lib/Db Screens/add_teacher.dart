
import 'package:flutter/material.dart';
import 'dart:async';
import '../db/database_helper.dart';
import '../models/teacher_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class AddTeacher extends StatefulWidget {
  const AddTeacher({Key? key}) : super(key: key);

  @override
  State<AddTeacher> createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {
  var formKey = GlobalKey<FormState>();
  late String name;
  late String designation;
  late String dept;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text("Add Teacher"),
    ),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                // keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Teacher Name',
                    labelText: 'Teacher Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please provide Teacher Name';
                  } else {
                    name = text;
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                // keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Teacher Designation',
                    labelText: 'Teacher Designation',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please provide Teacher Designation';
                  } else {
                    designation = text;
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                // keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Teacher Dept',
                    labelText: 'Teacher Dept',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    )),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please provide Teacher Dept';
                  } else {
                    dept = text;
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),

              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // primary: Colors.red,
                          ),
                          onPressed: () {
                            formKey.currentState!.reset();
                          },
                          child: const Text('Clear'))),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {

                              // Insert into DB

                              var tch = Teacher(name: name, designation: designation, dept: dept);

                              var dbHelper =  DatabaseHelper.instance;
                              int result = await dbHelper.insertTeacher(tch);

                              if( result > 0 ){
                                Fluttertoast.showToast(msg: 'Teacher Saved');
                              }

                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Save'))),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              // Text('Obtained Marks: $obtMarks'),
            ],
           ),
        ),
      ),
    ),
    );
  }
}
