import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constants/constants.dart';
import '../../models/reservation.dart';

class Reservations extends StatefulWidget {
  const Reservations({Key? key}) : super(key: key);

  @override
  _ReservationsState createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  late List<Reservation> listOfrservations;
  getReservation() async {
    var users = await FirebaseFirestore.instance
        .collection("users")
        .where("role", isEqualTo: "client")
        .get();
    List<Reservation> listOfReservation = [];
    for (var user in users.docs.toList()) {
      var reservations = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.id)
          .collection("reservations")
          .get();
      for (var reservation in reservations.docs.toList()) {
        listOfReservation.add(
            Reservation.fromJson(reservation.data() as Map<String, dynamic>));
      }
    }
    setState(() {
      this.listOfrservations = listOfReservation;
    });
    return listOfReservation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: Constants.screenHeight * 0.3,
            child: Text("The Reservations"),
          ),
          Expanded(
            child: FutureBuilder(
                future: getReservation(),
                builder: (
                  context,
                  AsyncSnapshot snapshot,
                ) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(20)),
                              child: ExpansionTile(
                                title: Text(
                                  " Start : ${DateFormat("yyyy-MM-dd").format(listOfrservations[index].start!)}  End : ${DateFormat("yyyy-MM-dd").format(listOfrservations[index].end!)}",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                children: <Widget>[
                                  ListTile(
                                    title: StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection("users")
                                            .doc(
                                                listOfrservations[index].userId)
                                            .snapshots(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<
                                                    DocumentSnapshot<
                                                        Map<String, dynamic>>>
                                                snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                              "Name : ${snapshot.data!.get("username")} ${snapshot.data!.get("lastname")}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700),
                                            );
                                          } else {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        }),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          )
        ],
      ),
    );
  }
}
