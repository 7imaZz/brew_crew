import 'package:brew_crew/service/auth_service.dart';
import 'package:flutter/material.dart';


class SignIn extends StatefulWidget {

  final Function toggleWidget;
  SignIn({this.toggleWidget});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService authService = AuthService();

  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        actions: [
          FlatButton.icon(
            onPressed: (){
              widget.toggleWidget();
            },
            icon: Icon(Icons.person),
            label: Text('Register'),
          )
        ],
        title: Text('Sign In To Brew Crew'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val.isEmpty? 'Invalid Email': null,
                onChanged: (val){
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val.length<6? 'Require at least 6 digits': null,
                obscureText: true,
                onChanged: (val){
                  password = val;
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                onPressed: () async{
                  if(_formKey.currentState.validate()) {
                    dynamic result = await authService.signInWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        error = 'Invalid Login';
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 20.0),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
