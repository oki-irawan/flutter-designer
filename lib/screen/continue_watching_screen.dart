import 'package:flutter/material.dart';
import 'package:flutter_designer/components/certificate_viewer.dart';
import 'package:flutter_designer/components/list/continue_watching_list.dart';
import 'package:flutter_designer/constants/colors.dart';
import 'package:flutter_designer/constants/typography.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ContinueWatchingScreen extends StatelessWidget {
  const ContinueWatchingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      backdropEnabled: true,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(34.0),
      ),
      color: kBackgroundColor,
      boxShadow: [
        BoxShadow(
          color: kShadowColor,
          offset: Offset(0, -12),
          blurRadius: 32.0,
        ),
      ],
      minHeight: 85.0,
      maxHeight: MediaQuery.of(context).size.height * 0.70,
      panel: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                top: 12.0,
                bottom: 16.0,
              ),
              child: Container(
                height: 4.0,
                width: 42,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.5),
                  color: Color(0xFFC5CBD6),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Text(
              'Continue Watching',
              style: kTitle2Style,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 24.0,
            ),
            child: ContinueWatchingList(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Text(
              'Certificate',
              style: kTitle2Style,
            ),
          ),
          Expanded(
            child: CertificateViewer(),
          )
        ],
      ),
    );
  }
}
