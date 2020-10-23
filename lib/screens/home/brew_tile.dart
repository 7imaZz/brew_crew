import 'package:brew_crew/pojo/brew_model.dart';
import 'package:flutter/material.dart';

class BrewTile extends StatelessWidget {

  final Brew brew;


  BrewTile(this.brew);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 4.0),
        child: ListTile(
          onTap: (){},
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[brew.strength],
          ),
          title: Text(brew.name),
          subtitle: Text('Takes ${brew.sugar} sugar(s)'),
        ),
      ),
    );
  }
}
