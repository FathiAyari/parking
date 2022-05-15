import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class payment extends StatefulWidget {
  final QueryDocumentSnapshot queryDocumentSnapshot;
  final DateTime start;
  final DateTime end;
  const payment(
      {Key? key,
      required this.queryDocumentSnapshot,
      required this.start,
      required this.end})
      : super(key: key);

  @override
  State<payment> createState() => _paymentState();
}

class _paymentState extends State<payment> {
  int calculateFees(DateTime start, DateTime end) {
    return end.difference(start).inHours;
  }

  var user = GetStorage().read("user");

  bool paying = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            'Booking details',
            style: TextStyle(
              color: Color(0xFF3585E2),
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            alignment: Alignment.center,
            height: 195,
            child: Padding(
              padding: const EdgeInsets.only(left: 19.0),
              child: SvgPicture.asset(
                'assets/images/undraw_booking_re_gw4j (5).svg',
                height: 190,

                // color: Colors.red,
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
                "${DateFormat("yyyy-MM-dd HH").format(widget.start)}",
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
                "${DateFormat("yyyy-MM-dd HH").format(widget.end)}",
                style: TextStyle(
                  fontSize: 18.5,
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SizedBox(height: 17.1),
          SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.only(left: 21),
            child: Row(children: []),
          ),
          SizedBox(height: 2),
          SizedBox(height: 17),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Text(
                  "Amount to pay :",
                  style: TextStyle(
                    fontSize: 23.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  "${calculateFees(widget.start, widget.end)} DT",
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
                            MaterialStateProperty.all(Color(0xFF2DC194)),
                      ),
                      child: Text(
                        "Pay",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          paying = true;
                        });
                        await widget.queryDocumentSnapshot.reference
                            .update({"start": widget.start, "end": widget.end});
                        var data = await FirebaseFirestore.instance
                            .collection("places")
                            .doc(
                                "${widget.queryDocumentSnapshot.get("placeId")}")
                            .get();
                        var start = data["start"];
                        var end = data["end"];

                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(user['id'])
                            .collection("historic")
                            .add({
                          "registration": user['car'],
                          "start": start.toDate(),
                          "end": end.toDate(),
                          "placeId":
                              widget.queryDocumentSnapshot.get("placeId"),
                        });

                        await FirebaseFirestore.instance
                            .collection("users")
                            .doc(user['id'])
                            .collection("reservations")
                            .add({
                          "start": start.toDate(),
                          "end": end.toDate(),
                          "userId": user['id'],
                          "placeId":
                              widget.queryDocumentSnapshot.get("placeId"),
                        });
                        var fees = await FirebaseFirestore.instance
                            .collection("fees")
                            .doc(
                                "${DateFormat("yyyy-MM-dd").format(DateTime.now())}")
                            .get();
                        if (fees.exists) {
                          var feesData = fees.get("fees");
                          await FirebaseFirestore.instance
                              .collection("fees")
                              .doc(
                                  "${DateFormat("yyyy-MM-dd").format(DateTime.now())}")
                              .set({
                            "fees": feesData +
                                calculateFees(widget.start, widget.end)
                          });
                        } else {
                          await FirebaseFirestore.instance
                              .collection("fees")
                              .doc(
                                  "${DateFormat("yyyy-MM-dd").format(DateTime.now())}")
                              .set({
                            "fees": calculateFees(widget.start, widget.end)
                          });
                        }

                        Future.delayed(const Duration(milliseconds: 500), () {
                          setState(() {
                            paying = false;
                          });
                          Fluttertoast.showToast(
                              msg: "Booking has been reserved successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        });
                      },
                    ),
                  ),
                )
        ])));
  }
}
