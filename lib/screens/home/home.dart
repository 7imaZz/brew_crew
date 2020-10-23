import 'package:brew_crew/pojo/brew_model.dart';
import 'package:brew_crew/service/auth_service.dart';
import 'package:brew_crew/service/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'brew_list.dart';


// ignore: must_be_immutable
class Home extends StatelessWidget {

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().get(),
      child: Container(
        child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            title: Text('Brew Crew'),
            elevation: 0.0,
            backgroundColor: Colors.brown[400],
            actions: [
              FlatButton.icon(
                onPressed: () async {
                  authService.signOut();
                },
                label: Text('Sign Out'),
                icon: Icon(Icons.person),
              )
            ],
          ),
          body: BrewList(),
        ),
      ),
    );
  }
}
