import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReservationDetails extends StatefulWidget {
  final QueryDocumentSnapshot queryDocumentSnapshot;
  ReservationDetails({Key? key, required this.queryDocumentSnapshot})
      : super(key: key);

  @override
  _HistoricdestialsState createState() => _HistoricdestialsState();
}

class _HistoricdestialsState extends State<ReservationDetails> {
  @override
  bool paying = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int calculateFees(DateTime start, DateTime end) {
    return end.difference(start).inHours;
  }

  var user = GetStorage().read("user");
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Colors.blue,
              onPressed: () {
                (Navigator.pop(context));
              },
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'Reservation details',
              style: TextStyle(
                color: Color(0xFF3585E2),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              alignment: Alignment.center,
              height: 195,
              child: Padding(
                padding: const EdgeInsets.only(left: 19.0),
                child: QrImage(
                  data:
                      "name:${user['name']} lastname:${user['lastname']} from : ${widget.queryDocumentSnapshot.get('start')} to : ${widget.queryDocumentSnapshot.get('end')}",
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name : ",
                  style: TextStyle(
                    fontSize: 23.5,
                    color: Colors.grey,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                Text(
                  "${user["name"]} ${user["lastname"]}",
                  style: TextStyle(
                    fontSize: 24.5,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Phone number : ",
                  style: TextStyle(
                    fontSize: 23.5,
                    color: Colors.grey,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                Container(
                  child: Text(
                    "${user['phone']}",
                    style: TextStyle(
                      fontSize: 24.5,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Registration : ",
                  style: TextStyle(
                    fontSize: 23.5,
                    color: Colors.grey,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                Text(
                  "${user['car']}",
                  style: TextStyle(
                    fontSize: 24.5,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Parking slot : ",
                  style: TextStyle(
                    fontSize: 23.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                Row(children: [
                  Text(
                    "${widget.queryDocumentSnapshot.get("placeId")}",
                    style: TextStyle(
                      fontSize: 18.5,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ]),
              ],
            ),
            Row(
              children: [
                Text(
                  "From : ",
                  style: TextStyle(
                    fontSize: 23.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                Text(
                  "${DateFormat("yyyy-MM-dd HH").format(widget.queryDocumentSnapshot.get('start').toDate())}",
                  style: TextStyle(
                    fontSize: 18.5,
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "To : ",
                  style: TextStyle(
                    fontSize: 23.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                Text(
                  "${DateFormat("yyyy-MM-dd HH").format(widget.queryDocumentSnapshot.get('end').toDate())}",
                  style: TextStyle(
                    fontSize: 18.5,
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text(
                    "Amount payed:",
                    style: TextStyle(
                      fontSize: 23.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "${calculateFees(widget.queryDocumentSnapshot.get("start").toDate(), widget.queryDocumentSnapshot.get('end').toDate())} DT",
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.blue,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 21),
            paying
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          // backgroundColor: Color(0xFF3A64EC),

                          backgroundColor:
                              MaterialStateProperty.all(Color(0xFFC12D2D)),
                        ),
                        child: Text(
                          "Delete",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () async {
                          var oldSlot = await FirebaseFirestore.instance
                              .collection("places")
                              .doc(widget.queryDocumentSnapshot.get("placeId"))
                              .update({
                            "start": DateTime(2020, 12, 12, 12),
                            "end": DateTime(2020, 12, 12, 13),
                          });
                          var matchedHistoric = await FirebaseFirestore.instance
                              .collection('users')
                              .doc(user['id'])
                              .collection("historic")
                              .get();
                          var listOfHistorucs = matchedHistoric.docs.toList();
                          for (var data in listOfHistorucs) {
                            if (data.get('start').toDate() ==
                                    widget.queryDocumentSnapshot
                                        .get("start")
                                        .toDate() &&
                                data.get('end').toDate() ==
                                    widget.queryDocumentSnapshot
                                        .get("end")
                                        .toDate()) {
                              data.reference.delete();
                            }
                          }
                          await widget.queryDocumentSnapshot.reference.delete();
                          Get.back();
                          Fluttertoast.showToast(
                              msg: "Reservation deleted with success",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                      ),
                    ),
                  )
          ])),
    );
  }
}
