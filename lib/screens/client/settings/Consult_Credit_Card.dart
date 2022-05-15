import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

import '../../../models/end_user.dart';

class ConsultCards extends StatefulWidget {
  const ConsultCards({Key? key}) : super(key: key);

  @override
  State<ConsultCards> createState() => _ConsultCardsState();
}

class _ConsultCardsState extends State<ConsultCards> {
  TextEditingController cardnumber = TextEditingController();
  TextEditingController expiry = TextEditingController();
  TextEditingController ccv = TextEditingController();
  TextEditingController cardHolder = TextEditingController();
  late EndUser endUser;

  getUserData() async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user['id'])
        .get();
    EndUser endUser = EndUser.fromJson(data.data() as Map<String, dynamic>);
    setState(() {
      cardnumber.text = endUser.creditCard!;
      expiry.text = endUser.expirationDate!.toString();
      ccv.text = endUser.ccv!;
      cardHolder.text = endUser.cardHolder!;
    });
  }

  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  var user = GetStorage().read("user");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Color(0xFF3585E2),
          onPressed: () {
            (Navigator.pop(context));
          },
        ),
        centerTitle: true,
        title: Text(
          "Your Payment Card",
          style: TextStyle(
            color: Color(0xFF1E1E1E),
            fontWeight: FontWeight.w700,
            fontSize: 23,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              alignment: Alignment.center,
              height: 179,
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/Credit Card_Monochromatic.svg',
                  height: 190,

                  // color: Colors.red,
                ),
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user['id'])
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        SizedBox(height: 14),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Row(
                            children: [
                              Text(
                                "Add Credit Card",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 23,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 3),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Row(
                            children: [
                              Text(
                                "please add your credit card information",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color(0xFFE2F0FF),
                            ),
                            child: Container(
                              child: Row(children: [
                                Container(
                                  // color: Colors.green,
                                  width: 44,
                                  height: 80,
                                  child: Icon(
                                    Icons.person_outline,
                                    color: Color(0xFF3585E2),
                                  ),
                                ),
                                SizedBox(width: 0),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0, left: 0),
                                          child: Container(
                                            height: 30,
                                            width: 270,
                                            // color: Colors.red,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 9.0),
                                              child: Text(
                                                "Card holder name",
                                                style: TextStyle(
                                                  fontSize: 19.5,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 1),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 0, left: 0),
                                          child: Container(
                                            height: 49,
                                            width: 270,
                                            //    color: Colors.yellow,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 13.0),
                                              child: TextFormField(
                                                controller: cardHolder,
                                                decoration:
                                                    const InputDecoration(
                                                  border:
                                                      UnderlineInputBorder(),
                                                  // labelText: 'Enter your username',
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Container(
                            //width: ,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color(0xFFE2F0FF),
                            ),

                            child: Container(
                              child: Row(children: [
                                Container(
                                  // color: Colors.green,
                                  width: 44,
                                  height: 80,
                                  child: Icon(
                                    Icons.tag,
                                    color: Color(0xFF3585E2),
                                  ),
                                ),
                                SizedBox(width: 0),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0, left: 0),
                                          child: Container(
                                            height: 30,
                                            width: 270,
                                            // color: Colors.red,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 9.0),
                                              child: Text(
                                                "Card number",
                                                style: TextStyle(
                                                  fontSize: 19.5,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 1),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 0, left: 0),
                                          child: Container(
                                            height: 49,
                                            width: 270,
                                            //    color: Colors.yellow,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 13.0),
                                              child: TextFormField(
                                                controller: cardnumber,
                                                decoration:
                                                    const InputDecoration(
                                                  border:
                                                      UnderlineInputBorder(),
                                                  // labelText: 'Enter your username',
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ]),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 164,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Color(0xFFE2F0FF),
                                    ),
                                    child: Container(
                                      child: Row(children: [
                                        SizedBox(width: 0),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0, left: 0),
                                                  child: Container(
                                                    height: 30,
                                                    width: 160,
                                                    // color: Colors.red,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 9.0,
                                                              left: 8),
                                                      child: Text(
                                                        "Expiry date",
                                                        style: TextStyle(
                                                          fontSize: 19,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 1),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 0, left: 0),
                                                  child: Container(
                                                    height: 49,
                                                    width: 130,
                                                    //    color: Colors.yellow,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 13.0),
                                                      child: TextFormField(
                                                        controller: expiry,
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              UnderlineInputBorder(),
                                                          // labelText: 'Enter your username',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 12),
                              Column(
                                children: [
                                  Container(
                                    width: 164,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Color(0xFFE2F0FF),
                                    ),
                                    child: Container(
                                      child: Row(children: [
                                        SizedBox(width: 0),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0, left: 0),
                                                  child: Container(
                                                    height: 30,
                                                    width: 160,
                                                    // color: Colors.red,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 9.0,
                                                              left: 8),
                                                      child: Text(
                                                        "CVV",
                                                        style: TextStyle(
                                                          fontSize: 19,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 1),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 0, left: 0),
                                                  child: Container(
                                                    height: 49,
                                                    width: 130,
                                                    //    color: Colors.yellow,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 13.0),
                                                      child: TextFormField(
                                                        controller: ccv,
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              UnderlineInputBorder(),
                                                          // labelText: 'Enter your username',
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ]),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        loading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Container(
                                // margin: EdgeInsets.only(right: 10,left: 10),
                                width: 312,
                                height: 45,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    // backgroundColor: Color(0xFF3A64EC),

                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xFF2DC194)),
                                  ),
                                  child: Text(
                                    "Save Card Details",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                    ),
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      loading = true;
                                    });
                                    await snapshot.data!.reference.update({
                                      "creditCard": cardnumber.text,
                                      "cardHolder": cardHolder.text,
                                      "expirationDate": expiry.text,
                                      "ccv": ccv.text,
                                    });
                                    Future.delayed(Duration(milliseconds: 100),
                                        () {
                                      Fluttertoast.showToast(
                                          msg: "Data updated successfully",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.grey,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                      setState(() {
                                        loading = false;
                                      });
                                    });
                                  },
                                ),
                              )
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
          ]),
        ),
      ),
    );
  }
}
