import 'package:animations/animations.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/ui/doctor/home_screens/doctor_all_patients.dart';
import 'package:pcare/ui/doctor/home_screens/doctor_profile.dart';
import 'package:pcare/ui/doctor/home_screens/doctor_todays_appointment.dart';

class DoctorHomePage extends StatefulWidget {
  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  int _page = 0;
  // PageController _pageController;
  GlobalKey _bottomNavigationKey = GlobalKey();
  List<Widget> _pages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadPages();

    // _pageController = PageController(
    //   initialPage: 0,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(),
      body: _buildChildWidget(),
      backgroundColor: UniversalColors.whiteColor,
    );
  }

  Widget _bottomNavigationBar() {
    return CurvedNavigationBar(
      index: _page,
      height: 50,
      backgroundColor: UniversalColors.gradientColorStart.withOpacity(0.7),
      color: UniversalColors.whiteColor,
      buttonBackgroundColor: UniversalColors.whiteColor,
      // key: _bottomNavigationKey,
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
        // _pageController.animateToPage(
        //   _page,
        //   duration: Duration(milliseconds: 300),
        //   curve: Curves.easeInCubic,
        // );
      },
    );
  }

  Widget _buildChildWidget() {
    return PageTransitionSwitcher(
      duration: Duration(milliseconds: 300),
      transitionBuilder: (child, _, __) {
        return SharedAxisTransition(
          animation: _,
          secondaryAnimation: __,
          child: child,
          transitionType: SharedAxisTransitionType.vertical,
        );
      },
      child: _pages[_page],
    );
  }

//methods and on clicks
  void _changePage(int index) {
    setState(() {
      _page = index;
    });
  }

  void _loadPages() {
    _pages.add(DoctorTodaysAppointment());
    _pages.add(DoctorAllPatients());
    _pages.add(DoctorProfile());
  }
}
