import 'package:flutter/material.dart';

class EmptyAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(0.0, 0.0);
}
