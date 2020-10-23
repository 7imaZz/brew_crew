import 'package:brew_crew/pojo/brew_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;

  DatabaseService({this.uid});

  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength) async{

    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength
    });
  }

  List<Brew> _getBrewsFromSnapshot(QuerySnapshot snapshot){
    try{
      return snapshot.docs.map((e) {
        return Brew(
            name: e['name'] ?? '',
            sugar: e['sugars'] ?? '0',
            strength: e['strength'] ?? 0
        );
      }).toList();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Stream<List<Brew>> get (){
    try {
      return brewCollection.snapshots().map(_getBrewsFromSnapshot);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}