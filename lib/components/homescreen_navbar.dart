import 'package:flutter/material.dart';
import 'package:flutter_designer/components/search_field_widget.dart';
import 'package:flutter_designer/components/sidebar_button.dart';
import 'package:flutter_designer/constants/colors.dart';
import 'package:flutter_designer/screen/profile_screen.dart';

class HomeScreenNavbar extends StatelessWidget {
  final void Function() triggerAnimation;

  const HomeScreenNavbar({
    required this.triggerAnimation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SidebarButton(
            triggerAnimation: triggerAnimation,
          ),
          SearchFieldWidget(),
          Icon(
            Icons.notifications,
            color: kPrimaryLabelColor,
          ),
          SizedBox(
            width: 16.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              );
            },
            child: CircleAvatar(
              backgroundImage: AssetImage('asset/images/profile.jpg'),
              radius: 21.0,
            ),
          ),
        ],
      ),
    );
  }
}
