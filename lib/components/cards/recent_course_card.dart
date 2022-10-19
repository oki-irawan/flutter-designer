import 'package:flutter/material.dart';
import 'package:flutter_designer/constants/colors.dart';
import 'package:flutter_designer/constants/typography.dart';
import 'package:flutter_designer/models/course.dart';

class RecentCourseCard extends StatelessWidget {
  const RecentCourseCard({required this.course, super.key});

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Container(
            height: 260.0,
            width: 240.0,
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
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: 32.0,
                      left: 32.0,
                      top: 31.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: course.courseSubtitle,
                          child: Text(
                            course.courseSubtitle,
                            style: kCardSubtitleStyle,
                          ),
                        ),
                        SizedBox(
                          height: 6.0,
                        ),
                        Hero(
                          tag: course.courseTitle,
                          child: Text(
                            course.courseTitle,
                            style: kCardTitleStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Hero(
                      tag: course.illustration,
                      child: Image.asset(
                        'asset/illustrations/${course.illustration}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 42.0),
          child: Container(
            height: 60.0,
            width: 60.0,
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18.0),
              boxShadow: [
                BoxShadow(
                  color: kShadowColor,
                  offset: Offset(0, 4),
                  blurRadius: 16.0,
                )
              ],
            ),
            child: Hero(
              tag: course.logo.toString(),
              child: Image.asset(
                'asset/logos/${course.logo}',
                width: 32.0,
              ),
            ),
          ),
        )
      ],
    );
  }
}
