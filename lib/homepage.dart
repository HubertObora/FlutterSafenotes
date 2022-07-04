// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:safenotes/pages/mainpage.dart';
import 'package:safenotes/pages/notes.dart';
import 'package:safenotes/pages/safenotes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _navigate(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _listPages = [MainPage(), Notes(), SafeNotes()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _listPages[_selectedIndex],
        backgroundColor: Colors.deepPurple[100],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            fixedColor: Colors.black,
            onTap: _navigate,
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'lib/icons/house.png',
                    height: 32,
                  ),
                  label: 'Strona główna'),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'lib/icons/notepad.png',
                    height: 32,
                  ),
                  label: 'Notatki'),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'lib/icons/notepadSafe.png',
                    height: 32,
                  ),
                  label: 'Notatki prywatne')
            ]));
  }
}
