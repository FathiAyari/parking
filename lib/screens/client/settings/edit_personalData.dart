import 'package:flutter/material.dart';

class EditpersonalData extends StatefulWidget {
  const EditpersonalData({ Key? key }) : super(key: key);

  @override
  State<EditpersonalData> createState() => _EditpersonalDataState();
}

class _EditpersonalDataState extends State<EditpersonalData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.black,
                onPressed: () {
                  (Navigator.pop(context));
                },
              ),
              SizedBox(width: 0),
              Text(
                "profile",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ]),
            SizedBox(height: 15),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    'Personal data',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 7),
            Row(
              children: [
                  Text(
                    'edit',
                    style: TextStyle(
                      fontSize: 1,
                      color: Colors.white,
                    ),
                    ),

                  Spacer(),
                
                   IconButton(
                    icon: const Icon(Icons.edit),
                    color: Colors.white,
                    onPressed: () {
                      print("icon pressed");
                    },
                  ),
              
              ],
            ),
            

            SizedBox(height: 1),


            Row(
               children: [
                Container(
                  padding: EdgeInsets.only(left:13 ),
                  child: Text(
                    "First Name :",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),


                SizedBox(width:31),

                Text(
                  "Foulen",
                  style: TextStyle(
                    fontSize: 23,
                  ),

                ),

              
               ],
            ),

                        SizedBox(height: 11),


            Row(
               children: [
                Container(
                  padding: EdgeInsets.only(left:13 ),
                  child: Text(
                    "Last Name :",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),


                SizedBox(width:31),

                Text(
                  "ibn Foulen",
                  style: TextStyle(
                    fontSize: 23,
                  ),

                ),

              
               ],
            ),
          

                   SizedBox(height: 11),


            Row(
               children: [
                Container(
                  padding: EdgeInsets.only(left:13 ),
                  child: Text(
                    "phone number :",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),


                SizedBox(width:31),

                Text(
                  "123456789",
                  style: TextStyle(
                    fontSize: 23,
                  ),

                ),

              
               ],
            ),

                  SizedBox(height: 11),


            Row(
               children: [
                Container(
                  padding: EdgeInsets.only(left:13 ),
                  child: Text(
                    "Email :",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),


                SizedBox(width:31),

                Text(
                  "exemple@gmail.com",
                  style: TextStyle(
                    fontSize: 23,
                  ),

                ),
                

              
               ],
            )





















          ],

        ),
      ),
    );
      
    
  }
}