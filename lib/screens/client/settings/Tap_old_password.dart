import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parking/services/Auth/auth_service.dart';
import 'package:parking/services/Auth/remember_controller.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final ButtonStyle style = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    padding: EdgeInsets.symmetric(horizontal: 39),
    elevation: 2,

    // backgroundColor: MaterialStateProperty.all(Color(0xFF3585E2)),
  );
  RememberController rememberController = RememberController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  var user = GetStorage().read("user");
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Row(children: [
                    IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        color: Color(0xFF3585E2),
                        onPressed: () {
                          (Navigator.pop(context));
                        }),
                    SizedBox(width: 40),
                  ])),
              SizedBox(height: 40),
              Container(
                height: 200,
                child: SvgPicture.asset(
                  'assets/images/undraw_security_on_re_e491.svg',
                  height: 190,

                  // color: Colors.red,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 70),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 22, right: 22),
                      child: TextFormField(
                        obscureText: true,
                        controller: oldPassword,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 8) {
                            return " enter a valid password ";
                          }
                        },
                        decoration: InputDecoration(
                            label: Text("old password"),
                            //contentPadding: EdgeInsets.only(bottom: 1),
                            //labelText: labelText,
                            //floatingLabelBehavior: FloatingLabelBehavior.always,
                            // hintText: placeholder,
                            hintStyle: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 22, right: 22),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length < 8) {
                            return " enter a valid password ";
                          }
                        },
                        controller: newPassword,
                        obscureText: false,
                        decoration: InputDecoration(
                            label: Text("new password"),
                            //contentPadding: EdgeInsets.only(bottom: 1),
                            //labelText: labelText,
                            //floatingLabelBehavior: FloatingLabelBehavior.always,
                            // hintText: placeholder,
                            hintStyle: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
              loading
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : ElevatedButton(
                      // backgroundColor: MaterialStateProperty.all(Color(0xFF3585E2)),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          var instance = FirebaseAuth.instance.currentUser;
                          dynamic credentials = await AuthService()
                              .loginUser(user['email'], oldPassword.text);
                          if (credentials != null) {
                            instance?.updatePassword(newPassword.text);
                            setState(() {
                              loading = false;
                            });
                            Fluttertoast.showToast(
                                msg: "Password has been changed successfully ",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            rememberController.Logout();
                          } else {
                            setState(() {
                              loading = false;
                            });

                            Fluttertoast.showToast(
                                msg: "old password is invalid ",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        }
                      },
                      style: style,
                      child: Text(
                        "Change password",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
