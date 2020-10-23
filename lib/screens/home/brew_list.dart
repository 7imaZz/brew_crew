import 'package:brew_crew/pojo/brew_model.dart';
import 'package:brew_crew/screens/home/brew_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();

}

class _BrewListState extends State<BrewList> {

  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);
    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index){
        return BrewTile(brews[index]);
      },
    );
  }
}
