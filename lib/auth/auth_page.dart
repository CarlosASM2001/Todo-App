import 'package:flutter/material.dart';
import 'package:to_do_app/screen/login.dart';
import 'package:to_do_app/screen/signup.dart';

class AuthPage extends StatefulWidget {
  const AuthPage ({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  
  bool a = true;

  void to(){
    setState(() {
      a = !a;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    if(a){
      return LoginScreen(to);
    }else{
      return SignupScreen(to);
    }
  }
}