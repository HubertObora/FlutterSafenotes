// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../containermainpage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> DocumentID = [];
  int notecount = 0;
  int safenotecount = 0;
  int alltecount = 0;
  Future getDocumentID() async {
    DocumentID = [];
    await FirebaseFirestore.instance
        .collection('notes')
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) {
              notecount++;
            }));
    await FirebaseFirestore.instance
        .collection('safenotes')
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) {
              safenotecount++;
            }));
    alltecount = notecount + safenotecount;
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
      drawer: Drawer(
        child: Container(
          color: Color.fromARGB(255, 198, 174, 81),
          child: ListView(
            children: [
              DrawerHeader(
                  child: Center(
                child: Text(
                  'Safe Notes',
                  style: TextStyle(fontSize: 35),
                ),
              )),
              ListTile(
                leading: Icon(Icons.calendar_month),
                title: Text('Kalendarz', style: TextStyle(fontSize: 20)),
                // onTap: () {
                //   Navigator.of(context).push(Kalendarz(
                //       Builder(builder: (context) => StronaKalendarz())));
                // },
              )
            ],
          ),
        ),
      ),
      body: FutureBuilder(
          future: getDocumentID(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  MainPageContainer(
                    text: 'zapisanych notatek: ',
                    isBold: false,
                  ),
                  MainPageContainer(
                    text: alltecount.toString(),
                    isBold: true,
                  ),
                  MainPageContainer(
                    text: 'zapisanych nie chronionych notatek: ',
                    isBold: false,
                  ),
                  MainPageContainer(
                    text: notecount.toString(),
                    isBold: true,
                  ),
                  MainPageContainer(
                    text: 'zapisanych chronionych notatek: ',
                    isBold: false,
                  ),
                  MainPageContainer(
                    text: safenotecount.toString(),
                    isBold: true,
                  ),
                ],
              );
            }
            return Text(
              'Wczytywanie...',
              style: TextStyle(fontSize: 25),
            );
          }),
    );
  }
}
