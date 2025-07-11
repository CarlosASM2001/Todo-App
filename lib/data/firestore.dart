

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do_app/model/notes_model.dart';
import 'package:uuid/uuid.dart';


class FirestoreDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> CreateUser(String email) async{
    
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
        "id": _auth.currentUser!.uid,
        "email": email
      });
      return true;
    }catch(e){
      return true;
    }

    
  }

  Future<bool> AddNote(String subtitle, String title, int image) async {
    
    try {
      
      var uuid = Uuid().v4();
      DateTime data = new DateTime.now();

      await _firestore.collection('users').doc(_auth.currentUser!.uid)
      .collection('notes').doc(uuid).set({
        'id': uuid,
        'title': title,
        'subtitle': subtitle,
        'IsDone': false,
        'image': image,
        'time': '${data.hour}:${data.minute}'
      });

      return true;

    } catch (e) {
      print(e);
      return true;
    }
  }

  List getNotes(AsyncSnapshot snapshot){
    try {
      final noteList =snapshot.data!.docs.map((doc){
        final data = doc.data() as Map<String,dynamic>;
        return Note(
          data['id'],
          data['subtitle'],
          data['time'],
          data['image'],
          data['title'],
          data['IsDone']
        );
      }).toList();

      return noteList;
    } catch (e) {
      print(e);
      return [];
    }
  }


  Stream<QuerySnapshot> stream(){
    return _firestore.collection('users').doc(_auth.currentUser!.uid)
    .collection('notes')
    .snapshots();
  }


  Future<bool> isdone (String uuid, bool isDone)  async {

    try{
      await _firestore.collection('users').doc(_auth.currentUser!.uid)
      .collection('notes').doc(uuid).update({'IsDone' : isDone});

      return true;
    }catch(e){
      print(e);

      return true;
    }


  }

  Future<bool> UpdateNote (String uuid, int image, String title, String subtitle)  async {

    try{

      DateTime data = new DateTime.now();

      await _firestore.collection('users').doc(_auth.currentUser!.uid)
      .collection('notes').doc(uuid).update({
        'subtitle' : subtitle,
        'title' : title,
        'image' : image,
        'time' : '${data.hour}:${data.minute}'
      });

      return true;
    }catch(e){
      print(e);

      return true;
    }


  }


  Future<bool> DeleteNote(String uuid) async{
    try {
        await _firestore.collection('users').doc(_auth.currentUser!.uid)
        .collection('notes').doc(uuid).delete();

        return true;
    } catch (e) {
      print(e);
      return true;

    }
  }


}