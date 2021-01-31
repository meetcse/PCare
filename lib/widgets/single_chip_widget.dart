import 'package:flutter/material.dart';
import 'package:pcare/constants/app_colors.dart';

class SingleChipWidget extends StatelessWidget {
  final String childText;
  final IconData icon;
  final Color color;

  SingleChipWidget(
      {@required this.childText, @required this.icon, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: Colors.transparent,
      shadowColor: Colors.transparent,
      child: Container(
        height: 50,
        width: 10,
        decoration: BoxDecoration(
          // color: color,

          gradient: UniversalColors.primaryGradient,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: Icon(
                icon,
                size: 50,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(bottom: 12, left: 14, right: 12),
                alignment: Alignment.centerLeft,
                child: Text(
                  childText,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style:
                      Theme.of(context).textTheme.button.copyWith(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
