
import 'package:flutter/material.dart';

import 'add_teacher.dart';
import 'list_teachers.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SQLite DB for Attendance')),
      body:  Center(
        child: ElevatedButton(onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ListTeachers()),
          );
        },
            child: Text("show Teachers")),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Add Teacher'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddTeacher()),
                );

                // Navigator.of(context).push(MaterialPageRoute(builder: () {
                //   return AddTeacher();
                // }));
              },
            ),
            ListTile(
              title: const Text('Teachers List'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListTeachers()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
