import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

import '../../constants/constants.dart';
import '../admin/admin_home_page.dart';
import '../auth/login/loginPage.dart';
import '../client/home/NavigationBar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var resultSeen = GetStorage().read("seen");
  var auth = GetStorage().read("auth");

  var type_auth = GetStorage().read("type_auth");
  @override
  void initState() {
    super.initState();
    var timer = Timer(
        Duration(seconds: 5),
        () => Get.to((auth == 1
            ? (type_auth == 1 ? AdminHomePageScreen() : HomePageContent())
            : Login())));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: const BoxDecoration(),
            child: Column(children: <Widget>[
              SizedBox(
                height: size.height * 0.2,
              ),
              Image(
                image: AssetImage('assets/images/parking.png'),
                height: Constants.screenHeight * 0.1,
                width: Constants.screenWidth * 0.3,
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Text(
                Constants.HomeText,
                style: TextStyle(color: Colors.blueAccent, fontSize: 25),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Lottie.asset("assets/images/parking.json",
                  height: Constants.screenHeight * 0.3),
            ])));
  }
}
