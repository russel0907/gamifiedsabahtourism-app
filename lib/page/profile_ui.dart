// ignore: file_names
// ignore_for_file: unused_import, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables, avoid_renaming_method_parameters, non_constant_identifier_names, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, avoid_print, deprecated_member_use, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_interfaces/constant/const.dart';
import 'package:home_interfaces/main.dart';
import 'package:home_interfaces/model/user_model.dart';
import 'package:home_interfaces/page/databasestorytesting_ui.dart';
import 'package:home_interfaces/page/loginscreen_ui.dart';
import 'package:home_interfaces/widget/appbar.dart';
import 'databaserankingtesting_ui.dart';
import 'feedback_ui.dart';
import 'license_ui.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'aboutus_ui.dart';

class ProfilePageUI extends StatefulWidget {
  @override
  _ProfilePageUIState createState() => _ProfilePageUIState();
}

class _ProfilePageUIState extends State<ProfilePageUI> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance
        .signOut()
        .then((value) => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => WelcomeUI(),
              ),
              (route) => false,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        appBar: appBar(title: 'Profile'),
        body: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50, bottom: 20),
                  child: Center(
                    child: CircleAvatar(
                      backgroundImage: AssetImage('img/logo/profile logo.png'),
                      backgroundColor: Colors.white70,
                      radius: 70,
                    ),
                  ),
                ),
                Container(
                  child: Center(
                      child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black87, width: 1.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          width: MediaQuery.of(context).size.width * 0.88,
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: RichText(
                            text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "User Details\n",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: "Name: ",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: "${loggedInUser.name} \n",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: "Email: ",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: "${loggedInUser.email} \n",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: "Phone Number: ",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: "${loggedInUser.phonenumber} \n",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black),
                                  ),
                                ]),
                          ))),
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.width * 0.15,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            color: kSecondaryColor,
                            elevation: 5,
                            child: InkWell(
                              onTap: () {
                                print('License Term Pressed');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LicenseTerm()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.book,
                                      color: kTextColor,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'License Term',
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.width * 0.15,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            color: kSecondaryColor,
                            elevation: 5,
                            child: InkWell(
                              onTap: () {
                                print('Feedback Pressed');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FeedbackBtn()));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.feed,
                                      color: kTextColor,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Feedback',
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.width * 0.15,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            color: kSecondaryColor,
                            elevation: 5,
                            child: InkWell(
                              onTap: () {
                                logout(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.logout,
                                      color: kTextColor,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Logout',
                                      style: TextStyle(fontSize: 18),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
