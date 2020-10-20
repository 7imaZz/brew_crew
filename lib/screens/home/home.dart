import 'package:brew_crew/service/auth_service.dart';
import 'package:flutter/material.dart';


class Home extends StatelessWidget {

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
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
      ),
    );
  }
}
