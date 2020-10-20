import 'package:brew_crew/pojo/user_model.dart';
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

  void signOut() async{
    try {
      _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }
}