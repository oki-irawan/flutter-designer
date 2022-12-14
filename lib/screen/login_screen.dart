import 'package:flutter/material.dart';
import 'package:flutter_designer/constants/colors.dart';
import 'package:flutter_designer/constants/typography.dart';
import 'package:flutter_designer/screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createNewUserData() async {
    _firestore.collection('users').doc(_auth.currentUser?.uid).set({
      'name': 'User',
      'uid': _auth.currentUser?.uid,
      'bio': 'Design+Code Student',
      'completed': [],
      'recents': [],
      'badges': [],
      'certificates': [],
      'profilePic': '',
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kSidebarBackgroundColor,
        child: ListView(
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      transform: Matrix4.translationValues(0, -60, 0),
                      child: Image.asset(
                        'asset/illustrations/illustration-14.png',
                      ),
                    ),
                    Container(
                      transform: Matrix4.translationValues(0, -150, 0),
                      child: Column(
                        children: [
                          Text(
                            'Learn to design\nand code apps',
                            style:
                                kLargeTitleStyle.copyWith(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 7.0,
                          ),
                          Text(
                            'Complete courses about the best\ntools and design systems',
                            style: kHeadlineLabelStyle.copyWith(
                              color: Colors.white70,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  transform: Matrix4.translationValues(0, -150, 0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 53.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Log in to',
                          style: kTitle1Style,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Text(
                          'Start Learning',
                          style: kTitle1Style.apply(
                            color: kPrimaryColor,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          height: 130.0,
                          child: Column(
                            children: [
                              // Container for Box Shadow
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14.0),
                                  color: Color(0xFFFAFCFF),
                                  boxShadow: [
                                    BoxShadow(
                                      color: kShadowColor,
                                      offset: Offset(0, 12),
                                      blurRadius: 16.0,
                                    )
                                  ],
                                ),
                                // Container for Text Field
                                child: Column(
                                  children: [
                                    //Each Text Field Input
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 5.0,
                                        right: 16.0,
                                        left: 16.0,
                                      ),
                                      child: TextField(
                                        cursorColor: kPrimaryLabelColor,
                                        decoration: InputDecoration(
                                          icon: Icon(
                                            Icons.email,
                                            color: Color(0xFF5488F1),
                                            size: 20.0,
                                          ),
                                          border: InputBorder.none,
                                          hintText: 'Email Address',
                                          hintStyle: kLoginInputTextStyle,
                                        ),
                                        style: kLoginInputTextStyle.copyWith(
                                          color: Colors.black,
                                        ),
                                        onChanged: (value) {
                                          email = value;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                      ),
                                      child: Divider(),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: 16.0,
                                        left: 16.0,
                                        bottom: 5.0,
                                      ),
                                      child: TextField(
                                        cursorColor: kPrimaryLabelColor,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          icon: Icon(
                                            Icons.lock,
                                            color: Color(0xFF5488F1),
                                            size: 20.0,
                                          ),
                                          border: InputBorder.none,
                                          hintText: 'Password',
                                          hintStyle: kLoginInputTextStyle,
                                        ),
                                        onChanged: (value) {
                                          password = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                try {
                                  await _auth.signInWithEmailAndPassword(
                                      email: email, password: password);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ),
                                  );
                                } on FirebaseAuthException catch (err) {
                                  if (err.code == "user-not-found") {
                                    try {
                                      await _auth
                                          .createUserWithEmailAndPassword(
                                        email: email,
                                        password: password,
                                      )
                                          .then(
                                        (user) {
                                          user.user?.sendEmailVerification();
                                          createNewUserData();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen(),
                                            ),
                                          );
                                        },
                                      );
                                    } catch (err) {}
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Error'),
                                          content: Text(err.message.toString()),
                                        );
                                      },
                                    );
                                  }
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 47,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF73A0F4),
                                      Color(0xFF4A47F5),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                                child: Text(
                                  'Login',
                                  style: kHeadlineLabelStyle.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            _auth.sendPasswordResetEmail(email: email).then(
                                  (value) => {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text("Email Sent!"),
                                          content: Text(
                                              'Password reset email has been sent!'),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('OK!'),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  },
                                );
                          },
                          child: Container(
                            child: Text(
                              'Forgot Password?',
                              style: kCalloutLabelStyle.copyWith(
                                color: Color(0x721B1E9C),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
