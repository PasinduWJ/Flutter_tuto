import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_tutuo/models/brew.dart';
import 'package:fire_tutuo/models/model_user.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('brews');


  Future<void> updateUserData( String name,String sugars, int strength) async{
    return await brewCollection.doc(uid).set({
      'name' : name,
      'sugars': sugars,
      'strength' : strength,
    });
  }
  //brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Brew(
        name: doc.data()['name'] ?? '',
        sugars: doc.data()['sugars'] ?? '0',
        strength: doc.data()['strength'] ?? 0,
      );
    }).toList();
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
        uid: uid,
        name: snapshot.data()['name'],
        sugars: snapshot.data()['sugars'],
        strength: snapshot.data()['strength'],

        );
  }

  //get brews stream
  Stream<List<Brew>> get brews{
    return brewCollection.snapshots()
        .map(_brewListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
      return brewCollection.doc(uid).snapshots()
      .map(_userDataFromSnapshot);
  }

}