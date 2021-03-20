import 'package:flutter/material.dart';
import 'package:pcare/constants/app_colors.dart';

class ReceptionistAppbarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  List<Widget> actions;
  Widget leading;
  String title;

  ReceptionistAppbarWidget({this.actions, this.leading, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff2C8BFF),
      actions: actions,
      leading: leading,
      title: title != null
          ? Text(title,
              style: Theme.of(context).textTheme.headline4.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white))
          : Container(),
      elevation: 2,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(0, 56.0);
}
