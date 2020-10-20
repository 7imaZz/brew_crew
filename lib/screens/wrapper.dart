import 'package:brew_crew/pojo/user_model.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authentication/authentication.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserModel>(context);

    if(user == null){
      return Auth();
    }else {
      return Home();
    }
  }
}
