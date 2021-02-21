import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:matrix4_transform/matrix4_transform.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/ui/patient/view_appointments/view_treatment.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';

class MyAppointments extends StatefulWidget {
  @override
  _MyAppointmentsState createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {
  List<Map<String, dynamic>> _appointmentDetails = [
    {
      "date": "20-02-2020",
      "details": [
        {
          "docImage":
              "https://cdn.sanity.io/images/0vv8moc6/hcplive/0ebb6a8f0c2850697532805d09d4ff10e838a74b-200x200.jpg?auto=format",
          "docName": "Dr. Tapan Shah",
          "hospitalName": "Infectious Disease Care",
          "appointmentTime": "10:00 am",
          "status": "Pending",
        },
        {
          "docImage":
              "https://images.theconversation.com/files/304957/original/file-20191203-66986-im7o5.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop",
          "docName": "Dr. Joe Biden",
          "hospitalName": "Bhailal Amin",
          "appointmentTime": "10:00 am",
          "status": "Pending",
        },
        {
          "docImage":
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRtcAdqTgmM7vV8XEkpGumjp0Mcg4TsjTBPQ&usqp=CAU",
          "docName": "Dr. Shriya Shah",
          "hospitalName": "MVC",
          "appointmentTime": "10:00 am",
          "status": "Pending",
        }
      ]
    },
    {
      "date": "21-02-2020",
      "details": [
        {
          "docImage":
              "https://thumbs.dreamstime.com/b/beautiful-arab-female-doctor-posing-isolated-white-background-34173775.jpg",
          "docName": "Dr. Mirant Patel",
          "hospitalName": "Codec",
          "appointmentTime": "11:00 am",
          "status": "Approved",
        }
      ]
    },
    {
      "date": "22-02-2020",
      "details": [
        {
          "docImage":
              "https://static.toiimg.com/photo/msid-76714980/76714980.jpg?1422821",
          "docName": "Dr. Akash Joshi",
          "hospitalName": "Divya Clinic",
          "appointmentTime": "12:00 pm",
          "status": "Pending",
        },
        {
          "docImage":
              "https://www.lumahealth.io/wp-content/uploads/2018/05/Transparency-in-the-Doctor-Patient-Relationship-1.jpg",
          "docName": "Dr. Mona Shah",
          "hospitalName": "Monal Hospital",
          "appointmentTime": "10:00 am",
          "status": "Pending",
        }
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _appointmentDetails.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  PageUtils.pushPage(ViewTreatment());
                },
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Divider()),
                        Text(
                          _appointmentDetails[index]["date"],
                          style: Theme.of(context).textTheme.headline4.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _appointmentDetails[index]["details"].length,
                        itemBuilder: (context, innerIndex) {
                          return Column(
                            children: [
                              _buildDoctorsCard(
                                  doctorName: _appointmentDetails[index]
                                      ["details"][innerIndex]["docName"],
                                  hospitalName: _appointmentDetails[index]
                                      ["details"][innerIndex]["hospitalName"],
                                  imageUrl: _appointmentDetails[index]
                                      ["details"][innerIndex]["docImage"],
                                  id: innerIndex.toString(),
                                  appointmentTime: _appointmentDetails[index]
                                          ["details"][innerIndex]
                                      ["appointmentTime"],
                                  status: _appointmentDetails[index]["details"]
                                      [innerIndex]["status"])
                            ],
                          );
                        })
                  ],
                ),
              );
            }));
  }

  Widget _buildAppBar() {
    return MainAppBarWidget(
      leading: BackButtonWidget(),
      title: UniversalStrings.myAppointments,
    );
  }

  Widget _buildDoctorsCard({
    @required String doctorName,
    @required String hospitalName,
    @required String imageUrl,
    @required String id,
    @required String appointmentTime,
    @required String status,
  }) {
    return Container(
      margin: const EdgeInsets.only(
        left: 22,
        right: 12,
        top: 5,
      ),
      decoration: BoxDecoration(
        color: UniversalColors.doctorListBackgroundColor,
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
                width: 90,
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

                Text(
                  appointmentTime,
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                      ),
                ),

                Text(
                  status,
                  style: Theme.of(context).textTheme.headline4.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
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
}
