import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:parking/constants/constants.dart';

import '../../../models/reservation.dart';

class Historic extends StatefulWidget {
  const Historic({Key? key}) : super(key: key);

  @override
  State<Historic> createState() => _QruState();
}

class _QruState extends State<Historic> {
  var user = GetStorage().read("user");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Historics",
            style: TextStyle(color: Colors.blueAccent),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: Colors.blueAccent, //change your color here
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc("${user['id']}")
              .collection("historic")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.length != 0) {
                var listOfData = snapshot.data!.docs.toList();
                List<Reservation> listOfReservations = [];
                for (var data in listOfData) {
                  listOfReservations.add(Reservation.fromJson(
                      data.data() as Map<String, dynamic>));
                }
                return ListView.builder(
                    itemCount: listOfReservations.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: Constants.screenHeight * 0.15,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade500,
                              borderRadius: BorderRadius.circular(20)),
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Spot id : ${listOfReservations[index].placeId}"),
                                  Text(
                                      "Start : ${DateFormat("yyyy-MM-dd HH:mm").format(listOfReservations[index].start!)}"),
                                  Text(
                                      "End : ${DateFormat("yyyy-MM-dd HH:mm").format(listOfReservations[index].end!)}"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return Center(
                  child: Container(
                    height: Constants.screenHeight * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset("assets/images/error.json",
                            repeat: false,
                            height: Constants.screenHeight * 0.1),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("No reservation yet"),
                        ),
                      ],
                    ),
                  ),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
