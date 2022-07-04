// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserNotes extends StatelessWidget {
  final String documentID;
  final String documentName;

  GetUserNotes({required this.documentID, required this.documentName});

  @override
  Widget build(BuildContext context) {
    CollectionReference notes =
        FirebaseFirestore.instance.collection(documentName);

    return FutureBuilder<DocumentSnapshot>(
        future: notes.doc(documentID).get(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> fullnote =
                snapshot.data!.data() as Map<String, dynamic>;
            return InkWell(
              child: Container(
                height: 95,
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 166, 75, 42),
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${fullnote['title']}',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      maxLines: 1,
                    ),
                    Text(
                      '${fullnote['content']}',
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            );
          }
          return Text('wczytywanie...');
        }));
  }
}
