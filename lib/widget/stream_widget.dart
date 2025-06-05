import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/data/firestore.dart';
import 'package:to_do_app/widget/task_widget.dart';

class StreamNote extends StatelessWidget {

  StreamNote({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirestoreDataSource().stream(),
      builder: (context, snapshot) {

        if(!snapshot.hasData){
          return CircularProgressIndicator();
        }
        final noteslist= FirestoreDataSource().getNotes(snapshot);
        return ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index){
            final note = noteslist[index];
            return Dismissible(key: UniqueKey(), onDismissed: (direction) {
              FirestoreDataSource().DeleteNote(note.id);
            },child:TaskWidget(note));
          },
          itemCount: noteslist.length,
        );
      }
    );
  }
}