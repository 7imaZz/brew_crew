import 'package:brew_crew/pojo/user_model.dart';
import 'package:brew_crew/service/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Return Our UserModel instead of firebase user
  UserModel _userFromFirebase(User user){
    return user!=null? UserModel(uid: user.uid): null;
  }

  //Change User state Signed in or out
  Stream<UserModel> get user{
    return _auth.authStateChanges()
        .map((User user) => _userFromFirebase(user));
  }

  Future signInAnon() async {
    try {
      UserCredential credential = await _auth.signInAnonymously();
      User user = credential.user;
      return _userFromFirebase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async{

    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = credential.user;
      return _userFromFirebase(user);
    }catch(e){
      print(e.toString());
      return null;
    }

  }

  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = credential.user;
      DatabaseService(uid: user.uid).updateUserData('0', 'New Crew Member', 100);
      return _userFromFirebase(user);
    }catch(e){
      print(e.toString());
    }
  }



  Future signOut() async{
    try {
     return await _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }
}