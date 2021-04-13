import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/models/patient/appointment/SearchDoctorInPatientModel.dart';
import 'package:pcare/store/patients/appointments/select_appointment_day_controller.dart';
import 'package:pcare/ui/patient/appointments/select_appointment_time.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/chip_widget.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';
import 'package:pcare/widgets/rectangle_button_widget.dart';

class SelectAppointmentDay extends StatelessWidget {
  final SearchDoctorsInPatientModel doctorDetails;
  SelectAppointmentDay({this.doctorDetails});

  SelectAppointmentDayController controller =
      Get.put(SelectAppointmentDayController());
  List<String> _dates = [];

  _loadDates() {
    _dates = controller.getDates(doctorDetails.workingDays);
    controller.setDatesLoaded(true);
  }

  @override
  Widget build(BuildContext context) {
    _loadDates();
    return Scaffold(
      backgroundColor: UniversalColors.whiteColor,
      appBar: MainAppBarWidget(
        title: UniversalStrings.selectDate,
        leading: BackButtonWidget(
          onPressed: () {
            controller.setDatesLoaded(false);
          },
        ),
      ),
      body: _buildChildWidget(),
    );
  }

  Widget _buildChildWidget() {
    return WillPopScope(
      onWillPop: () {
        controller.setDatesLoaded(false);
        PageUtils.popCurrentPage();
      },
      child: _buildBody(),
    );
  }

  Widget _buildBody() {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: IntrinsicHeight(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //text - select any one date
                  Text(
                    UniversalStrings.selectAnyOneDate,
                    style: Theme.of(Get.context).textTheme.headline4,
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  //build dates
                  Expanded(child: _buildDates()),

                  //next button
                  _buildNextButton(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildNextButton() {
    return RectangleButtonWidget(
      childText: UniversalStrings.nextButtonText,
      onPressed: () {
        if (controller.selectedDay.value == '' ||
            controller.selectedDay.value == null) {
        } else {
          _gotoSelectAppointmentScreen();
        }
      },
    );
  }

  Widget _buildDates() {
    return Obx(
      () {
        return controller.isDatesLoaded.value
            ? ChipWidget(
                labelList: _dates,
                chipBgColor: UniversalColors.doctorListBackgroundColor,
                chipSelectedBgColor: UniversalColors.gradientColorStart,
                isCompare: true,
                compareText: controller.selectedDay.value,
                selectedLabelStyle:
                    Theme.of(Get.context).textTheme.button.copyWith(
                          fontSize: 14,
                          color: UniversalColors.whiteColor,
                          fontWeight: FontWeight.w300,
                        ),
                labelStyle: Theme.of(Get.context).textTheme.headline6.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                onChipPressed: (value) {
                  _onChipPressed(value);
                },
              )
            : Center(child: CustomProgressIndicatorWidget());
      },
    );
  }

  //methods
  void _gotoSelectAppointmentScreen() {
    PageUtils.pushPage(
      SelectAppointmentTime(
        doctorDetails: doctorDetails,
      ),
    );
  }

  void _onChipPressed(String value) {
    controller.setSelectedDay(value);
  }
}
