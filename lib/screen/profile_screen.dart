import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_designer/components/certificate_viewer.dart';
import 'package:flutter_designer/components/list/complete_course_list.dart';
import 'package:flutter_designer/constants/colors.dart';
import 'package:flutter_designer/constants/typography.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var name = 'Loading.....';
  var bio = 'Loading.....';
  List badges = [];

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void loadUserData() {
    _firestore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .get()
        .then((snapshot) {
      print(snapshot.data()?['badges']);
      print(snapshot.data()?['badges'].runtimeType);
      setState(() {
        name = snapshot.data()?["name"];
        bio = snapshot.data()?["bio"];
        badges = snapshot.data()?['badges'];
      });
    });
  }

  void updateUserData() {
    _firestore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .update({'name': name, 'bio': bio}).then(
          (value) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('The profile data has been updated!'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Ok!'),
                )
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: kCardPopupBackgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: kShadowColor,
                    offset: Offset(0, 12),
                    blurRadius: 32.0,
                  ),
                ],
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 24.0,
                        bottom: 32.0,
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RawMaterialButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            materialTapTargetSize:
                            MaterialTapTargetSize.shrinkWrap,
                            constraints: BoxConstraints(
                              minHeight: 24.0,
                              maxHeight: 40.0,
                              maxWidth: 40.0,
                            ),
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.arrow_back,
                                  color: kSecondaryLabelColor,
                                )
                              ],
                            ),
                          ),
                          Text(
                            'Profile',
                            style: kTitle2Style,
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Upgrade your profile'),
                                    content: Column(
                                      children: [
                                        TextField(
                                          onChanged: (newValue) {
                                            setState(() {
                                              name = newValue;
                                            });
                                          },
                                          controller: TextEditingController(
                                              text: name),
                                        ),
                                        TextField(
                                          onChanged: (newValue) {
                                            setState(() {
                                              bio = newValue;
                                            });
                                          },
                                          controller: TextEditingController(
                                              text: bio),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          updateUserData();
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Update'),
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 40.0,
                              width: 40.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: kShadowColor,
                                    offset: Offset(0, 12),
                                    blurRadius: 32.0,
                                  )
                                ],
                              ),
                              child: Icon(
                                Platform.isAndroid
                                    ? Icons.settings
                                    : CupertinoIcons.settings_solid,
                                color: kCourseElementIconColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Container(
                            height: 84.0,
                            width: 84.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(42.0),
                              gradient: RadialGradient(
                                colors: [
                                  Color(0xFF00AEFF),
                                  Color(0xFF0076FF),
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(6.0),
                              child: Container(
                                padding: EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  color: kBackgroundColor,
                                  borderRadius: BorderRadius.circular(42.0),
                                ),
                                child: CircleAvatar(
                                  backgroundImage:
                                  AssetImage('asset/images/profile.jpg'),
                                  radius: 30.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${name}',
                                style: kTitle2Style,
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                '${bio}',
                                style: kSearchTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 28.0,
                        bottom: 16.0,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Badges',
                              style: kTitle2Style,
                            ),
                            Row(
                              children: [
                                Text(
                                  'See all',
                                  style: kSearchTextStyle,
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: kSecondaryLabelColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      height: 112.0,
                      child: ListView.builder(
                        padding: EdgeInsets.only(bottom: 28.0),
                        scrollDirection: Axis.horizontal,
                        itemCount: badges.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(
                              left: 20.0,
                              right: index != 3 ? 0.0 : 20.0,
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: kShadowColor.withOpacity(0.1),
                                  offset: Offset(0, 12),
                                  blurRadius: 18.0,
                                ),
                              ],
                            ),
                            child: Image.asset('asset/badges/${badges[index]}'),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 32.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Certificates',
                    style: kTitle2Style,
                  ),
                  Row(
                    children: [
                      Text(
                        'See all',
                        style: kSearchTextStyle,
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: kSecondaryLabelColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CertificateViewer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Completed Course',
                    style: kTitle2Style,
                  ),
                  Row(
                    children: [
                      Text(
                        'See all',
                        style: kSearchTextStyle,
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: kSecondaryLabelColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            CompleteCourseList(),
            SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
