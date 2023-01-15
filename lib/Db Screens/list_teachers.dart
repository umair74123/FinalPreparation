
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/widgets.dart';
import 'package:loginscreen/Db%20Screens/update_teacher.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../db/database_helper.dart';
import '../models/teacher_model.dart';


class ListTeachers extends StatefulWidget {
  const ListTeachers({Key? key}) : super(key: key);

  @override
  State<ListTeachers> createState() => _ListTeachersState();
}

class _ListTeachersState extends State<ListTeachers> {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Teacher"),
      ),
      body: FutureBuilder<List<Teacher>>(
        future: DatabaseHelper.instance.getAllTeachers(),
        builder: (BuildContext context, AsyncSnapshot<List<Teacher>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          else {
            if (snapshot.data!.isEmpty) {
              return const Center(child: Text('No Teacher Record Found'));
            }
            else {
              List<Teacher> teachers = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: teachers.length, //players.length
                itemBuilder: (BuildContext context, int index) {
                  Teacher tch = teachers[index];

                  return Card(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tch.name,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text('Designation: ${tch.designation}') ,
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text('dept: ${tch.dept}')
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        var result =
                                        await Navigator.of(context)
                                            .push(MaterialPageRoute(
                                            builder: (context) {
                                              return UpdateTeacher(teacher: tch);
                                            }));

                                        if (result == 'done') {
                                          setState(() {});
                                        }
                                      },
                                      icon: const Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Confirmation!'),
                                                content: const Text(
                                                    'Are you sure to delete ?'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(
                                                            context)
                                                            .pop();
                                                      },
                                                      child:
                                                      const Text('No')),
                                                  TextButton(
                                                      onPressed: () async {
                                                        Navigator.of(
                                                            context)
                                                            .pop();

                                                        // delete dog

                                                        int result =
                                                        await DatabaseHelper
                                                            .instance
                                                            .deleteTeacher(tch.id!);

                                                        if (result > 0) {
                                                          Fluttertoast
                                                              .showToast(
                                                              msg:
                                                              'Teacher Deleted');
                                                          setState(() {});
                                                          // build function will be called
                                                        }
                                                      },
                                                      child: const Text(
                                                          'Yes')),
                                                ],
                                              );
                                            });
                                      },
                                      icon: const Icon(Icons.delete)),
                                ],
                              )
                            ],
                          )));
        //           return Column(
        //             children:  [
        //               ListTile(
        //                 // tileColor: Colors.green[colorCodes[index]],
        //                 // leading: Image.asset(players[index].image,height: 200,width: 50,),
        //                 title: Text(teachers[index].name,),
        //                 subtitle: Text(teachers[index].designation),
        //                 textColor: Colors.black,
        //                 onTap: () {
        //                   // Navigator.push(
        //                   //   context,
        //                   //   MaterialPageRoute(
        //                   //     builder: (context) => DetailScreen(player: players[index]),
        //                   //   ),
        //                   // );
        //                 },
        //
        // //                 trailing: Wrap(
        // //                     spacing: 12, // space between two icons
        // //                     children: <Widget>[
        // //                       Icon(Icons.call), // icon-1
        // //                 Icon(Icons.message),
        // //
        // // ];
        //                 //dense: true,
        //               ),
        //               Divider(),
        //
        //             ],
        //           );
                },
              )
              );

            }
          }


        },

      ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(8),
//         itemCount: 10, //players.length
//         itemBuilder: (BuildContext context, int index) {
//           return Column(
//             children:  [
//               ListTile(
//                 // tileColor: Colors.green[colorCodes[index]],
//                 // leading: Image.asset(players[index].image,height: 200,width: 50,),
//                 title: Text("Name"),//Text(players[index].name,),
//                 subtitle:Text("Designation"),// Text(players[index].description),
//                 textColor: Colors.black,
//                 onTap: () {
//                   // Navigator.push(
//                   //   context,
//                   //   MaterialPageRoute(
//                   //     builder: (context) => DetailScreen(player: players[index]),
//                   //   ),
//                   // );
//                 },
//
// //                 trailing: Wrap(
// //                     spacing: 12, // space between two icons
// //                     children: <Widget>[
// //                       Icon(Icons.call), // icon-1
// //                 Icon(Icons.message),
// //
// // ];
//                 //dense: true,
//               ),
//               Divider(),
//
//             ],
//           );
//         },
//       ),
    );
  }
}
