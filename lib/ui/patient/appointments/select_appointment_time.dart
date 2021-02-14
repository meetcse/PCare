import 'package:cached_network_image/cached_network_image.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrix4_transform/matrix4_transform.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/store/patients/appointments/select_appointment_day_controller.dart';
import 'package:pcare/store/patients/appointments/select_appointment_time_controller.dart';
import 'package:pcare/ui/patient/HomePage.dart';
import 'package:pcare/ui/patient/appointments/my_appointments.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/chip_widget.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';
import 'package:pcare/widgets/rectangle_button_widget.dart';

class SelectAppointmentTime extends StatelessWidget {
  final Map<String, dynamic> doctorDetails;
  SelectAppointmentTime({this.doctorDetails});
  ConfettiController _confettiControllerCenter;
  SelectAppointmentTimeController controller =
      Get.put(SelectAppointmentTimeController());

  SelectAppointmentDayController dayController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarWidget(
        title: UniversalStrings.selectTime,
        leading: BackButtonWidget(
          onPressed: () {
            _confettiControllerCenter.dispose();
          },
        ),
      ),
      body: WillPopScope(
          onWillPop: () {
            _confettiControllerCenter.dispose();
            PageUtils.popCurrentPage();
          },
          child: _buildChildWidget()),
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
    _confettiControllerCenter =
        ConfettiController(duration: const Duration(seconds: 2));

    return RectangleButtonWidget(
      childText: UniversalStrings.nextButtonText,
      onPressed: () {
        if (controller.selectedTime.value == '' ||
            controller.selectedTime.value == null) {
        } else {
          //TODO: Add route
          _showConfirmDialog();
          _confettiControllerCenter.play();
        }
      },
    );
  }

  Widget _confirmMessage() {
    return Text.rich(
      TextSpan(
        text: UniversalStrings.yourAppointmentIsBooked + ' ',
        style: Theme.of(Get.context)
            .textTheme
            .headline5
            .copyWith(fontWeight: FontWeight.normal),
        children: [
          //doc name
          TextSpan(
            text: doctorDetails['name'] + ' ',
            style: Theme.of(Get.context).textTheme.headline4.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
          ),

          //text - on
          TextSpan(
            text: UniversalStrings.onText + ' ',
            style: Theme.of(Get.context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.normal),
          ),

          //text - day
          TextSpan(
            text: dayController.selectedDay.value + ' ',
            style: Theme.of(Get.context).textTheme.headline4.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
          ),

          //text - between

          TextSpan(
            text: UniversalStrings.between + ' ',
            style: Theme.of(Get.context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.normal),
          ),

          //text - time
          TextSpan(
            text: controller.selectedTime.value + ' ',
            style: Theme.of(Get.context).textTheme.headline4.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigateToHomeButton() {
    return RectangleButtonWidget(
      childText: UniversalStrings.home,
      // width: 100,
      onPressed: () {
        //TODO: ADD FUNCTIONALITY
        _confettiControllerCenter.dispose();
        PageUtils.pushPageAndRemoveAll(HomePage());
      },
      isColor: false,
    );
  }

  Widget _buildNavigateToAppointment() {
    return RectangleButtonWidget(
      childText: UniversalStrings.myAppointments,
      // width: 100,
      onPressed: () {
        //TODO: ADD FUNCTIONALITY
        _confettiControllerCenter.dispose();
        PageUtils.pushPageAndRemoveAll(MyAppointments());
      },
      isColor: false,
    );
  }

  Widget _buildImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: UniversalColors.lightBlue,
          width: 4,
          style: BorderStyle.solid,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
        child: CachedNetworkImage(
          imageUrl: doctorDetails['image'],
          progressIndicatorBuilder: (context, url, _) {
            return Center(
              child: CustomProgressIndicatorWidget(
                size: 30,
              ),
            );
          },
          fit: BoxFit.fill,
          height: 80,
          width: 80,
        ),
      ),
    );
  }

  //dialogs
  _showConfirmDialog() {
    showDialog(
      context: Get.context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 5,
          insetAnimationCurve: Curves.bounceIn,
          insetAnimationDuration: Duration(milliseconds: 400),
          child: Stack(
            children: [
              //image
              Align(
                heightFactor: 1,
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiControllerCenter,
                  blastDirectionality: BlastDirectionality
                      .explosive, // don't specify a direction, blast randomly
                  shouldLoop:
                      false, // start again as soon as the animation is finished
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink,
                    Colors.orange,
                    Colors.purple
                  ], //
                  child: Container(
                    // color: UniversalColors.whiteColor,
                    // alignment: Alignment.topCenter,
                    transform: Matrix4Transform().translate(y: -45).matrix4,
                    child: _buildImage(),
                  ),
                ),
              ),

              //body
              Container(
                padding: const EdgeInsets.all(12),
                // height: Get.height * 0.5,
                // color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    //text - congrats
                    Text(
                      UniversalStrings.congratulations,
                      style: Theme.of(Get.context).textTheme.headline5.copyWith(
                            fontSize: 16,
                          ),
                    ),

                    //text - your appoinment is booked

                    SizedBox(
                      height: 20,
                    ),
                    _confirmMessage(),

                    SizedBox(
                      height: 20,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildNavigateToAppointment(),
                        _buildNavigateToHomeButton(),
                      ],
                    ),

                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
