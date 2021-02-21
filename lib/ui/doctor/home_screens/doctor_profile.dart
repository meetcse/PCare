import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcare/constants/doctor/doctor_strings.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/doctor/doctor_app_bar_widget.dart';

class DoctorProfile extends StatefulWidget {
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  Map<String, dynamic> doctorDetails = {
    "name": "Dipen Biden",
    "email": "bidendipen420@gmail.com",
    "mobile": "9789773456",
    "image":
        "https://adultballet.com.au/wp-content/uploads/2017/02/unnamed-1.jpg"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildChildWidget(),
    );
  }

  Widget _buildAppBar() {
    return DoctorAppbarWidget(
      title: DoctorUniversalStrings.profile,
    );
  }

  Widget _buildChildWidget() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.only(top: 15)),
          _buildBody(),
          Padding(padding: EdgeInsets.only(top: 10)),
          Divider(
            thickness: 2,
            color: Colors.black,
          ),
          ListTile(
            leading: Icon(
              CupertinoIcons.profile_circled,
              size: 30,
            ),
            title: Text(
              'Edit Profile',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Divider(
            thickness: 1,
            color: Colors.black,
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              size: 30,
            ),
            title: Text(
              'LogOut',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Row(
      children: [
        Padding(padding: EdgeInsets.only(left: 15)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              doctorDetails["name"],
              style: Theme.of(Get.context).textTheme.headline4.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
            ),
            Text(
              doctorDetails["email"],
              style: Theme.of(Get.context).textTheme.headline4.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
            ),
            Text(
              doctorDetails["mobile"],
              style: Theme.of(Get.context).textTheme.headline4.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
            ),
          ],
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  progressIndicatorBuilder: (context, _, __) {
                    return CustomProgressIndicatorWidget();
                  },
                  imageUrl: doctorDetails["image"],
                  height: 70,
                  width: 70,
                  fit: BoxFit.fill,
                ),
              ),
              Padding(padding: EdgeInsets.only(right: 15))
            ],
          ),
        ),
      ],
    );
  }
}
