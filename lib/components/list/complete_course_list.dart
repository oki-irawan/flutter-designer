import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_designer/components/cards/complete_course_card.dart';
import 'package:flutter_designer/models/course.dart';

class CompleteCourseList extends StatefulWidget {
  const CompleteCourseList({Key? key}) : super(key: key);

  @override
  State<CompleteCourseList> createState() => _CompleteCourseListState();
}

class _CompleteCourseListState extends State<CompleteCourseList> {
  List<Container> indicators = [];
  int currentPage = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var completedCourses = [];

  @override
  void initState() {
    super.initState();
    getCompletedCourses();
  }

  void getCompletedCourses() {
    _firestore
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .get()
        .then((snapshot) {
      for (var course in snapshot.data()?['completed']) {
        _firestore
            .collection('courses')
            .doc(course)
            .get()
            .then((snapshotCourse) {
          setState(() {
            completedCourses.add(
              Course(
                courseTitle: snapshotCourse.data()?['courseTitle'],
                courseSubtitle: snapshotCourse.data()?['courseSubtitle'],
                background: LinearGradient(colors: [
                  Color(int.parse(snapshotCourse.data()?['color'][0])),
                  Color(int.parse(snapshotCourse.data()?['color'][1]))
                ]),
                illustration: snapshotCourse.data()?['illustration'],
              ),
            );
          });
        });
      }
    });
  }

  Widget updateIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: completedCourses.map(
        (course) {
          var index = completedCourses.indexOf(course);
          return Container(
            width: 7.0,
            height: 7.0,
            margin: EdgeInsets.symmetric(
              horizontal: 6.0,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  currentPage == index ? Color(0xFF0971FE) : Color(0xFFA6AEBD),
            ),
          );
        },
      ).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200.0,
          width: double.infinity,
          child: PageView.builder(
            itemBuilder: (context, index) {
              return Opacity(
                opacity: index == currentPage ? 1.0 : 0.5,
                child: CompleteCourseCard(
                  course: completedCourses[index],
                ),
              );
            },
            itemCount: completedCourses.length,
            controller: PageController(
              initialPage: 0,
              viewportFraction: 0.75,
            ),
            onPageChanged: (index) => setState(() {
              currentPage = index;
            }),
          ),
        ),
        updateIndicator(),
      ],
    );
  }
}
