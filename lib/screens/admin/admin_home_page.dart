import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking/screens/admin/fees.dart';
import 'package:parking/screens/admin/reservations.dart';
import 'package:parking/screens/admin/users.dart';

class AdminHomePageScreen extends StatefulWidget {
  const AdminHomePageScreen({Key? key}) : super(key: key);

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePageScreen> {
  @override
  final screens = [Fees(), Users(), Reservations()];
  int currentIndex = 0;
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                label: "Fees", icon: Icon(Icons.monetization_on)),
            BottomNavigationBarItem(
                label: "Users", icon: Icon(Icons.account_circle)),
            BottomNavigationBarItem(
                label: "Booking", icon: Icon(Icons.bookmark)),
          ],
        ),
      ),
    );
  }
}
