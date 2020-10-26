import 'package:brew_crew/pojo/user_model.dart';
import 'package:brew_crew/service/database.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();

  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugar;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel>(context);

    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData){

          UserData currentUser = snapshot.data;
          return Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Update Your Brew Settings',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: currentUser.name,
                  decoration: customInputDecoration('Your Name'),
                  validator: (val) => val.isEmpty? 'Please Enter Your Name': null,
                  onChanged: (val) {
                    setState(() {
                      _currentName = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                //DropDown
                DropdownButtonFormField(
                  decoration: customInputDecoration(''),
                  value: _currentSugar?? currentUser.sugar,
                  items: sugars.map((sugar){
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar Sugar(s)'),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _currentSugar = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                //Slider
                Slider(
                  value: (_currentStrength?? currentUser.strength).toDouble(),
                  min: 100.0,
                  max: 900,
                  divisions: 8,
                  activeColor: Colors.brown[_currentStrength?? currentUser.strength],
                  inactiveColor: Colors.brown[_currentStrength?? currentUser.strength],
                  onChanged: (val) {
                    setState(() {
                      _currentStrength = val.toInt();
                    });
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.pink,
                  child: Text(
                    'Update',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async{
                    if(_formKey.currentState.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugar ?? currentUser.sugar,
                        _currentName ?? currentUser.name,
                        _currentStrength ?? currentUser.strength
                      );

                      Navigator.pop(context); 
                    }
                  },
                )
              ],
            ),
          );
        }else{
          return Loading();
        }
      },
    );
  }
}
