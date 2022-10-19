import 'package:flutter/material.dart';
import 'package:flutter_designer/constants/colors.dart';

class SidebarButton extends StatelessWidget {
  final void Function() triggerAnimation;

  const SidebarButton({
    required this.triggerAnimation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RawMaterialButton(
          onPressed: triggerAnimation,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          constraints: BoxConstraints(
            maxHeight: 40.0,
            maxWidth: 40.0,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.0),
              boxShadow: [
                BoxShadow(
                  color: kShadowColor,
                  offset: Offset(0, 12),
                  blurRadius: 16.0,
                )
              ],
            ),
            child: Image.asset(
              'asset/icons/icon-sidebar.png',
              color: kPrimaryLabelColor,
            ),
            padding: EdgeInsets.symmetric(
              vertical: 14.0,
              horizontal: 12.0,
            ),
          ),
        )
      ],
    );
  }
}