import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/preferences.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/store/patients/patient_home_controller.dart';
import 'package:pcare/ui/Registeration/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientDrawerWidget extends StatefulWidget {
  @override
  _PatientDrawerWidgetState createState() => _PatientDrawerWidgetState();
}

class _PatientDrawerWidgetState extends State<PatientDrawerWidget> {
  PatientHomeController patientHomeController =
      Get.put(PatientHomeController());
  //TODO: CHange with dynamic
  Map<String, dynamic> _loggedInUser = {
    "username": "John",
    "age": "20",
    "gender": "Male",
    "mobile": "+91 8980772697",
    "city": "Vadodara"
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
          child: Drawer(
            elevation: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //Header
                _buildDrawerHeader(),

                //List of Items
                Flexible(fit: FlexFit.loose, child: _buildListOfItems()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListOfItems() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: patientHomeController.drawerItems.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              if (patientHomeController.drawerItems[index]['change'])
                index == 0 ? Container() : Divider()
              else
                Container(),
              GetX<PatientHomeController>(builder: (patientController) {
                return ListTile(
                  contentPadding: EdgeInsets.only(left: 16),
                  selected: patientController.selected.value ==
                      patientController.drawerItems[index]['id'],
                  selectedTileColor:
                      UniversalColors.gradientColorEnd.withOpacity(0.5),
                  onTap: () async {
                    if (patientController.drawerItems[index]['id'] ==
                        UniversalStrings.signOut) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setBool(Preferences.isLoggedIn, false);
                      //TODO: ADD EMAIL AND PASS TO SHARED PREF WHEN
                      //LOGIN DURING API
                      PageUtils.pushPageAndRemoveAll(Signin());
                    } else if (patientController.drawerItems[index]
                            ['navigateTo'] !=
                        '') {
                      PageUtils.pushPage(
                          patientController.drawerItems[index]['navigateTo']);
                    } else {
                      PageUtils.popCurrentPage();
                    }
                  },
                  title: Text(
                    patientController.drawerItems[index]['name'],
                    style: patientController.selected.value ==
                            patientController.drawerItems[index]['id']
                        ? Theme.of(context).textTheme.subtitle1
                        : Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(fontWeight: FontWeight.normal),
                  ),
                );
              }),
            ],
          );
        });
  }

  Widget _buildDrawerHeader() {
    return GestureDetector(
      onTap: () {
        //TODO: Navigate to User Profile Screen
      },
      child: Container(
        decoration: BoxDecoration(
          color: UniversalColors.gradientColorStart,
        ),
        padding: const EdgeInsets.only(
          top: 14,
          left: 14,
          bottom: 14,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //profile image
            //TODO: Change profile image with users profile with backend
            Container(
              alignment: Alignment.centerLeft,
              height: 50,
              width: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                child: Image(
                  image: AssetImage('assets/images/profiledefault.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            //User Details
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  left: 14,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Name
                    Text(_loggedInUser['username'],
                        style: Theme.of(context).textTheme.headline3),
                    //Age and Gender in row
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Text(_loggedInUser['age'] + " years,",
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .button
                    //             .copyWith(fontSize: 14)),
                    //     SizedBox(
                    //       width: 8,
                    //     ),
                    //     Text(_loggedInUser['gender'],
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .button
                    //             .copyWith(fontSize: 14)),
                    //   ],
                    // ),

                    //Mobile NUmber
                    Text(_loggedInUser['mobile'],
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(fontSize: 14)),

                    //City
                    Text(_loggedInUser['city'],
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(fontSize: 14)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
