import 'package:brew_crew/service/auth_service.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleWidget;
  Register({this.toggleWidget});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService authService = AuthService();

  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';

  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return loading? Loading(): Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        actions: [
          FlatButton.icon(
            onPressed: (){
              widget.toggleWidget();
            },
            icon: Icon(Icons.person),
            label: Text('Sign In'),
          )
        ],
        title: Text('Sign Up To Brew Crew'),
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
                  validator: (val) => val.isEmpty || !val.contains('@')? 'Invalid E-mail': null,
                  onChanged: (val){
                    setState(() {
                      email = val;
                    });
                    },
                  decoration: customInputDecoration('Email'),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (val) => val.length<6? 'Enter At Least 6 Digits': null,
                  obscureText: true,
                  onChanged: (val){
                    password = val;
                  },
                  decoration: customInputDecoration('Password'),
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  onPressed: () async{
                    if(_formKey.currentState.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await authService.registerWithEmailAndPassword(email, password);
                      if(result == null){
                        setState(() {
                          error = 'Please Enter a Valid Email';
                          loading = false;
                        });
                      }
                    }
                  },
                ),
                SizedBox(height: 20.0),
                Text(
                  error,
                  style: TextStyle(
                    color: Colors.red[800]
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
