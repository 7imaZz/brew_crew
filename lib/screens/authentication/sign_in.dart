import 'package:brew_crew/service/auth_service.dart';
import 'package:flutter/material.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text('Sign In To Brew Crew'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: RaisedButton(
          onPressed: () async {
            dynamic result = await authService.signInAnon();
            if(result == null){
              print('Error');
            }else{
              print('Signed In');
              print('uid: ${result.uid}');
            }
          },
          child: Text('Sign In Anon'),
        ),
      ),
    );
  }
}
