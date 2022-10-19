import 'package:flutter/material.dart';
import 'package:flutter_designer/constants/typography.dart';
import 'package:flutter_designer/models/course.dart';

class CourseSectionCard extends StatelessWidget {
  final Course course;

  const CourseSectionCard({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          gradient: course.background,
          borderRadius: BorderRadius.circular(41.0),
          boxShadow: [
            BoxShadow(
              color: course.background.colors[0].withOpacity(0.3),
              offset: Offset(0, 20),
              blurRadius: 20.0,
            ),
            BoxShadow(
              color: course.background.colors[1].withOpacity(0.3),
              offset: Offset(0, 20),
              blurRadius: 20.0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(41.0),
          child: Padding(
            padding: EdgeInsets.only(left: 32.0),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      'asset/illustrations/${course.illustration}',
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            course.courseTitle,
                            style: kCardSubtitleStyle,
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            course.courseTitle,
                            style: kCardTitleStyle,
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
