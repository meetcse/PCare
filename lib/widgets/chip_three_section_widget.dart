import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        width: 160,
        padding: const EdgeInsets.all(8),
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
            _title(),

            SizedBox(
              height: 8,
            ),

            //image
            _image(),
            SizedBox(
              height: 8,
            ),

            //description
            _description(),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Text(
      title,
      style: Theme.of(Get.context).textTheme.headline5,
      textAlign: TextAlign.center,
    );
  }

  Widget _image() {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        child: Image(
          image: AssetImage(
            imageUrl,
          ),
          height: 70,
          width: 70,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _description() {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(left: 4, right: 4),
      child: Text(
        description,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(Get.context).textTheme.bodyText1,
        textAlign: TextAlign.center,
      ),
    );
  }
}
