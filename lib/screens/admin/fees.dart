import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parking/constants/constants.dart';

import '../../services/Auth/remember_controller.dart';

class Fees extends StatefulWidget {
  const Fees({Key? key}) : super(key: key);

  @override
  _FeesState createState() => _FeesState();
}

class _FeesState extends State<Fees> {
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
            title: Text("Are you sure you wanna exit "),
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
      child: SafeArea(
          child: Scaffold(
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  height: Constants.screenHeight * 0.07,
                  child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("are you sure you wanna log out??"),
                                actions: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Colors.redAccent.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(20)),
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
                                          },
                                          child: Text(
                                            "yes",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))),
                                ],
                              );
                            });
                      },
                      child: Text("Log out"))),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: Constants.screenHeight * 0.3,
              child: Text("The daily incoming fees"),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("fees").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.length != 0) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20)),
                                child: ExpansionTile(
                                  title: Text(
                                    "${(snapshot.data!.docs[index].id)}",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  children: <Widget>[
                                    ListTile(
                                      title: Text(
                                        "${snapshot.data!.docs[index].get("fees")} DT",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return Center(
                        child: Text(" no fees yet"),
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}
