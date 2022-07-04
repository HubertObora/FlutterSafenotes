// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoteBuilder extends StatelessWidget {
  final String docName;
  NoteBuilder({required this.docName});
  Future saveNote() async {
    String title = _titleController.text;
    String content = _contentController.text;
    await FirebaseFirestore.instance
        .collection(docName)
        .add({'title': title, 'content': content});
  }

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 215, 168, 110),
        elevation: 0,
        centerTitle: true,
        title: Text('Safe Notes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Wpisz tytuł'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              maxLines: 10,
              controller: _contentController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Wpisz treść notatki'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          saveNote();
          Navigator.pop(context);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}
