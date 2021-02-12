import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pcare/constants/app_colors.dart';

class ChipThreeSectionWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  ChipThreeSectionWidget({
    @required this.imageUrl,
    @required this.title,
    @required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: Colors.transparent,
      borderOnForeground: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
      ),

      // borderRadius: BorderRadius.all(Radius.circular(18)),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: UniversalColors.whiteColor,
          borderRadius: BorderRadius.all(
            Radius.circular(18),
          ),
        ),
        // height: 100,
        // width: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //title
            Text(
              title,
              style: Theme.of(context).textTheme.headline5,
            ),

            //image
            Image(
              image: AssetImage(
                imageUrl,
              ),
              height: 70,
              width: 70,
              fit: BoxFit.cover,
            ),

            //description
            Container(
              margin: const EdgeInsets.only(left: 4, right: 4),
              child: Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
