import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/store/patients/appointments/select_appointment_day_controller.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/chip_widget.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';
import 'package:pcare/widgets/rectangle_button_widget.dart';

class SelectAppointmentDay extends StatelessWidget {
  final Map<String, dynamic> doctorDetails;
  SelectAppointmentDay({this.doctorDetails});

  SelectAppointmentDayController controller =
      Get.put(SelectAppointmentDayController());
  List<String> _dates = List<String>();

  _loadDates() {
    _dates = controller.getDates(doctorDetails['working_day']);
    controller.setDatesLoaded(true);
  }

  @override
  Widget build(BuildContext context) {
    _loadDates();
    return Scaffold(
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
    return Container(
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
    );
  }

  Widget _buildNextButton() {
    return RectangleButtonWidget(
      childText: UniversalStrings.nextButtonText,
      onPressed: () {
        if (controller.selectedDay.value == '' ||
            controller.selectedDay.value == null) {
        } else {
          //TODO: Add functionality
        }
      },
    );
  }

  Widget _buildDates() {
    return GetX<SelectAppointmentDayController>(builder: (sADController) {
      return sADController.isDatesLoaded.value
          ? ChipWidget(
              labelList: _dates,
              chipBgColor: UniversalColors.doctorListBackgroundColor,
              chipSelectedBgColor: UniversalColors.gradientColorStart,
              isCompare: true,
              compareText: sADController.selectedDay.value,
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
                sADController.setSelectedDay(value);
              },
            )
          : Center(child: CustomProgressIndicatorWidget());
    });
  }

  //methods

}
