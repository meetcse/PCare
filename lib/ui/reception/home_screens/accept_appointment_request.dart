import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pcare/api/receptionist/ReceptIncomingAppointmentsApi.dart';
import 'package:pcare/constants/reception/reception_strings.dart';
import 'package:pcare/flushbar_message/flushbar_message.dart';
import 'package:pcare/models/receptionist/IncomingAppointmentsModel.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/receptionist/receptionist_app_bar_widget.dart';

class AcceptAppointmentRequest extends StatefulWidget {
  @override
  _AcceptAppointmentRequestState createState() =>
      _AcceptAppointmentRequestState();
}

class _AcceptAppointmentRequestState extends State<AcceptAppointmentRequest> {
  List<String> _acceptedIds = [];
  List<String> _declinedIds = [];
  Future<List<IncomingAppointmentModel>> _incomingAppModelFuture;
  ReceptIncomingAppointmentAPI _api = ReceptIncomingAppointmentAPI();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _callIncomingAppointmentsAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      backgroundColor: Color(0xffF3F6FF).withOpacity(0.134),
    );
  }

  Widget _buildBody() {
    return FutureBuilder(
        future: _incomingAppModelFuture,
        builder: (context,
            AsyncSnapshot<List<IncomingAppointmentModel>> incomingAppModel) {
          if (!incomingAppModel.hasData) {
            return Center(
              child: CustomProgressIndicatorWidget(),
            );
          }
          if (incomingAppModel.data != null &&
              (incomingAppModel.data == [] || incomingAppModel.data.isEmpty)) {
            return Center(
                child: Text("NO REQUEST Found",
                    style: Theme.of(context).textTheme.headline2));
          }

          IncomingAppointmentModel _model = incomingAppModel.data[0];
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: _buildAppointmentsList(_model),
          );
        });
  }

  Widget _buildAppBar() {
    return ReceptionistAppbarWidget(
      title: ReceptionUniversalStrings.appointmentRequest,
    );
  }

  Widget _buildAppointmentsList(
      IncomingAppointmentModel incomingAppointmentModel) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: incomingAppointmentModel.newAppointment.length,
        itemBuilder: (context, index) {
          NewAppointment _newAppointment =
              incomingAppointmentModel.newAppointment[index];
          return Card(
            margin: EdgeInsets.all(10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 8,
            child: Column(
              children: [
                buildUpperPart(_newAppointment),
                buildMiddlePart(_newAppointment),
                buildLowerPart(_newAppointment),
              ],
            ),
          );
        });
  }

  Widget buildUpperPart(NewAppointment newAppointment) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        color: Color(0xff2C8BFF),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Appointment Request",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 5),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 5)),
                  Icon(
                    Icons.alarm,
                    color: Colors.white,
                    size: 20,
                  ),
                ],
              ),
              SizedBox(width: 5),
              Expanded(
                flex: 0,
                child: Text(
                    _getStringDateFromUtc(newAppointment.appointmentDate) +
                        ", ",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.white)),
              ),
              Expanded(
                child: Text(newAppointment.appointmentTime,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildMiddlePart(NewAppointment newAppointment) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: CachedNetworkImage(
              progressIndicatorBuilder: (context, _, __) {
                return CustomProgressIndicatorWidget();
              },
              imageUrl: newAppointment.patientId.user.profilePic,
              height: 80,
              width: 80,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 0,
                      child: Text(
                        "Patient : ",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                        child: Text(newAppointment.patientId.user.firstname +
                            " " +
                            newAppointment.patientId.user.lastname)),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 0,
                      child: Text(
                        "Doctor : ",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(color: Colors.black),
                      ),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        newAppointment.doctorId.user.firstname +
                            " " +
                            newAppointment.doctorId.user.lastname,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildLowerPart(NewAppointment newAppointment) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildAcceptButton(newAppointment),
          _buildDeclineButton(newAppointment),
        ],
      ),
    );
  }

  Widget _buildDeclineButton(NewAppointment newAppointment) {
    return GestureDetector(
      onTap: () {
        _addIdToDeclinedId(newAppointment.sId);
        setState(() {});
        _updateAppointmentAPI(2, newAppointment.sId);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(vertical: 5),
        width: _getIdIsDeclined(newAppointment.sId) ? 35 : Get.width / 2 - 60,
        child: _getIdIsDeclined(newAppointment.sId)
            ? CircularProgressIndicator()
            : Center(
                child: Text(
                  "DECLINE",
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: Colors.black),
                ),
              ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: _getIdIsDeclined(newAppointment.sId)
              ? Colors.transparent
              : Color(0xffF3F6FF),
        ),
      ),
    );
  }

  Widget _buildAcceptButton(NewAppointment newAppointment) {
    return GestureDetector(
      onTap: () {
        _addIdToAcceptedId(newAppointment.sId);
        setState(() {});
        _updateAppointmentAPI(1, newAppointment.sId);
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(vertical: 5),
        width: _getIdIsAccepted(newAppointment.sId) ? 35 : Get.width / 2 - 60,
        child: _getIdIsAccepted(newAppointment.sId)
            ? CircularProgressIndicator()
            : Center(
                child: Text(
                  "ACCEPT",
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(color: Colors.white),
                ),
              ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: _getIdIsAccepted(newAppointment.sId)
              ? Colors.transparent
              : Color(0xff2C8BFF),
        ),
      ),
    );
  }

  //methods

  void _callIncomingAppointmentsAPI() {
    _incomingAppModelFuture =
        _api.getIncomingAppointments().catchError((error) {
      print("ERROR : " + error.toString());
      FlushbarMessage.errorMessage(Get.context, "Something went wrong");
    });
  }

  void _updateAppointmentAPI(int status, String appointmentId) async {
    var _response = await _api
        .updateAppointmentStatus(status, appointmentId)
        .catchError((error) {
      print("ERROR IN UPDATING APPOINTMENT : " + error.toString());
      FlushbarMessage.errorMessage(Get.context, "Something went wrong");
      // FlushbarM
    });

    if (_response['success'] != null) {
      if (_response['appointment']['status']
          .toLowerCase()
          .contains("accepted")) {
        _removeIdFromAcceptedId(_response['appointment']['_id']);
        _callIncomingAppointmentsAPI();
        setState(() {});
      } else {
        _removeIdFromDeclinedId(_response['appointment']['_id']);
        _callIncomingAppointmentsAPI();
        setState(() {});
      }
    }
  }

  String _getStringDateFromUtc(String dateTime) {
    DateTime _dateTime = DateTime.parse(dateTime);
    DateTime dateLocal = _dateTime.toLocal();

    String _format = DateFormat("dd-MM-yyyy").format(dateLocal);

    return _format.toString();
  }

  bool _getIdIsAccepted(String appointmentId) {
    bool _isId = false;
    _acceptedIds.forEach((id) {
      if (id.toLowerCase() == appointmentId.toLowerCase()) {
        _isId = true;
      }
    });

    return _isId;
  }

  bool _getIdIsDeclined(String appointmentId) {
    bool _isId = false;
    _declinedIds.forEach((id) {
      if (id.toLowerCase() == appointmentId.toLowerCase()) {
        _isId = true;
      }
    });

    return _isId;
  }

  void _addIdToAcceptedId(String appointmentId) {
    _acceptedIds.add(appointmentId);
  }

  void _addIdToDeclinedId(String appointmentId) {
    _declinedIds.add(appointmentId);
  }

  void _removeIdFromAcceptedId(String appointmentId) {
    _acceptedIds.removeWhere(
        (element) => element.toLowerCase() == appointmentId.toLowerCase());
  }

  void _removeIdFromDeclinedId(String appointmentId) {
    _declinedIds.removeWhere(
        (element) => element.toLowerCase() == appointmentId.toLowerCase());
  }
}
