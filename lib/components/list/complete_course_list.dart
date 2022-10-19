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
