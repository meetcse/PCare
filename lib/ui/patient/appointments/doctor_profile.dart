import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';

class DoctorProfile extends StatefulWidget {
  final Map<String, dynamic> doctorDetails;
  DoctorProfile({@required this.doctorDetails});
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildChildWidget(),
    );
  }

  Widget _buildChildWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildImage(),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),

                //study or doc type
                _buildDoctorTypeAndSpecialist(),
                SizedBox(height: 10),

                //hospital name
                _buildHospitalNameAndSpecialist(),

                SizedBox(height: 10),
                //hospital address
                _buildAddress(),

                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorTypeAndSpecialist() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.doctorDetails['type'],
          style: Theme.of(context).textTheme.headline5.copyWith(
                fontSize: 16,
              ),
        ),
        widget.doctorDetails['specialist']
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
      widget.doctorDetails['address'],
      style: Theme.of(context).textTheme.headline5,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildHospitalNameAndSpecialist() {
    return Container(
      child: Text(
        UniversalStrings.at + ' ' + widget.doctorDetails['hospital'],
        style: Theme.of(Get.context).textTheme.headline5.copyWith(
              fontSize: 16,
            ),
      ),
    );
  }

  Widget _buildAppBar() {
    return MainAppBarWidget(
      title: widget.doctorDetails['name'],
      leading: BackButtonWidget(),
    );
  }

  Widget _buildImage() {
    return Hero(
      tag: widget.doctorDetails['id'],
      child: CachedNetworkImage(
        imageUrl: widget.doctorDetails['image'],
        progressIndicatorBuilder: (context, url, _) {
          return Center(
            child: CustomProgressIndicatorWidget(
              size: 30,
            ),
          );
        },
        fit: BoxFit.fill,
        height: 280,
        width: Get.width,
      ),
    );
  }
}
