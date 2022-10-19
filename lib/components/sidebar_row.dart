import 'package:flutter/material.dart';

import '../constants/typography.dart';
import '../models/sidebar.dart';

class SidebarRow extends StatelessWidget {
  const SidebarRow({
    required this.item,
    Key? key,
  }) : super(key: key);

  final SidebarItem item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 42.0,
          width: 42.0,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            gradient: item.background,
          ),
          child: item.icon,
        ),
        SizedBox(
          width: 12,
        ),
        Text(
          item.title,
          style: kCalloutLabelStyle,
        ),
      ],
    );
  }
}
