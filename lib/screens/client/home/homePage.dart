import 'package:flutter/material.dart';

import '../../../date/pickdateandtime.dart';
//import 'date/picker.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _MaraState();
}

class _MaraState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE2F0FF),
      body: SafeArea(
        child: Column(children: [
          Container(
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/pexels-photo-690271.jpg',
                  width: double.infinity,
                  height: 240.0,
                  fit: BoxFit.cover,
                ),
                Positioned(
                    left: 30.0,
                    top: 90.0,
                    child: Text(
                      'HELLO',
                      style: TextStyle(
                        fontFamily: 'Motserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 28.0,
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
          ),
          SizedBox(height: 80.0),
          Container(
              margin: EdgeInsets.only(left: 8, right: 4),
              //width: MediaQuery.of(context).size.width,
              height: 108,
              decoration: BoxDecoration(
                // color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    // Alignment(0.0, 0.0), // 10% of the width, so there are ten blinds.
                    colors: <Color>[
                      Color(0xFF151176),
                      Color(0xFF4546C9),
                    ]),
              ),
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Pick_datetime()));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Colors.blue,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.add_box_rounded,
                          color: Colors.white,
                          size: 100,
                        ),
                        SizedBox(width: 7),
                        Text(
                          'New Reservation',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )),
        ]),
      ),
    );
  }
}
