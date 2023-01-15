import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:loginscreen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  String? finalemail;
  @override
  void initState() {
    // TODO: implement initState
    getV().whenComplete(() async
    {
      await Future.delayed(const Duration(milliseconds: 3000),() {
        if(finalemail == null)
          {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>   LoginScreen()));

          }
        else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>   Dashboard()));
        }
      });
      //await Future.delayed(const Duration(milliseconds: 3000),() {} );
    });
    super.initState();
  }
  Future getV() async
  {
    final SharedPreferences sp=  await SharedPreferences.getInstance() ;
    var getv=sp.getString("Email");
    setState(() {
      finalemail=getv!;
    });
    print(finalemail);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Center(child: Icon(Icons.downloading,size: 20,)),
    );
  }
}
