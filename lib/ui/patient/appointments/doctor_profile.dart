import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/models/patient/appointment/SearchDoctorInPatientModel.dart';
import 'package:pcare/ui/patient/appointments/select_appointment_day.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/chip_widget.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';
import 'package:pcare/widgets/rectangle_button_widget.dart';

class DoctorProfile extends StatefulWidget {
  final SearchDoctorsInPatientModel doctorDetails;
  DoctorProfile({@required this.doctorDetails});
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBookButton(),
      backgroundColor: UniversalColors.whiteColor,
      appBar: _buildAppBar(),
      body: _buildChildWidget(),
    );
  }

  Widget _buildBookButton() {
    return Container(
      margin: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: 8,
      ),
      color: Colors.transparent,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //TODO: DISPLAY ONLY IF NEXT AVAILABLE - FROM BACKEND
          Container(
            width: Get.width * 0.4,
            child: _buildButton(
              UniversalStrings.instantBook,
              () {
                //TODO: Add functionality
              },
            ),
          ),

          //book now
          Container(
            width: Get.width * 0.4,
            child: _buildButton(
              UniversalStrings.bookNow,
              () {
                _gotoSelectAppointmentDayScreen();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChildWidget() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImage(),
          Flexible(
            fit: FlexFit.loose,
            child: Container(
              margin: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),

                  //study or doc type
                  _buildDoctorTypeAndSpecialist(),
                  SizedBox(height: 10),
                  Divider(),

                  //hospital name
                  _buildHospitalNameAndSpecialist(),

                  SizedBox(height: 10),
                  //hospital address
                  _buildAddress(),

                  SizedBox(height: 10),
                  Divider(),
                  SizedBox(height: 10),

                  //next avail
                  // _buildNextAvailable(), //TODO: Get data from backend directly
                  // SizedBox(height: 10),
                  Divider(),

                  //general opd timings
                  Flexible(
                    fit: FlexFit.loose,
                    child: _buildOpdTime(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOpdTime() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //generally availables on
        Text(
          UniversalStrings.generallyAvail,
          style: Theme.of(context).textTheme.headline5.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
        ),

        SizedBox(
          height: 10,
        ),

        //build table for time and working days
        _buildWorkingDayChips(widget.doctorDetails.workingDays),

        SizedBox(
          height: 10,
        ),

        //working time
        Text(
          UniversalStrings.youCanMeetMe,
          style: Theme.of(context).textTheme.headline5.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
        ),

        _buildWorkingTime(widget.doctorDetails.workingHours),

        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _buildWorkingTime(List<String> workingTime) {
    return ChipWidget(
      labelList: workingTime,
    );
  }

  Widget _buildWorkingDayChips(List<String> workingDay) {
    // List<String> _splittedString = _getWorkingDayList(workingDay);

    return ChipWidget(
      labelList: workingDay,
    );
  }

  Widget _buildNextAvailable() {
    return Text(
      "Next Available at 7 PM today", //TODO: CHange during api from backend
      style: Theme.of(context).textTheme.headline4.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
    );
  }

  Widget _buildDoctorTypeAndSpecialist() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.doctorDetails.doctorType,
          style: Theme.of(context).textTheme.headline5.copyWith(
                fontSize: 16,
              ),
        ),
        widget.doctorDetails.specialist
            ? Container(
                // margin: const EdgeInsets.only(right: 14),
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                  top: 4,
                  bottom: 4,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                  color: UniversalColors.specialistColor,
                ),
                child: Text(
                  UniversalStrings.specialist,
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget _buildAddress() {
    return Text(
      widget.doctorDetails.hospitalId.hospitalAddress,
      style: Theme.of(context).textTheme.headline5,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildHospitalNameAndSpecialist() {
    return Container(
      child: Text(
        UniversalStrings.at +
            ' ' +
            widget.doctorDetails.hospitalId.hospitalName,
        style: Theme.of(Get.context).textTheme.headline5.copyWith(
              fontSize: 16,
            ),
      ),
    );
  }

  Widget _buildAppBar() {
    return MainAppBarWidget(
      title: widget.doctorDetails.user.firstName +
          " " +
          widget.doctorDetails.user.lastName,
      leading: BackButtonWidget(),
    );
  }

  Widget _buildImage() {
    return Hero(
      tag: widget.doctorDetails.id,
      child: CachedNetworkImage(
        imageUrl: widget.doctorDetails.user.profilePic,
        progressIndicatorBuilder: (context, url, _) {
          return Center(
            child: CustomProgressIndicatorWidget(
              size: 30,
            ),
          );
        },
        fit: BoxFit.contain,
        height: 280,
        width: Get.width,
      ),
    );
  }

  Widget _buildButton(String text, Function onPressed) {
    return RectangleButtonWidget(
      childText: text,
      // isImage: false,
      onPressed: onPressed,
      width: Get.width * 0.1,
    );
  }

  //methods and on clicks

  List<String> _getWorkingDayList(String workingDay) {
    List<String> _splittedString;
    if (workingDay.contains('-')) {
      _splittedString = workingDay.split('-');
    } else {
      _splittedString = workingDay.split(',');
    }
    return _splittedString;
  }

  void _gotoSelectAppointmentDayScreen() {
    PageUtils.pushPage(
      SelectAppointmentDay(
        doctorDetails: widget.doctorDetails,
      ),
    );
  }
}
