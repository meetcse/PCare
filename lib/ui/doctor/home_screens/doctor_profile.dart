import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/doctor/doctor_strings.dart';
import 'package:pcare/constants/preferences.dart';
import 'package:pcare/services/SharedPrefsServices.dart';
import 'package:pcare/ui/Registeration/sign_in.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';

import '../appointments_history.dart';
import '../upcoming_appointments.dart';

class DoctorProfile extends StatefulWidget {
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  Map<String, dynamic> doctorDetails = {
    "name": "John Doe",
    "email": "johndoe@gmail.com",
    "mobile": "9789773456",
    "image":
        "https://adultballet.com.au/wp-content/uploads/2017/02/unnamed-1.jpg"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalColors.whiteColor,
      body: _buildChildWidget(),
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
          // Divider(),
          // ListTile(
          //   leading: Icon(
          //     CupertinoIcons.profile_circled,
          //     color: UniversalColors.gradientColorStart,
          //     size: 24,
          //   ),
          //   title: Text(
          //     DoctorUniversalStrings.editProfile,
          //     style: TextStyle(fontSize: 18),
          //   ),
          // ),
          Divider(),
          ListTile(
            onTap: () {
              PageUtils.pushPage(UpcomingAppointments());
            },
            leading: Icon(
              //TODO: change icon and make all strings global
              Icons.power_settings_new,
              color: UniversalColors.gradientColorStart,
              size: 24,
            ),
            title: Text(
              DoctorUniversalStrings.upcomingAppointments,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Divider(),
          ListTile(
            onTap: () {
              PageUtils.pushPage(AppointmentsHistory());
            },
            leading: Icon(
              //TODO: change icon and make all strings global
              Icons.power_settings_new,
              color: UniversalColors.gradientColorStart,
              size: 24,
            ),
            title: Text(
              DoctorUniversalStrings.appointmentsHistory,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Divider(),
          ListTile(
            onTap: _logOut,
            leading: Icon(
              Icons.power_settings_new,
              color: UniversalColors.gradientColorStart,
              size: 24,
            ),
            title: Text(
              'LogOut',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      height: 200,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.only(left: 15)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doctorDetails["name"],
                style: Theme.of(Get.context).textTheme.headline1.copyWith(
                      color: UniversalColors.gradientColorStart,
                      fontSize: 28,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 12),
              Text(
                doctorDetails["email"],
                style: Theme.of(Get.context).textTheme.headline5.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
              ),
              SizedBox(height: 4),
              Text(
                doctorDetails["mobile"],
                style: Theme.of(Get.context).textTheme.headline5.copyWith(
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
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 15))
              ],
            ),
          ),
        ],
      ),
    );
  }

  //methods and onClicks
  void _logOut() async {
    SharedPrefsServices _sfService = SharedPrefsServices();
    _sfService.setBoolToPref(Preferences.isLoggedIn, false);
    _sfService.setStringToPref(Preferences.authToken, '');

    //LOGIN DURING API
    PageUtils.pushPageAndRemoveAll(Signin());
  }
}
