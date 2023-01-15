import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginscreen/login.dart';
import 'package:loginscreen/permission.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Db Screens/home_page.dart';
import 'drawer.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<void> removeP() async
  {
    final SharedPreferences sp = await SharedPreferences
        .getInstance() as SharedPreferences;
    sp.remove("Email");
  }

  @override
  Widget build(BuildContext context) {
    var permissionsList;
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter"),

      ),
      floatingActionButton: FloatingActionButton.extended (onPressed: (){
        removeP();
        Fluttertoast.showToast(msg: "Logout Successfully");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => LoginScreen()));
      },
        label: const Text('Logout'),
        icon: const Icon(Icons.logout),


      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(

                children: [
                  ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                  }, child: Text("SQLite")),
                  ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>mypermission()));
                  }, child: Text("Permissions")),

                ],
              ),
            ),
          ),
        ),
      ),


    );
  }
}