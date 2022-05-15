import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
//import 'Auth/auth_service.dart';
import 'package:intl/intl.dart';
import 'package:parking/models/end_user.dart';
import 'package:parking/screens/auth/login/loginPage.dart';

import '../../../services/Auth/auth_service.dart';

AuthService _authService = AuthService();
FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
AuthService _authServices = new AuthService();

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  //AuthService _authService = AuthService();
  DateTime expirationDate = DateTime.now();
  bool dateSelected = false;
  final _formKey = GlobalKey<FormState>(); //key for form
  TextEditingController _nomController = TextEditingController();
  TextEditingController _prenomController = TextEditingController();
  TextEditingController _telephoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController creditCardNumberController = TextEditingController();
  TextEditingController holdercontroller = TextEditingController();
  TextEditingController registrationController = TextEditingController();
  TextEditingController CCVController = TextEditingController();
//TextEditingController _passController = TextEditingController();

  Widget buildName() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'First Name',
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
            height: 50,
            child: TextFormField(
              controller: _nomController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                  return 'incorrecte name';
                }
                return null;
              },

              //keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 4.6, left: 11),
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          )
        ]);
  }

  Widget buildLastName() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Last Name',
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
            height: 50,
            child: TextFormField(
              controller: _prenomController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                  return 'incorrecte name';
                }
                return null;
              },
              //keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 4.6, left: 11),
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          )
        ]);
  }

  Widget buildCreditCard() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Credit card',
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
            height: 50,
            child: TextFormField(
              controller: creditCardNumberController,
              validator: (value) {
                if (value!.length < 18) {
                  return 'Please enter a valid card';
                } else
                  return null;
              },
              //keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 4.6, left: 11),
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          )
        ]);
  }

  Widget buildHolder() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Holder name ',
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
            height: 50,
            child: TextFormField(
              controller: holdercontroller,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a valid name';
                } else
                  return null;
              },
              //keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 4.6, left: 11),
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          )
        ]);
  }

  Widget buildExpirationDate() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () async {
            showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2200))
                .then((value) {
              setState(() {
                expirationDate = value!;
                dateSelected = true;
              });
            });
          },
          child: Text(dateSelected
              ? "${DateFormat("MM-dd").format(expirationDate)}"
              : "Expiration date")),
    );
  }

  Widget buildCCV() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'CCV',
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
            height: 50,
            child: TextFormField(
              controller: CCVController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter ccv';
                }

                return null;
              },
              //keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Colors.black87,
              ),

              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 4.6, left: 11),
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          )
        ]);
  }

  Widget buildRegistration() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Car's registration",
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
            height: 50,
            child: TextFormField(
              controller: registrationController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter registration';
                }

                return null;
              },
              //keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Colors.black87,
              ),

              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 4.6, left: 11),
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          )
        ]);
  }

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
            height: 50,
            child: TextFormField(
              controller: _emailController,
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
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          )
        ]);
  }

  Widget buildPhoneNumber() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'PhoneNumber',
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
            height: 50,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: _telephoneController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'phone cannot be empty';
                }
                if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                  return 'Please enter valid phone number';
                }
                return null;
              },
              //keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 4.6, left: 11),

                hintStyle: TextStyle(color: Colors.black38),
                // contentPadding: const EdgeInsets.only(top: 5),
              ),
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
            height: 50,
            child: TextFormField(
              controller: _passwordController,
              validator: (value) {
                // ignore: valid_regexps
                if (value!.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              obscureText: true,
              style: TextStyle(
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          )
        ]);
  }

  Widget buildConfirmpass() {
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
            height: 50,
            child: TextFormField(
              controller: _passwordController,
              validator: (value) {
                // ignore: valid_regexps
                if (value!.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              obscureText: true,
              style: TextStyle(
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(Icons.lock, color: Color(0x660f2a7a)),
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          )
        ]);
  }

//class _SignupState extends State<Signup> {
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Form(
          key: _formKey,
          child: Stack(children: <Widget>[
            Container(
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
                child: ListView(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Stepper(
                      steps: [
                        Step(
                            title: Text("Personal informations"),
                            content: Column(
                              children: [
                                buildName(),
                                SizedBox(height: 15),
                                buildLastName(),
                                SizedBox(height: 15),
                                buildPhoneNumber(),
                              ],
                            )),
                        Step(
                            title: Text("Authentication informations"),
                            content: Column(
                              children: [
                                SizedBox(height: 15),
                                buildEmail(),
                                SizedBox(height: 15),
                                buildPassword(),
                              ],
                            )),
                        Step(
                            title: Text("Financial informations"),
                            content: Column(
                              children: [
                                buildHolder(),
                                SizedBox(height: 15),
                                buildCreditCard(),
                                SizedBox(height: 15),
                              ],
                            )),
                        Step(
                            title: Text("Financial informations 2 "),
                            content: Column(
                              children: [
                                buildExpirationDate(),
                                SizedBox(height: 15),
                                buildCCV(),
                              ],
                            )),
                        Step(
                            title: Text("Car's informations"),
                            content: Column(
                              children: [
                                SizedBox(height: 15),
                                buildRegistration(),
                              ],
                            )),
                      ],
                      onStepCancel: () {
                        if (currentStep != 0) {
                          setState(() {
                            currentStep -= 1;
                          });
                        }
                      },
                      onStepContinue: () async {
                        if (currentStep != 4) {
                          setState(() {
                            currentStep += 1;
                          });
                        } else if (_formKey.currentState!.validate()) {
                          Fluttertoast.showToast(
                              msg: "Loading",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          dynamic credentials = await _authService.registerUser(
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                          );
                          EndUser endUser = EndUser(
                              username: _nomController.text,
                              lastname: _prenomController.text,
                              email: _emailController.text,
                              phone: _telephoneController.text,
                              ccv: CCVController.text,
                              cardHolder: holdercontroller.text,
                              creditCard: creditCardNumberController.text,
                              registration: registrationController.text,
                              expirationDate:
                                  expirationDate.toString().split(" ")[0],
                              uid: _firebaseAuth.currentUser!.uid);

                          if (credentials == null) {
                            const snackBar = SnackBar(
                              content: Text('Email/Password are invalid'),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } else {
                            _authServices
                                .createUserDocument(
                                    _firebaseAuth.currentUser!.uid,
                                    endUser,
                                    "client")
                                .then((value) => Get.offAll(Login()));
                          }
                        }
                      },
                      currentStep: currentStep,
                      onStepTapped: (index) {
                        setState(() {
                          currentStep = index;
                        });
                      }),

                  //buildForgotPassBtn(),
                  // buildRememberCb(),
                  // buildLoginBtn(),
                  // buildSignUpBtn(),
                ])),
          ]),
        ),
      ),
    );
  }
}
