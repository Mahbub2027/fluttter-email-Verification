import 'dart:async';
//import 'dart:js';
//import 'dart:js';
//import 'dart:js';

import 'package:astronerds/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:signupscreen/home.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

final _auth = FirebaseAuth.instance;
User? user;
Timer? timer;
class _VerifyEmailPageState extends State<VerifyEmailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = _auth.currentUser;
    user!.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 4),
        (timer){
          checkEmailVerification();
        }
    );
  }

  @override
  void dispose(){
    timer!.cancel();
    super.dispose();
  }
  
  
  @override
  Widget build(BuildContext context) {
    //return Scaffold(
    return MaterialApp(
      home: Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text("Please verify your email")
          ],
        ),
      ),
    ));
  }


Future<void> checkEmailVerification() async{
  User? user = FirebaseAuth.instance.currentUser;
  await user!.reload();
  if(user.emailVerified){
    timer!.cancel();  
    
    //Navigator.pushReplacement(context as BuildContext, MaterialPageRoute(builder: (context) => ResetPasswordScreen()))
    Navigator.pushReplacement(context as BuildContext,
    MaterialPageRoute(builder: ((context) => homeScreen())));
  }
  
}
}