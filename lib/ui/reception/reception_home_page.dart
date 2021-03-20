import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/ui/reception/home_screens/accept_appointment_request.dart';
import 'package:pcare/ui/reception/home_screens/receptionist_profile.dart';
import 'package:pcare/ui/reception/home_screens/upcoming_appointments.dart';

class ReceptionHomePage extends StatefulWidget {
  @override
  _ReceptionHomePageState createState() => _ReceptionHomePageState();
}

class _ReceptionHomePageState extends State<ReceptionHomePage> {
  int _page = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: _bottomNavigationBar(),
        body: _buildChildWidget(),
        backgroundColor: UniversalColors.whiteColor,
      ),
    );
  }

  Widget _bottomNavigationBar() {
    return CurvedNavigationBar(
      index: _page,
      height: 50,
      backgroundColor: UniversalColors.gradientColorStart.withOpacity(0.7),
      color: UniversalColors.whiteColor,
      buttonBackgroundColor: UniversalColors.whiteColor,
      items: <Widget>[
        Image(
          image: AssetImage('assets/images/appointment.jpg'),
          height: 20,
          width: 20,
        ),
        Image(
          image: AssetImage('assets/images/patient.png'),
          height: 20,
          width: 20,
        ),
        Image(
          image: AssetImage('assets/images/profiledefault.png'),
          height: 20,
          width: 20,
        ),
      ],
      onTap: (index) {
        _changePage(index);
        _pageController.animateToPage(
          _page,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInCubic,
        );
      },
    );
  }

  //methods and on clicks
  void _changePage(int index) {
    setState(() {
      _page = index;
    });
  }

  Widget _buildChildWidget() {
    return PageView(
      controller: _pageController,
      onPageChanged: _changePage,
      // physics: NeverScrollableScrollPhysics(),
      children: [
        UpcomingAppointments(),
        AcceptAppointmentRequest(),
        ReceptionistProfile(),
      ],
    );
  }
}
