import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nemail = TextEditingController();
  TextEditingController npassword = TextEditingController();
  late String email ="abc@gmail.com";
  late String password ="123";

  Future<void> ShareP() async
  {
    final SharedPreferences sp=  await SharedPreferences.getInstance() as SharedPreferences;
    sp.setString("Email", nemail.text);
    print(sp.get("Email"));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.white, Colors.deepOrangeAccent,Colors.orange],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Welcome!',
                      style: TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      ' Email= abc@gmail.com & password= 123',

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: nemail,
                      decoration: InputDecoration(
                       
                        labelText: 'Email' ,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                        prefixIcon: Icon(Icons.email,color:Colors.white, ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: npassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                        prefixIcon: Icon(Icons.lock,color: Colors.white),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },

                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(

                        onPressed: () {
                          if(nemail.text== email && npassword.text==password) {
                            ShareP();
                            Fluttertoast.showToast(msg: "welcome");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Dashboard()),
                            );
                            print("login");
                          }
                          else

                            {
                              Fluttertoast.showToast(msg: "Incorrect Email/password");
                              print("incorrect");
                            }
                        },
                      child: Text('Log In'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(

                      child: Text("Forgot your password?",style:TextStyle(color: Colors.black87)) ,
                      onPressed: (){

                        print ("pressed");
                      },


                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


