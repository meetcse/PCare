import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/preferences.dart';
import 'package:pcare/services/SharedPrefsServices.dart';
import 'package:pcare/store/login/login_controller.dart';
import 'package:pcare/ui/Registeration/sign_in.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReceptionistProfile extends StatefulWidget {
  @override
  _ReceptionistProfileState createState() => _ReceptionistProfileState();
}

class _ReceptionistProfileState extends State<ReceptionistProfile> {
  LoginController _loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: UniversalColors.whiteColor,
        body: _buildChildWidget(),
      ),
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
          Divider(),
          ListTile(
            leading: Icon(
              CupertinoIcons.profile_circled,
              color: UniversalColors.gradientColorStart,
              size: 24,
            ),
            title: Text(
              'Edit Profile',
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
                _loginController.loginModel.user.firstname +
                    " " +
                    _loginController.loginModel.user.lastname,
                style: Theme.of(Get.context).textTheme.headline1.copyWith(
                      color: UniversalColors.gradientColorStart,
                      fontSize: 28,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 12),
              Text(
                _loginController.loginModel.user.mobilenumber,
                style: Theme.of(Get.context).textTheme.headline5.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
              ),
              // SizedBox(height: 4),
              // Text(
              //   receptionistDetails["mobile"],
              //   style: Theme.of(Get.context).textTheme.headline5.copyWith(
              //         fontSize: 16,
              //         fontWeight: FontWeight.normal,
              //       ),
              // ),
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
                    imageUrl: _loginController.loginModel.user.profilePic,
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
