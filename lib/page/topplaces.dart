// ignore_for_file: use_key_in_widget_constructors, non_constant_identifier_names, prefer_const_constructors, prefer_const_constructors_in_immutables, duplicate_ignore, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_interfaces/constant/const.dart';
import 'package:home_interfaces/model/user_model.dart';
import 'package:home_interfaces/widget/appbar.dart';

import 'detailscreen_ui.dart';
// import 'package:home_interfaces/page/aboutus_ui.dart';
// import 'package:home_interfaces/page/databasestorytesting_ui.dart';

// import 'story_ui.dart';

void main() {
  runApp(MaterialApp(
    home: PlaceUI(),
  ));
}

class PlaceUI extends StatefulWidget {
  @override
  _PlaceState createState() => _PlaceState();
}

class _PlaceState extends State<PlaceUI> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final tourRef = FirebaseFirestore.instance.collection('places');

  @override
  void initState() {
    super.initState();
    // _makelist();
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });
  }

  int categoriescurrentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: appBar(title: 'Top Places In Sabah'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: kPrimaryColor,
              height: MediaQuery.of(context).size.height,
              child: StreamBuilder(
                stream: tourRef.snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData) {
                    return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 0,
                          childAspectRatio: 1,
                        ),
                        shrinkWrap: true,
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, i) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            child: Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 0,
                              color: kSecondaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailsScreen(
                                          places: snapshot.data!.docs[i]),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: <Widget>[
                                    Image.asset(
                                      'img/background_ui/${snapshot.data.docs[i].data()['BackgroundPicture']}',
                                      fit: BoxFit.fill,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                          snapshot.data.docs[i]['PlaceName'],
                                          softWrap: true,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xff2b2b2b),
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }
                  return Text('Loading');
                },
              ),
            ),
          ],
        ),
      ),
      // ],
      // ),
    );
  }
}
