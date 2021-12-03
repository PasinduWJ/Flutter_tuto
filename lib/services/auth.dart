import 'package:fire_tutuo/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fire_tutuo/models/model_user.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on fierbase
  ModelUser _userFromFirebaseUser(User user){
    return user != null ? ModelUser(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<ModelUser> get user{
    return _auth.authStateChanges()
        //.map((User user) => _userFromFirebaseUser(user));
      .map(_userFromFirebaseUser);
  }

  //sign in anon
  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();       //AuthResult
      User user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  
  //register with email & password
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      //create new document for user with the uid
      await DatabaseService(uid : user.uid).updateUserData('new crew member','0', 100);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  
  //sign out
  Future signOut()async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}