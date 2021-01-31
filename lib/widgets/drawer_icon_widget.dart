import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pcare/constants/app_colors.dart';

class DrawerIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(left: 8),
      child: GestureDetector(
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
        child: Icon(
          Icons.grid_view,
          color: UniversalColors.whiteColor,
          size: 24,
        ),
      ),
    );
  }
}
