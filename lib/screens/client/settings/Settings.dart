import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking/screens/auth/login/loginPage.dart';
import 'package:parking/screens/client/settings/consult_Profile_Page.dart';

import '../../../services/Auth/auth_service.dart';
import '../../../services/Auth/remember_controller.dart';
//import 'Consult_Vehicule_Data.dart';
import 'Consult_Credit_Card.dart';
import 'Tap_old_password.dart';

AuthService _authService = AuthService();

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  RememberController rememberController = RememberController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFDDDDDD),
      body: SafeArea(
        child: Container(
          padding: (EdgeInsets.only(top: 20, left: 0, right: 1)),
          child: ListView(
            children: [
              Text(
                "profile",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  color: Colors.blueGrey[900],
                ),
              ),
              SizedBox(height: 40),
              CupertinoButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Consult_Profile_Page()));
                },
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "personal data",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    SizedBox(width: 122),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2),
              CupertinoButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResetPasswordScreen()));
                },
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.password_outlined,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "change password",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    SizedBox(width: 79),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2),
              CupertinoButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ConsultCards()));
                },
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.credit_card,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "credit card",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    SizedBox(width: 155),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 18),
              Divider(
                height: 15,
                thickness: 2,
              ),
              SizedBox(height: 10),
              CupertinoButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("are you sure you wanna log out??"),
                          actions: [
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.redAccent.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20)),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("NO"))),
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blueAccent,
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      rememberController.Logout();
                                      _authService.logout().then((value) =>
                                          Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                  builder: (context) =>
                                                      Login())));
                                    },
                                    child: Text(
                                      "yes",
                                      style: TextStyle(color: Colors.white),
                                    ))),
                          ],
                        );
                      });
                },
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Log out",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF333333),
                      ),
                    ),
                    SizedBox(width: 199),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
