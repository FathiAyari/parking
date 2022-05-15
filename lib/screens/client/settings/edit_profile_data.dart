import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parking/constants/constants.dart';
import 'package:parking/models/end_user.dart';

class Edit_Presona8data extends StatefulWidget {
  const Edit_Presona8data({Key? key}) : super(key: key);

  @override
  State<Edit_Presona8data> createState() => _Edit_Presona8dataState();
}

class _Edit_Presona8dataState extends State<Edit_Presona8data> {
  TextEditingController nameControlelr = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController registrationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  getUserData() async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .doc(user['id'])
        .get();

    EndUser endUser = EndUser.fromJson(data.data() as Map<String, dynamic>);
    setState(() {
      nameControlelr.text = endUser.username!;
      lastnameController.text = endUser.lastname!;
      registrationController.text = endUser.registration!;
      phoneController.text = endUser.phone!;
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
    return SafeArea(
      child: Scaffold(
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
            "Edit Profile data",
            style: TextStyle(
              color: Color(0xFF1E1E1E),
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
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
                          SizedBox(
                            height: Constants.screenHeight * 0.1,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(0, 2)),
                                ]),
                            height: 60,
                            child: TextFormField(
                              validator: (value) {
                                // ignore: valid_regexps
                                if (value!.isEmpty) {
                                  return 'Please enter some text';
                                }
                                if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return 'incorrecte email adress';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14),
                                  prefixIcon: Icon(Icons.account_circle,
                                      color: Color(0x660f2a7a)),
                                  label: Text("First name"),
                                  hintStyle: TextStyle(color: Colors.black38)),
                              controller: nameControlelr,
                            ),
                          ),
                          SizedBox(
                            height: Constants.screenHeight * 0.03,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(0, 2)),
                                ]),
                            height: 60,
                            child: TextFormField(
                              controller: lastnameController,
                              validator: (value) {
                                // ignore: valid_regexps
                                if (value!.isEmpty) {
                                  return 'Please enter some text';
                                }
                                if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return 'incorrecte email adress';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                              decoration: InputDecoration(
                                  label: Text("Last name"),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14),
                                  prefixIcon: Icon(Icons.account_circle,
                                      color: Color(0x660f2a7a)),
                                  hintStyle: TextStyle(color: Colors.black38)),
                            ),
                          ),
                          SizedBox(
                            height: Constants.screenHeight * 0.03,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(0, 2)),
                                ]),
                            height: 60,
                            child: TextFormField(
                              controller: registrationController,
                              validator: (value) {
                                // ignore: valid_regexps
                                if (value!.isEmpty) {
                                  return 'Please enter some text';
                                }
                                if (!RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                                  return 'incorrecte email adress';
                                }
                                return null;
                              },
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14),
                                  prefixIcon: Icon(Icons.car_rental,
                                      color: Color(0x660f2a7a)),
                                  label: Text("Car's registration"),
                                  hintStyle: TextStyle(color: Colors.black38)),
                            ),
                          ),
                          SizedBox(
                            height: Constants.screenHeight * 0.03,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(0, 2)),
                                ]),
                            height: 60,
                            child: TextFormField(
                              controller: phoneController,
                              validator: (value) {
                                // ignore: valid_regexps
                                if (value!.isEmpty) {
                                  return 'Please enter phone number';
                                }

                                return null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14),
                                  prefixIcon: Icon(Icons.phone,
                                      color: Color(0x660f2a7a)),
                                  label: Text("Phone number"),
                                  hintStyle: TextStyle(color: Colors.black38)),
                            ),
                          ),
                          loading
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          setState(() {
                                            loading = true;
                                          });
                                          await snapshot.data!.reference
                                              .update({
                                            "name": nameControlelr.text,
                                            "lastname": lastnameController.text,
                                            "phone": phoneController.text,
                                            "registration":
                                                registrationController.text,
                                          });
                                          Future.delayed(
                                              Duration(milliseconds: 100), () {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Data updated successfully",
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
                                        child: Text("Save Data")),
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
            ],
          ),
        ),
      ),
    );
  }
}
