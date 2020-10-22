import 'package:brew_crew/screens/authentication/register.dart';
import 'package:brew_crew/screens/authentication/sign_in.dart';
import 'package:flutter/material.dart';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {

  bool isSignIn = true;

  void toggleWidget(){
    setState(() {
      isSignIn = !isSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(isSignIn){
      return SignIn(toggleWidget: toggleWidget);
    }else{
      return Register(toggleWidget: toggleWidget);
    }
  }
}
