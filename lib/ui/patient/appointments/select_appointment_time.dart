import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/store/patients/appointments/select_appointment_time_controller.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/chip_widget.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';
import 'package:pcare/widgets/rectangle_button_widget.dart';

class SelectAppointmentTime extends StatelessWidget {
  final Map<String, dynamic> doctorDetails;
  SelectAppointmentTime({this.doctorDetails});

  SelectAppointmentTimeController controller =
      Get.put(SelectAppointmentTimeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarWidget(
        title: UniversalStrings.selectTime,
        leading: BackButtonWidget(),
      ),
      body: _buildChildWidget(),
    );
  }

  Widget _buildChildWidget() {
    return LayoutBuilder(builder: (context, constraint) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: IntrinsicHeight(
            child: Container(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 12,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //text = please select time
                  Text(
                    UniversalStrings.selectYourTime,
                    style: Theme.of(Get.context).textTheme.headline4,
                  ),

                  SizedBox(
                    height: 20,
                  ),

                  //build chips
                  Expanded(
                    child: _buildChips(),
                  ),

                  //next button
                  _buildNextButton(),

                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildChips() {
    return GetX<SelectAppointmentTimeController>(
      builder: (sATController) {
        return sATController.isTimeLoaded.value
            ? ChipWidget(
                labelList: doctorDetails['working_hour'],
                onChipPressed: (value) {
                  sATController.setSelectedTime(value);
                },
                chipBgColor: UniversalColors.doctorListBackgroundColor,
                chipSelectedBgColor: UniversalColors.gradientColorStart,
                isCompare: true,
                compareText: sATController.selectedTime.value,
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
              )
            : Center(
                child: CustomProgressIndicatorWidget(),
              );
      },
    );
  }

  Widget _buildNextButton() {
    return RectangleButtonWidget(
      childText: UniversalStrings.nextButtonText,
      onPressed: () {
        if (controller.selectedTime.value == '' ||
            controller.selectedTime.value == null) {
        } else {
          //TODO: Add route
        }
      },
    );
  }
}
