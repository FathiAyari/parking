//import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:parking/constants/constants.dart';
import 'package:parking/models/end_user.dart';
import 'package:parking/screens/auth/sign_up/signUp_page.dart';
//import 'package:parking/Auth/auth_service.dart';
import 'package:parking/screens/client/home/NavigationBar.dart';

import '../../../services/Auth/auth_service.dart';
import '../../../services/Auth/remember_controller.dart';
import '../../admin/admin_home_page.dart';
//import 'package:parking/signUp_page.dart';

import '../forgot_password/forgot_password.dart';

AuthService _authService = new AuthService();

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isRememberMe = false;
  bool logingin = false;
  bool isVisible = true;
  RememberController rememberController = RememberController();
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

  Widget buildPassword() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Password',
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
              controller: _password_controller,
              validator: (value) {
                // ignore: valid_regexps
                if (value!.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              obscureText: isVisible,
              style: TextStyle(
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      isVisible
                          ? CupertinoIcons.eye_fill
                          : CupertinoIcons.eye_slash_fill,
                      color: Colors.indigo[400],
                    ),
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.lock, color: Color(0x660f2a7a)),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          )
        ]);
  }

  Widget buildForgotPassBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {
          Get.to(ResetPassword());
        },
        padding: EdgeInsets.only(right: 0),
        child: Text(
          'Forgot Password ?',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildRememberCb() {
    return Container(
      height: 20,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
                value: isRememberMe,
                checkColor: Colors.blue,
                activeColor: Colors.white,
                onChanged: (value) {
                  setState(() {
                    isRememberMe = value!;
                  });
                }),
          ),
          Text(
            'Remember me',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 0,
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            setState(() {
              logingin = true;
            });

            dynamic credentials = await _authService.loginUser(
                _email_controller.text.trim(),
                _password_controller.text.trim());

            print('credentials are :' + credentials.toString());

            if (credentials == null) {
              const snackBar = SnackBar(content: Text('error'));

              Fluttertoast.showToast(
                  msg: "Invalid credentials or user doesn't exists",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.grey,
                  textColor: Colors.white,
                  fontSize: 16.0);
              setState(() {
                logingin = false;
              });
            } else {
              var userData = await FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid.toString())
                  .get();
              var user = userData.get("role");
              if (user == "client") {
                rememberController.RememberClient(
                    EndUser.fromJson(userData.data() as Map<String, dynamic>));
                Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => HomePageContent()));
              } else {
                rememberController.RememberAdmin(
                    EndUser.fromJson(userData.data() as Map<String, dynamic>));
                Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => AdminHomePageScreen()));
              }
            }
          }
        },
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Color(0xff0f2a7a),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildSignUpBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Signup()));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account ?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final _formKey = GlobalKey<FormState>();
    return WillPopScope(
      onWillPop: avoidRteurnButton,
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Form(
            key: _formKey,
            child: Stack(children: <Widget>[
              Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient:
                        LinearGradient(begin: Alignment.topCenter, colors: [
                      Color(0xF20f2a7a),
                      Color(0xCC0f2a7a),
                      Color(0x990f2a7a),
                      Color(0x660f2a7a),
                    ]),
                  ),
                  child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 120),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 50),
                            buildEmail(),
                            SizedBox(height: 20),
                            buildPassword(),
                            buildForgotPassBtn(),
                            buildRememberCb(),
                            logingin
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : buildLoginBtn(),
                            SizedBox(
                              height: Constants.screenHeight * 0.1,
                            ),
                            buildSignUpBtn(),
                          ]))),
            ]),
          ),
        ),
      ),
    );
  }
}
