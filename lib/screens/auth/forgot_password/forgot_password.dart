//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:parking/constants/constants.dart';
import 'package:parking/screens/auth/login/loginPage.dart';
import 'package:parking/services/Auth/auth_service.dart';

//import 'package:parking/signUp_page.dart';

import '../../client/components/alert_task.dart';

AuthService _authService = new AuthService();

class ResetPassword extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<ResetPassword> {
  bool loading = false;

  final _formKey = GlobalKey<FormState>(); //key for form
  // AuthService _authService = new AuthService();
  TextEditingController _email_controller = TextEditingController();
  TextEditingController _password_controller = TextEditingController();
  Widget buildEmail() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Email',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 2)),
                ]),
            height: 60,
            child: TextFormField(
              controller: _email_controller,
              validator: (value) {
                // ignore: valid_regexps
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
                  return 'incorrecte email adress';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.email, color: Color(0x660f2a7a)),
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          )
        ]);
  }

  Widget ResetButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 0,
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            setState(() {
              loading = true;
            });
            AuthService().resetPassword(_email_controller.text).then((value) {
              setState(() {
                loading = false;
              });
              if (value) {
                alertTask(
                  lottieFile: "assets/images/success.json",
                  action: "Connecter",
                  message: "Check your email",
                  press: () {
                    Get.to(() => Login());
                  },
                ).show(context);
              } else {
                alertTask(
                  lottieFile: "assets/images/error.json",
                  action: "Retry",
                  message: "account doesn't exists ",
                  press: () {
                    Navigator.pop(context);
                  },
                ).show(context);
              }
            });
          }
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: Text(
          'Reset',
          style: TextStyle(
            color: Color(0xff0f2a7a),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                Color(0xF20f2a7a),
                Color(0xCC0f2a7a),
                Color(0x990f2a7a),
                Color(0x660f2a7a),
              ]),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  Text(
                    'Reset Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 50),
                  Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: buildEmail(),
                      )),
                  SizedBox(height: 20),
                  loading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Constants.screenWidth * 0.2),
                          child: Container(
                              width: double.infinity, child: ResetButton()),
                        ),
                  SizedBox(
                    height: Constants.screenHeight * 0.1,
                  ),
                ])),
      ),
    );
  }
}
