import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_designer/components/cards/explore_course_card.dart';
import 'package:flutter_designer/models/course.dart';

class ExploreCourseList extends StatefulWidget {
  const ExploreCourseList({Key? key}) : super(key: key);

  @override
  State<ExploreCourseList> createState() => _ExploreCourseListState();
}

class _ExploreCourseListState extends State<ExploreCourseList> {
  List<Course> exploreCourses = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    getAllCourses();
  }

  void getAllCourses() {
    _firestore.collection("courses").get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          exploreCourses.add(Course(
              courseTitle: doc['courseTitle'],
              courseSubtitle: doc['courseSubtitle'],
              background: LinearGradient(colors: [
                Color(int.parse(doc['color'][0])),
                Color(int.parse(doc['color'][1])),
              ]),
              illustration: doc['illustration']));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: exploreCourses.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: index == 0 ? 20.0 : 0.0),
            child: ExploreCourseCard(
              course: exploreCourses[index],
            ),
          );
        },
      ),
    );
  }
}
