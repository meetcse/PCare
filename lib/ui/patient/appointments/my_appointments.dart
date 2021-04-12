import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:matrix4_transform/matrix4_transform.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/api/patient/appointment/GetMyAppointmentsApi.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/flushbar_message/flushbar_message.dart';
import 'package:pcare/models/patient/appointment/AppointmentModel.dart';
import 'package:pcare/ui/patient/view_appointments/view_treatment.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';

class MyAppointments extends StatefulWidget {
  @override
  _MyAppointmentsState createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {
  Future<List<AppointmentModel>> _appointmentModelFuture;

  // List<Map<String, dynamic>> _appointmentDetails = [
  //   {
  //     "date": "20-02-2020",
  //     "details": [
  //       {
  //         "docImage":
  //             "https://cdn.sanity.io/images/0vv8moc6/hcplive/0ebb6a8f0c2850697532805d09d4ff10e838a74b-200x200.jpg?auto=format",
  //         "docName": "Dr. Tapan Shah",
  //         "hospitalName": "Infectious Disease Care",
  //         "appointmentTime": "10:00 am",
  //         "status": "Pending",
  //       },
  //       {
  //         "docImage":
  //             "https://images.theconversation.com/files/304957/original/file-20191203-66986-im7o5.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop",
  //         "docName": "Dr. Joe Biden",
  //         "hospitalName": "Bhailal Amin",
  //         "appointmentTime": "10:00 am",
  //         "status": "Pending",
  //       },
  //       {
  //         "docImage":
  //             "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRtcAdqTgmM7vV8XEkpGumjp0Mcg4TsjTBPQ&usqp=CAU",
  //         "docName": "Dr. Shriya Shah",
  //         "hospitalName": "MVC",
  //         "appointmentTime": "10:00 am",
  //         "status": "Pending",
  //       }
  //     ]
  //   },
  //   {
  //     "date": "21-02-2020",
  //     "details": [
  //       {
  //         "docImage":
  //             "https://thumbs.dreamstime.com/b/beautiful-arab-female-doctor-posing-isolated-white-background-34173775.jpg",
  //         "docName": "Dr. Mirant Patel",
  //         "hospitalName": "Codec",
  //         "appointmentTime": "11:00 am",
  //         "status": "Approved",
  //       }
  //     ]
  //   },
  //   {
  //     "date": "22-02-2020",
  //     "details": [
  //       {
  //         "docImage":
  //             "https://static.toiimg.com/photo/msid-76714980/76714980.jpg?1422821",
  //         "docName": "Dr. Akash Joshi",
  //         "hospitalName": "Divya Clinic",
  //         "appointmentTime": "12:00 pm",
  //         "status": "Pending",
  //       },
  //       {
  //         "docImage":
  //             "https://www.lumahealth.io/wp-content/uploads/2018/05/Transparency-in-the-Doctor-Patient-Relationship-1.jpg",
  //         "docName": "Dr. Mona Shah",
  //         "hospitalName": "Monal Hospital",
  //         "appointmentTime": "10:00 am",
  //         "status": "Pending",
  //       }
  //     ]
  //   },
  // ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalColors.whiteColor,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return FutureBuilder(
        future: _appointmentModelFuture,
        builder: (context,
            AsyncSnapshot<List<AppointmentModel>> appointmentModelList) {
          if (!appointmentModelList.hasData) {
            return CustomProgressIndicatorWidget();
          }

          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 20),
              child:

                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   physics: NeverScrollableScrollPhysics(),
                  //   itemCount: appointmentModelList.data.length,
                  //   itemBuilder: (context, index) {

                  //     return GestureDetector(
                  //       onTap: () {
                  //         PageUtils.pushPage(ViewTreatment());
                  //       },
                  //       child: Column(
                  //         children: [
                  //           SizedBox(
                  //             height: 16,
                  //           ),
                  //           Row(
                  //             children: [
                  //               Expanded(
                  //                   child: Divider(
                  //                 endIndent: 8,
                  //               )),
                  //               Text(
                  //                 _appointmentDetails[index]["date"],
                  //                 style: Theme.of(context).textTheme.headline4.copyWith(
                  //                       fontSize: 16,
                  //                       fontWeight: FontWeight.normal,
                  //                     ),
                  //               ),
                  //               Expanded(
                  //                   child: Divider(
                  //                 indent: 8,
                  //               )),
                  //             ],
                  //           ),
                  ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: appointmentModelList.data.length,
                itemBuilder: (context, index) {
                  AppointmentModel _appointmentModel =
                      appointmentModelList.data[index];
                  return GestureDetector(
                    onTap: () {
                      if (_appointmentModel.full_treatment_id != null &&
                          _appointmentModel.full_treatment_id.isNotEmpty) {
                        _gotoViewTreatmentScreen(
                            _appointmentModel.full_treatment_id);
                      }
                    },
                    child: _buildDoctorsCard(
                        doctorName: _appointmentModel.doctorId.user.firstName +
                            " " +
                            _appointmentModel.doctorId.user.lastName,
                        hospitalName:
                            _appointmentModel.doctorId.hospital_id.hospitalName,
                        imageUrl: _appointmentModel.doctorId.user.profilePic,
                        id: _appointmentModel.sId,
                        appointmentTime: _appointmentModel.appointmentTime,
                        appointmentDate: getDateTimeInStringFromUTC(
                            _appointmentModel.appointmentDate),
                        status: _appointmentModel.status,
                        isFullTreatment: (_appointmentModel.full_treatment_id !=
                                    null &&
                                _appointmentModel.full_treatment_id.isNotEmpty)
                            ? true
                            : false),
                  );
                },
              ),
              //         ],
              //       ),
              //     );
              //   },
              // ),
            ),
          );
        });
  }

  Widget _buildAppBar() {
    return MainAppBarWidget(
      leading: BackButtonWidget(),
      title: UniversalStrings.myAppointments,
    );
  }

  Widget _buildDoctorsCard(
      {@required String doctorName,
      @required String hospitalName,
      @required String imageUrl,
      @required String id,
      @required String appointmentTime,
      @required String appointmentDate,
      @required String status,
      @required bool isFullTreatment}) {
    return Container(
      margin: const EdgeInsets.only(
        left: 12,
        // right: 4,
        top: 16,
      ),
      decoration: BoxDecoration(
        color: UniversalColors.doctorListBackgroundColor.withOpacity(0.5),
        borderRadius: BorderRadius.all(
          Radius.circular(14),
        ),
      ),
      child: Row(
        children: [
          //Profile Image
          Container(
            transform: Matrix4Transform().translate(x: -12, y: -12).matrix4,
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                progressIndicatorBuilder: (context, url, _) {
                  return Center(
                      child: CustomProgressIndicatorWidget(
                    size: 30,
                  ));
                },
                fit: BoxFit.cover,
                height: 100,
                width: 100,
              ),
            ),
          ),
          SizedBox(
            width: 12,
          ),

          //Doc details
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12,
                ),
                //doc name
                Text(
                  doctorName,
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                ),

                //hos name
                Text(
                  hospitalName,
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                ),

                Container(
                  padding: const EdgeInsets.only(right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        appointmentTime,
                        style: Theme.of(context).textTheme.headline4.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        appointmentDate,
                        style: Theme.of(context).textTheme.headline4.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        status,
                        style: Theme.of(context).textTheme.headline4.copyWith(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                      ),
                      isFullTreatment
                          ? Text(
                              "--->",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                  ),
                            )
                          : Container(),
                    ],
                  ),
                ),

                //type of doc and specialist

                //TODO: CHANGE WITH PROPER TEXT
                SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//methods amd on clicks
  void _callApi() {
    GetMyAppointmentsApi _api = GetMyAppointmentsApi();
    _appointmentModelFuture = _api.getCurrentAppointment().catchError((error) {
      print("ERROR IN GETTING APPOINTMENT : " + error.toString());
      FlushbarMessage.errorMessage(Get.context, error.toString());
    });
  }

  String getDateTimeInStringFromUTC(String dateTime) {
    DateTime _dateTime = DateTime.parse(dateTime);
    DateTime dateLocal = _dateTime.toLocal();

    String _format = DateFormat("dd-MM-yyyy").format(dateLocal);

    return _format.toString();
  }

  void _gotoViewTreatmentScreen(String fullTreatmentId) {
    PageUtils.pushPage(ViewTreatment(fullTreatmentId: fullTreatmentId));
  }
}
