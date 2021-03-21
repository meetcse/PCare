import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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
import 'package:pcare/widgets/rectangle_button_widget.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // changeAppBarTitle();
  }

  List<Widget> _getCarouselImages() {
    List<Widget> _images = [];
    _carouselImages.forEach((element) {
      _images.add(
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image(
            image: AssetImage(
              element['image'],
            ),
            fit: BoxFit.fill,
          ),
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
            _buildCarouselSlider(),

            Flexible(
              fit: FlexFit.loose,
              child: _buildListView(),
              // _buildChips(),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselSlider() {
    return Container(
      alignment: Alignment.topCenter,
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
          autoPlayAnimationDuration: Duration(milliseconds: 500),
          viewportFraction: 0.74,
          autoPlayCurve: Curves.easeInCirc,
        ),
        items: _getCarouselImages(),
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

  Widget _buildListView() {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> _category = _categories[index];
            return _buildBodyCard(
              _category['name'],
              _category['icon'],
              _category['navigateTo'],
            );
          }),
    );
  }

  Widget _buildBodyCard(String name, IconData icon, Widget navigateTo) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: RectangleButtonWidget(
        childText: name,
        width: Get.width,
        icon: Icon(
          icon,
        ),
        onPressed: () {
          _changeScreen(navigateTo);
        },
      ),
    );
  }

  //methods and on clicks
  void _changeScreen(Widget page) {
    PageUtils.pushPage(page);
  }
}
