// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safenotes/notes/get_user_notes.dart';
import 'package:safenotes/notes/note_builder.dart';
import 'package:safenotes/notes/note_editor.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

Future addNote() async {}

class _NotesState extends State<Notes> {
  List<String> DocumentID = [];
  Future getDocumentID() async {
    DocumentID = [];
    await FirebaseFirestore.instance
        .collection('notes')
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) {
              DocumentID.add(element.reference.id);
            }));
  }

  Future deleteNote(String docID) async {
    await FirebaseFirestore.instance.collection('notes').doc(docID).delete();
  }

  Future editNote(String docID) async {
    await FirebaseFirestore.instance.collection('notes').doc(docID).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 235, 193),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 215, 168, 110),
        elevation: 0,
        centerTitle: true,
        title: Text('Safe Notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: GestureDetector(
                  onTap: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NoteBuilder(
                                docName: 'notes',
                              )),
                    ).then((value) => setState(
                          () {},
                        ));
                  }),
                  child: Container(
                    height: 60,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 142, 50, 0),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text('Dodaj Notatk??',
                            style: TextStyle(
                              fontSize: 25,
                            ))),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Twoje notatki:',
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
              future: getDocumentID(),
              builder: (context, index) {
                return ListView.builder(
                    itemCount: DocumentID.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () {
                            String id = DocumentID[index].toString();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NoteEditor(
                                        noteID: id,
                                        docName: 'notes',
                                      )),
                            ).then((value) => setState(
                                  () {},
                                ));
                          },
                          leading: GestureDetector(
                              onTap: (() {
                                String id = DocumentID[index].toString();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NoteEditor(
                                            noteID: id,
                                            docName: 'notes',
                                          )),
                                ).then((value) => setState(
                                      () {},
                                    ));
                              }),
                              child: Icon(
                                Icons.edit,
                                color: Colors.black,
                              )),
                          //tileColor: Color.fromARGB(255, 137, 115, 24),
                          title: GetUserNotes(
                            documentID: DocumentID[index],
                            documentName: 'notes',
                          ),
                          trailing: GestureDetector(
                              onTap: (() {
                                String id = DocumentID[index].toString();
                                deleteNote(id);
                                setState(() {});
                              }),
                              child: Icon(
                                Icons.delete,
                                color: Colors.black,
                              )),
                        ),
                      );
                    });
              },
            ))
          ],
        ),
      ),
    );
  }
}
