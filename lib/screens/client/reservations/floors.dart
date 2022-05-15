import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:parking/models/reservation.dart';
import 'package:parking/screens/client/reservations/payement.dart';

class Floors extends StatefulWidget {
  final DateTime start;
  final DateTime end;
  const Floors({Key? key, required this.start, required this.end})
      : super(key: key);

  @override
  _FloorsState createState() => _FloorsState();
}

class _FloorsState extends State<Floors> with TickerProviderStateMixin {
  late TabController _tabController;
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick spot"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 10),
            child: Container(
              alignment: Alignment.center,
              child: TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.blueAccent,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueAccent),
                controller: _tabController,
                tabs: [
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text("1st floor")),
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text("2nd floor")),
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(" 3rd floor ")),
                  Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(" 4th floor ")),
                ],
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: TabBarView(
                controller: _tabController,
                children: [
                  buildFloor(
                    end: widget.end,
                    floorId: "1",
                    start: widget.start,
                  ),
                  buildFloor(
                    end: widget.end,
                    start: widget.start,
                    floorId: "2",
                  ),
                  buildFloor(
                    end: widget.end,
                    start: widget.start,
                    floorId: "3",
                  ),
                  buildFloor(
                    start: widget.start,
                    end: widget.end,
                    floorId: "4",
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}

class buildFloor extends StatelessWidget {
  buildFloor({
    Key? key,
    required this.floorId,
    required this.start,
    required this.end,
  }) : super(key: key);
  final String floorId;
  final DateTime start;
  final DateTime end;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("places")
          .where("floorId", isEqualTo: floorId)
          .orderBy("index")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var listOfData = snapshot.data!.docs.toList();
          List<Reservation> listOfReservation = [];
          print(listOfData.length);
          for (var data in listOfData) {
            listOfReservation
                .add(Reservation.fromJson(data.data() as Map<String, dynamic>));
          }

          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 2,
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10),
              itemCount: listOfReservation.length,
              itemBuilder: (context, index) {
                if (DateTime.now().isAfter(listOfReservation[index].start!) &&
                    DateTime.now().isBefore(listOfReservation[index].end!)) {
                  return reservedCar();
                } else if (DateTime.now()
                    .isAfter(listOfReservation[index].end!)) {
                  return unReservedCar(
                      context,
                      listOfReservation[index].placeId!,
                      snapshot.data!.docs[index],
                      start,
                      end);
                } else if (DateTime.now()
                    .isBefore(listOfReservation[index].start!)) {
                  return reservedCar();
                } else {
                  return Container(
                    child: Text(""),
                  );
                }
              });
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  GestureDetector reservedCar() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: SvgPicture.asset(
            'assets/images/whiteCar.svg',
          ),
        ),
      ),
    );
  }

  GestureDetector unReservedCar(
      BuildContext context,
      String placeId,
      QueryDocumentSnapshot queryDocumentSnapshot,
      DateTime start,
      DateTime end) {
    return GestureDetector(
      onTap: () {
        Get.to(payment(
          queryDocumentSnapshot: queryDocumentSnapshot,
          start: start,
          end: end,
        ));
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white),
        ),
        child: Text(
          "$placeId",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
