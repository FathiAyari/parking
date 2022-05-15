import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking/screens/client/historic/historic.dart';
import 'package:parking/screens/client/home/homePage.dart';
import 'package:parking/screens/client/reservations/reservations.dart';
import 'package:parking/screens/client/settings/Settings.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({Key? key}) : super(key: key);

  @override
  State<HomePageContent> createState() => _HelaurState();
}

class _HelaurState extends State<HomePageContent> {
  int currentIndex = 0;
  final screens = [
    Home(),
    Reservations(),
    Historic(),
    Settings(),
  ];
  Widget positive() {
    return Container(
      decoration: BoxDecoration(color: Colors.blueAccent),
      child: TextButton(
          onPressed: () {
            exit(0);
          },
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white),
          )),
    );
  }

  Widget negative() {
    return TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "No",
          style: TextStyle(color: Colors.blueAccent),
        ));
  }

  Future<bool> avoidRteurnButton() async {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text("Are you sure you wanna exit"),
            actions: [
              negative(),
              positive(),
            ],
          );
        });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: avoidRteurnButton,
      child: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFF3585E2),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Reservations',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Historic',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
              backgroundColor: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
