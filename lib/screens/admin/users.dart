import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parking/models/end_user.dart';

import '../../constants/constants.dart';

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  _FeesState createState() => _FeesState();
}

class _FeesState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: Constants.screenHeight * 0.3,
            child: Text("Users"),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .where("role", isEqualTo: "client")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.length != 0) {
                    var users = snapshot.data!.docs.toList();
                    List<EndUser> listOfUsers = [];
                    for (var user in users) {
                      listOfUsers.add(EndUser.fromJson(
                          user.data() as Map<String, dynamic>));
                    }
                    return ListView.builder(
                        itemCount: listOfUsers.length,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.green.withOpacity(0.5),
                                ),
                                child: ExpansionTile(
                                  title: Text(
                                    "${listOfUsers[index].username} ${listOfUsers[index].lastname}",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  children: <Widget>[
                                    ListTile(
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            " Phone Number :${listOfUsers[index].phone} ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            " Email :${listOfUsers[index].email}  ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            " Registration :${listOfUsers[index].registration}  ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return Center(
                      child: Text(" no user yet"),
                    );
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    ));
  }
}
