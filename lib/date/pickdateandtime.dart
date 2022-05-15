import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:parking/constants/constants.dart';

import '../screens/client/reservations/floors.dart';

class Pick_datetime extends StatefulWidget {
  const Pick_datetime({Key? key}) : super(key: key);

  @override
  State<Pick_datetime> createState() => _Pick_datetimeState();
}

class _Pick_datetimeState extends State<Pick_datetime> {
  DateTime startDateTime = DateTime.now();
  DateTime endDateTime = DateTime.now();
  bool startSelcted = false;
  bool endSelcted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.blueAccent, //change your color here
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: Constants.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Constants.screenHeight * 0.2),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFF2DC194)),
                      ),
                      child: const Text(
                        'Select start date',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () async {
                        showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100))
                            .then((date) {
                          if (date == null) return;
                          showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now())
                              .then((time) {
                            if (time == null) return;
                            setState(() {
                              startSelcted = true;
                              startDateTime = DateTime(
                                  date.year, date.month, date.day, time.hour);
                            });
                          });
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Visibility(
                      visible: startSelcted,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${DateFormat("yyyy-MM-dd HH-mm").format(startDateTime)}",
                          style: TextStyle(
                              fontSize: Constants.screenHeight * 0.02),
                        ),
                      )),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFF2DC194)),
                      ),
                      child: const Text(
                        'Select end date',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: () async {
                        if (startDateTime == null) return;
                        showTimePicker(
                                context: context, initialTime: TimeOfDay.now())
                            .then((time) {
                          if (time == null) return;
                          setState(() {
                            endSelcted = true;
                            endDateTime = DateTime(
                              startDateTime.year,
                              startDateTime.month,
                              startDateTime.day,
                              time.hour,
                            );
                          });
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Visibility(
                      visible: endSelcted,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${DateFormat("yyyy-MM-dd HH-mm").format(endDateTime)}",
                          style: TextStyle(
                              fontSize: Constants.screenHeight * 0.02),
                        ),
                      )),
                )
              ],
            ),
            SizedBox(height: Constants.screenHeight * 0.2),
            Container(
              alignment: Alignment.topCenter,
              width: double.infinity,
              child: Container(
                child: ElevatedButton(
                  onPressed: () {
                    if ((startSelcted &&
                        endSelcted &&
                        startDateTime.isBefore(endDateTime))) {
                      Get.to(Floors(
                        start: startDateTime,
                        end: endDateTime,
                      ));
                    } else {
                      Fluttertoast.showToast(
                          msg: "select a valid  start and end date",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueAccent),
                  ),
                  child: Text("pick place",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
