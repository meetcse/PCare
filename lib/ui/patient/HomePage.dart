import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/app_icons.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/ui/patient/appointments/my_appointments.dart';
import 'package:pcare/ui/patient/appointments/search_doctor.dart';
import 'package:pcare/ui/patient/patient_todos.dart';
import 'package:pcare/ui/patient/view_appointments/view_single_appointment.dart';
import 'package:pcare/ui/patient/wishlist.dart';
import 'package:pcare/widgets/drawer_icon_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';
import 'package:pcare/widgets/patients/patient_drawer_widget.dart';
import 'package:pcare/widgets/single_chip_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> _loggedInUser = {
    "username": "John",
  };

  List<Map<String, dynamic>> _carouselImages = [
    {
      "image": 'assets/images/doctor1.jpg',
    },
    {
      "image": 'assets/images/doctor2.jpg',
    },
    {
      "image": 'assets/images/doctor3.png',
    },
  ];

  List<Map<String, dynamic>> _categories = [
    {
      'id': UniversalStrings.bookAppointmentId,
      'name': UniversalStrings.bookAppointment,
      "color": UniversalColors.gradientColorStart,
      "icon": UniversalIcons.bookAppointmentIcon,
      'navigateTo': SearchDoctor(),
    },
    {
      "id": UniversalStrings.myAppointmentsId,
      "name": UniversalStrings.myAppointments,
      "color": UniversalColors.gradientColorStart,
      "icon": UniversalIcons.myAppointments,
      'navigateTo': MyAppointments(),
    },
    {
      "id": UniversalStrings.wishlistId,
      "name": UniversalStrings.wishlist,
      "color": UniversalColors.gradientColorStart,
      "icon": UniversalIcons.wishlistDoctors,
      'navigateTo': Wishlist(),
    },
    {
      "id": UniversalStrings.currentTreatmentId,
      "name": UniversalStrings.currentTreatment,
      "color": UniversalColors.gradientColorStart,
      "icon": UniversalIcons.currentTreatment,
      'navigateTo': ViewSingleAppointment(),
    },
    {
      "id": UniversalStrings.todosId,
      "name": UniversalStrings.todos,
      "color": UniversalColors.gradientColorStart,
      "icon": UniversalIcons.todos,
      'navigateTo': PatientTodos(),
    }
  ];

  bool _isChange = false;
  int _currentIndexForCarousel = 0;

  changeAppBarTitle() async {
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _isChange = true;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // changeAppBarTitle();
  }

  _getCarouselImages() {
    List _images = [];
    _carouselImages.forEach((element) {
      _images.add(
        Image(
          image: AssetImage(element['image']),
        ),
      );
    });
    return _images;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: PatientDrawerWidget(),
      drawerEnableOpenDragGesture: false,
      appBar: MainAppBarWidget(
        leading: DrawerIconWidget(),
        //TODO: ADD ANIMATED TITLE IF POSSIBLE
        title: UniversalStrings.welcome + ' ' + _loggedInUser['username'] + '!',
      ),
      body: _buildChildWidget(context),
    );
  }

  Widget _buildChildWidget(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.only(top: 0),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            //Image Slider
            Container(
              alignment: Alignment.topCenter,
              height: 200,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(left: 8, right: 8),
              child: Carousel(
                images: _getCarouselImages(),
                dotBgColor: Colors.transparent,
                autoplay: true,
                boxFit: BoxFit.fill,
              ),
            ),

            Flexible(
              fit: FlexFit.loose,
              child: _buildChips(),
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChips() {
    return Container(
      margin: const EdgeInsets.only(left: 14, right: 14, top: 14),
      child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio:
                MediaQuery.of(context).size.width <= 360 ? 1.1 : 90 / 70,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                PageUtils.pushPage(_categories[index]['navigateTo']);
              },
              child: SingleChipWidget(
                childText: _categories[index]['name'],

                icon: _categories[index]['icon'],

                // color: _categories[index]['color'],
              ),
            );
          }),
    );
  }
}
