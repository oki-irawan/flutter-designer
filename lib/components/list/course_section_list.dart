import 'package:flutter/material.dart';
import 'package:flutter_designer/components/cards/course_section_card.dart';
import 'package:flutter_designer/constants/typography.dart';
import 'package:flutter_designer/models/course.dart';

class CourseSectionList extends StatelessWidget {
  const CourseSectionList({Key? key}) : super(key: key);

  List<Widget> courseSectionWidget() {
    List<Widget> cards = [];

    for (var course in courseSections) {
      cards.add(
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: CourseSectionCard(course: course),
        ),
      );
    }

    cards.add(
      Padding(
        padding: EdgeInsets.only(
          top: 12.0,
        ),
        child: Text(
          'No more Sections to view, looks\nfor more in our courses',
          style: kCaptionLabelStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );

    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(children: courseSectionWidget()),
    );
  }
}
