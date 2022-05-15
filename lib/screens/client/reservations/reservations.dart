import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:parking/models/reservation.dart';
import 'package:parking/screens/client/reservations/reservation_details.dart';

import '../../../constants/constants.dart';

class Reservations extends StatefulWidget {
  const Reservations({Key? key}) : super(key: key);

  @override
  _ReservationsState createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  var user = GetStorage().read("user");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Reservations",
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
              .collection("reservations")
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
                      return GestureDetector(
                        onTap: () {
                          if (DateTime.now()
                              .isBefore(listOfReservations[index].start!)) {
                            Get.to(ReservationDetails(
                              queryDocumentSnapshot: snapshot.data!.docs[index],
                            ));
                          }
                        },
                        child: Padding(
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
                                        "Start : ${DateFormat("yyyy-mm-dd HH").format(listOfReservations[index].start!)}"),
                                    Text(
                                        "End : ${DateFormat("yyyy-mm-dd HH").format(listOfReservations[index].end!)}"),
                                    if (DateTime.now().isBefore(
                                        listOfReservations[index].start!)) ...[
                                      Text("Status : Not started yet "),
                                    ]
                                  ],
                                ),
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
