import 'package:flutter/material.dart';
import 'package:flutter_designer/screen/login_screen.dart';
import '../components/sidebar_row.dart';
import '../constants/colors.dart';
import '../constants/typography.dart';
import '../models/sidebar.dart';

class SidebarScreen extends StatelessWidget {
  const SidebarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kSidebarBackgroundColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(
            34.0,
          ),
        ),
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.85,
      padding: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 32.0,
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('asset/images/profile.jpg'),
                  radius: 21.0,
                ),
                SizedBox(width: 15.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Anna De Armas',
                      style: kHeadlineLabelStyle,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Licence ends on 17 July 2023',
                      style: kSearchPlaceholderStyle,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            SidebarRow(item: sidebarItem[0]),
            SizedBox(height: 32.0),
            SidebarRow(item: sidebarItem[1]),
            SizedBox(height: 32.0),
            SidebarRow(item: sidebarItem[2]),
            SizedBox(height: 32.0),
            SidebarRow(item: sidebarItem[3]),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Row(
                children: [
                  Image.asset(
                    'asset/icons/icon-logout.png',
                    width: 17.0,
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    'Log Out',
                    style: kSecondaryCalloutLabelStyle,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
