import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parking/screens/client/settings/edit_profile_data.dart';

class Consult_Profile_Page extends StatefulWidget {
  const Consult_Profile_Page({Key? key}) : super(key: key);

  @override
  State<Consult_Profile_Page> createState() => _Consult_Profile_PageState();
}

class _Consult_Profile_PageState extends State<Consult_Profile_Page> {
  var user = GetStorage().read("user");

  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
            "Profile data",
            style: TextStyle(
              color: Color(0xFF1E1E1E),
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              color: Color(0xFF3585E2),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Edit_Presona8data()));
              },
            ),
          ]),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 189,
              child: Center(
                child: SvgPicture.asset(
                  'assets/images/undraw_personal_information_re_vw8a.svg',
                  height: 188,
                  width: 400,

                  // color: Colors.red,
                ),
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(user['id'])
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        SizedBox(height: 4),
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
                                    Icons.person,
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
                                            width: 200,
                                            // color: Colors.red,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 9.0, left: 5.5),
                                              child: Text(
                                                "First name",
                                                style: TextStyle(
                                                  fontSize: 19,
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
                                            width: 200,
                                            //    color: Colors.yellow,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16, left: 5),
                                              child: Text(
                                                "${snapshot.data!.get("username")}",
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
                        SizedBox(height: 0),
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
                                    Icons.person,
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
                                            width: 200,
                                            // color: Colors.red,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 9.0, left: 5.5),
                                              child: Text(
                                                "Last name",
                                                style: TextStyle(
                                                  fontSize: 19,
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
                                            width: 200,
                                            //    color: Colors.yellow,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16, left: 5),
                                              child: Text(
                                                "${snapshot.data!.get("lastname")}",
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
                        SizedBox(height: 0),
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
                                    Icons.phone,
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
                                            width: 200,
                                            // color: Colors.red,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 9.0, left: 5.5),
                                              child: Text(
                                                "Phone Number",
                                                style: TextStyle(
                                                  fontSize: 19,
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
                                            width: 200,
                                            //    color: Colors.yellow,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16, left: 5),
                                              child: Text(
                                                "${snapshot.data!.get("phone")}",
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
                                    Icons.email,
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
                                            width: 200,
                                            // color: Colors.red,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 9.0, left: 5.5),
                                              child: Text(
                                                "Email",
                                                style: TextStyle(
                                                  fontSize: 19,
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
                                            width: 200,
                                            //    color: Colors.yellow,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16, left: 5),
                                              child: Text(
                                                "${snapshot.data!.get("email")}",
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
                                    Icons.email,
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
                                            width: 200,
                                            // color: Colors.red,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 9.0, left: 5.5),
                                              child: Text(
                                                "Car's registration",
                                                style: TextStyle(
                                                  fontSize: 19,
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
                                            width: 200,
                                            //    color: Colors.yellow,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16, left: 5),
                                              child: Text(
                                                "${snapshot.data!.get("registration")}",
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
                      ],
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
          ],
        ),
      )),
    );
  }
}
