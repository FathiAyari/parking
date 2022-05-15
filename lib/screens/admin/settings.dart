import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminSettings extends StatefulWidget {
  const AdminSettings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<AdminSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        onPressed: () {},
        child: Text("Log out"),
      ),
    );
  }
}
