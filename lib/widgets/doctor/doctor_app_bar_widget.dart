import 'package:flutter/material.dart';
import 'package:pcare/constants/app_colors.dart';

class DoctorAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  List<Widget> actions;
  Widget leading;
  String title;

  DoctorAppbarWidget({this.actions, this.leading, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: UniversalColors.whiteColor,
      actions: actions,
      leading: leading,
      centerTitle: true,
      title: title != null
          ? Text(title,
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(fontSize: 20, fontWeight: FontWeight.w600))
          : Container(),
      elevation: 2,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(0, 56.0);
}
