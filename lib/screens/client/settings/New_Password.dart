import 'package:flutter/material.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({Key? key}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      // backgroundColor: MaterialStateProperty.all(Color(0xFF2DC194)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      padding: EdgeInsets.symmetric(horizontal: 39),
      elevation: 2,

      // backgroundColor: MaterialStateProperty.all(Color(0xFF3585E2)),
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 253, left: 24.6),
                child: Row(
                  children: [
                    Center(
                      child: Text(
                        "Enter your new password",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 27.1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 22, right: 22),
                child: TextField(
                  decoration: InputDecoration(
                      //contentPadding: EdgeInsets.only(bottom: 1),
                      //labelText: labelText,
                      //floatingLabelBehavior: FloatingLabelBehavior.always,
                      // hintText: placeholder,
                      hintStyle: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
                ),
              ),
              SizedBox(height: 35),
              ElevatedButton(

                  // backgroundColor: Color(0xFF3A64EC),

                  //backgroundColor: MaterialStateProperty.all(Color(0xFF2DC194)),

                  //backgroundColor: MaterialStateProperty.all(Color(0xFF3585E2)),
                  onPressed: () {},
                  style: style,
                  child: Text(
                    "Save",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        //fontWeight: FontWeight.bold,
                        backgroundColor: Color(0xFF3585E2)),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
