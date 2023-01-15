import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loginscreen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

import 'drawer.dart';

class mypermission extends StatefulWidget {
  const mypermission({Key? key}) : super(key: key);

  @override
  State<mypermission> createState() => _mypermissionState();
}

class _mypermissionState extends State<mypermission> {
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
          child: Column(

            children: [

              ListTile(
                leading: Icon(Icons.camera),
                title: Text(" Camera permission"),


                onTap: () async {
                  PermissionStatus camera = await Permission.camera.request();
                  // Request permission here
                  if (camera ==PermissionStatus.granted)
                  {
                    Fluttertoast.showToast(msg: "Permission granted");
                  }
                  if (camera ==PermissionStatus.denied)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("please provide permisssion")));
                  }
                  if (camera ==PermissionStatus.permanentlyDenied)
                  {
                    openAppSettings();
                  }


                },
              ),
              ListTile(
                leading: Icon(Icons.storage),
                title: Text("Storage permission"),


                onTap: () async {
                  PermissionStatus storage = await Permission.storage.request();
                  // Request permission here
                  if (storage ==PermissionStatus.granted)
                  {
                    Fluttertoast.showToast(msg: "Permission granted");
                  }
                  if (storage ==PermissionStatus.denied)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("please provide permisssion")));
                  }
                  if (storage ==PermissionStatus.permanentlyDenied)
                  {
                    openAppSettings();
                  }


                },
              ),
              ListTile(
                leading: Icon(Icons.mic),
                title: Text("Microphone permission"),


                onTap: () async {
                  PermissionStatus microphone = await Permission.microphone.request();
                  // Request permission here
                  if (microphone ==PermissionStatus.granted)
                  {
                    Fluttertoast.showToast(msg: "Permission granted");
                  }
                  if (microphone ==PermissionStatus.denied)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("please provide permisssion")));
                  }
                  if (microphone ==PermissionStatus.permanentlyDenied)
                  {
                    openAppSettings();
                  }


                },
              ),

              ListTile(
                leading: Icon(Icons.storage_sharp),
                title: Text("All permission"),


                onTap: () async {
                  Map<Permission, PermissionStatus> status = await[

                    Permission.camera,
                    Permission.storage,
                    Permission.microphone,
                    Permission.sms,
                    Permission.mediaLibrary,
                    Permission.photos,
                  ].request();
                  print(status.toString());

                },
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     removeP();
              //     Fluttertoast.showToast(msg: "Logout Successfully");
              //     Navigator.pushReplacement(context,
              //         MaterialPageRoute(builder: (context) => LoginScreen()));
              //   },
              //   child: Text("logout"),
              // ),
            ],
          ),
        ),
      ),


    );
  }
}