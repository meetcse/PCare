import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/doctor/doctor_strings.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/doctor/doctor_app_bar_widget.dart';
import 'package:pcare/widgets/text_field_widget.dart';

class DoctorAllPatients extends StatelessWidget {
  List<Map<String, dynamic>> _patients = [
    {
      "id": "1",
      "name": "Pranav Suthar",
      "city": "Vadodara",
      "age": "21",
      "status": "On Going",
      "image":
          "https://images.pexels.com/photos/1080213/pexels-photo-1080213.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
    },
    {
      "id": "2",
      "name": "Marcus NG",
      "city": "Bihar",
      "age": "25",
      "status": "On Going",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCexMzvTjX8oflMcyjjCL8JaeeKwqsmanIuw&usqp=CAU",
    },
    {
      "id": "3",
      "name": "Gautam Vyas",
      "city": "Ahmedabad",
      "age": "30",
      "status": "Completed",
      "image":
          "https://adultballet.com.au/wp-content/uploads/2017/02/unnamed-1.jpg",
    },
    {
      "id": "4",
      "name": "Darpan Suthar",
      "city": "Surat",
      "age": "32",
      "status": "On Going",
      "image": "https://jooinn.com/images/portrait-of-young-man-2.jpg",
    },
    {
      "id": "5",
      "name": "Mitesh Patel",
      "city": "Valsad",
      "age": "45",
      "status": "Completed",
      "image":
          "https://t4.ftcdn.net/jpg/02/45/56/35/360_F_245563558_XH9Pe5LJI2kr7VQuzQKAjAbz9PAyejG1.jpg",
    },
    {
      "id": "6",
      "name": "Viay Patel",
      "city": "Mumbai",
      "age": "28",
      "status": "On Going",
      "image":
          "https://t4.ftcdn.net/jpg/03/03/54/59/360_F_303545914_XLEAix36kSd78qCl4XYhl2S1iYSA9IyW.jpg",
    },
    {
      "id": "7",
      "name": "Dipen Biden",
      "city": "Pune",
      "age": "33",
      "status": "Completed",
      "image":
          "https://st2.depositphotos.com/4196725/6217/i/950/depositphotos_62170113-stock-photo-young-cool-black-man-no.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      backgroundColor: UniversalColors.whiteColor,
    );
  }

  Widget _buildAppBar() {
    return DoctorAppbarWidget(
      title: DoctorUniversalStrings.myPatients,
    );
  }

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(height: 16),
          _buildSearchBar(),
          // SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: _buildPatientsList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextFieldWidget(
      labelText: UniversalStrings.searchPatient,
      margin: const EdgeInsets.all(0),
      prefixIcon: Icon(
        CupertinoIcons.search,
      ),
    );
  }

  Widget _buildPatientsList() {
    return Container(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _patients.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  _patientCard(
                    _patients[index],
                  ),
                  SizedBox(height: 8),
                  index == _patients.length - 1 ? Container() : Divider(),
                ],
              ),
            );
          }),
    );
  }

  Widget _patientCard(Map<String, dynamic> patient) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: CachedNetworkImage(
            progressIndicatorBuilder: (context, _, __) {
              return CustomProgressIndicatorWidget();
            },
            imageUrl: patient["image"],
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              patient["name"],
              style: Theme.of(Get.context).textTheme.headline4.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Text(
                  patient["city"],
                  style: Theme.of(Get.context).textTheme.headline5.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                ),
                SizedBox(width: 15),
                Text(
                  patient["age"],
                  style: Theme.of(Get.context).textTheme.headline5.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ],
            )
          ],
        ),
        patient["status"] == "On Going"
            ? Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                      decoration: BoxDecoration(
                        color: UniversalColors.green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        DoctorUniversalStrings.onGoing,
                        style:
                            Theme.of(Get.context).textTheme.headline5.copyWith(
                                  fontSize: 12,
                                  color: UniversalColors.black,
                                ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }
}
