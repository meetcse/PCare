import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrix4_transform/matrix4_transform.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/app_icons.dart';
import 'package:pcare/constants/patient/doctor_specialist_list.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/store/patients/appointments/search_doctor_controller.dart';
import 'package:pcare/ui/patient/appointments/doctor_profile.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/chip_three_section_widget.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';
import 'package:pcare/widgets/text_field_widget.dart';

class SearchDoctor extends StatefulWidget {
  @override
  _SearchDoctorState createState() => _SearchDoctorState();
}

class _SearchDoctorState extends State<SearchDoctor> {
  //TODO: CHANGE TO DYNAMIC
  Map<String, dynamic> _loggedInUser = {
    "username": "John",
    "age": "20",
    "gender": "Male",
    "mobile": "+91 8980772697",
    "city": "Vadodara"
  };

  //TODO: CHange with dynamic list from database
  List<Map<String, dynamic>> _totalDoctorsStaticList = [
    {
      "id": "1",
      "name": "Dr. Joe Biden",
      "hospital": "Bhailal Amin",
      "type": "Cardialogist",
      "specialist": true,
      "address": "23 street 1, Gotri, vadodara",
      "working_day": "Monday-Saturday",
      "working_hour": ["10:00 AM to 12:00 PM", "4:00 PM to 6:00 PM"],
      "image":
          "https://cdn.sanity.io/images/0vv8moc6/hcplive/0ebb6a8f0c2850697532805d09d4ff10e838a74b-200x200.jpg?auto=format",
    },
    {
      "id": "2",
      "name": "Dr. Shriya Shah",
      "hospital": "MVC",
      "type": "Audiologist",
      "specialist": true,
      "address": "23 street 1, Gorwa, vadodara",
      "working_day": "Monday-Thursday",
      "working_hour": ["10:00 AM to 12:00 PM", "6:00 PM to 8:00 PM"],
      "image":
          "https://images.theconversation.com/files/304957/original/file-20191203-66986-im7o5.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop",
    },
    {
      "id": "3",
      "name": "Dr. Mirant Patel",
      "hospital": "Codec",
      "type": "Maxillofacial",
      "specialist": true,
      "address": "23 street 1, Gorwa, vadodara",
      "working_day": "Monday, Tuesday, Friday, Saturday",
      "working_hour": [
        "10:00 AM to 12:00 PM",
        "2:00 PM to 4:00 PM",
        "6:00 PM to 8:00 PM"
      ],
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRtcAdqTgmM7vV8XEkpGumjp0Mcg4TsjTBPQ&usqp=CAU",
    },
    {
      "id": "4",
      "name": "Dr. Mona Shah",
      "hospital": "Monal Hospital",
      "type": "M.D",
      "specialist": false,
      "address": "23 street 1, Gorwa, vadodara",
      "working_day": "Monday-Thursday",
      "working_hour": ["10:00 AM to 12:00 PM", "6:00 PM to 8:00 PM"],
      "image":
          "https://thumbs.dreamstime.com/b/beautiful-arab-female-doctor-posing-isolated-white-background-34173775.jpg",
    },
    {
      "id": "5",
      "name": "Dr. Akash Joshi",
      "hospital": "Divya Clinic",
      "type": "ENT",
      "specialist": true,
      "address": "23 street 1, Gorwa, ahmedabad",
      "working_day": "Monday, Thursday, Saturday",
      "working_hour": ["10:00 AM to 12:00 PM", "6:00 PM to 8:00 PM"],
      "image":
          "https://static.toiimg.com/photo/msid-76714980/76714980.jpg?1422821",
    },
    {
      "id": "6",
      "name": "Dr. Tapan Shah",
      "hospital": "Infectious Disease Care",
      "type": "Skin",
      "specialist": false,
      "address": "23 street 1, jodhpur, ahmedabad",
      "working_day": "Monday-Thursday",
      "working_hour": [
        "10:00 AM to 12:00 PM",
        "2:00 PM to 3:00 PM",
        "6:00 PM to 8:00 PM"
      ],
      "image":
          "https://www.lumahealth.io/wp-content/uploads/2018/05/Transparency-in-the-Doctor-Patient-Relationship-1.jpg",
    },
    {
      "id": "7",
      "name": "Dr. Divya Trivedi",
      "hospital": "We Care",
      "type": "Hernia Surgeon",
      "specialist": true,
      "address": "23 street 1, december villa, ahmedabad",
      "working_day": "Monday-Thursday",
      "working_hour": ["10:00 AM to 12:00 PM", "6:00 PM to 8:00 PM"],
      "image":
          "https://toppng.com/uploads/preview/female-doctor-png-picture-indian-lady-doctor-11562855283suvdrc34qc.png",
    },
    {
      "id": "8",
      "name": "Dr. Pradip Bhatt",
      "hospital": "TCP",
      "type": "Audiologist",
      "specialist": true,
      "address": "23 street 1, satellite, ahmedabad",
      "working_day": "Monday-Thursday",
      "working_hour": ["10:00 AM to 12:00 PM", "6:00 PM to 8:00 PM"],
      "image":
          "https://img.freepik.com/free-photo/friendly-indian-doctor-reviewing-medical-history-tablet_1262-12661.jpg?size=626&ext=jpg&ga=GA1.2.563753139.1611446400",
    },
    {
      "id": "9",
      "name": "Dr. Pavan Solanki",
      "hospital": "Amba Health Care",
      "type": "Orthopedic",
      "specialist": true,
      "address": "23 street 1, sim city, adalaj",
      "working_day": "Monday-Thursday",
      "working_hour": ["10:00 AM to 12:00 PM", "6:00 PM to 8:00 PM"],
      "image":
          "https://www.pinnaclecare.com/wp-content/uploads/2017/12/bigstock-African-young-doctor-portrait-28825394.jpg.webp",
    },
    {
      "id": "10",
      "name": "Dr. Harit Bhatt",
      "hospital": "GMC",
      "type": "M.D",
      "specialist": false,
      "address": "23 street 1, infocity, gandhinagar",
      "working_day": "Monday-Thursday",
      "working_hour": ["10:00 AM to 12:00 PM", "6:00 PM to 8:00 PM"],
      "image":
          "https://www.nutritionfactors.com/blog/wp-content/uploads/2019/12/Male-doctor-smiling-portrait-close-up-Med-Res-72991363.jpg",
    },
  ];

  TextEditingController _searchTextEditingController = TextEditingController();

  DoctorSpecialistList _specialistList = DoctorSpecialistList();

  SearchDoctorController searchDoctorController =
      Get.put(SearchDoctorController());

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchDoctorController.setSelectedDoctorId('');
    searchDoctorController.setIsSearching(false);
  }

  //WIdgets ------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarWidget(
        leading: BackButtonWidget(),
        title: UniversalStrings.selectDoctor,
      ),
      body: Container(child: _buildChildWidget()),
      floatingActionButton: GetX<SearchDoctorController>(builder: (controller) {
        return controller.selectedDoctorId.value != null &&
                controller.selectedDoctorId.value != ''
            ? FloatingActionButton(
                onPressed: () {
                  Map<String, dynamic> _selectedDoctor;
                  _totalDoctorsStaticList.forEach((element) {
                    if (element['id'].toString() ==
                        controller.selectedDoctorId.value) {
                      _selectedDoctor = element;
                    }
                  });

                  PageUtils.pushPage(
                      DoctorProfile(doctorDetails: _selectedDoctor));
                },
                child: Icon(
                  UniversalIcons.forwardArrow,
                ),
              )
            : Container();
      }),
    );
  }

  Widget _buildChildWidget() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: GetX<SearchDoctorController>(builder: (searchController) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //Location
            Container(
              margin: const EdgeInsets.only(left: 8, right: 8, top: 4),
              child: Row(
                children: [
                  //Location Icon
                  Icon(
                    UniversalIcons.locationIcon,
                    size: 16,
                  ),
                  SizedBox(
                    width: 8,
                  ),

                  //Locatin Text
                  Text(_loggedInUser['city'],
                      style: Theme.of(context).textTheme.bodyText1),
                ],
              ),
            ),

            //Search Text
            TextFieldWidget(
              margin: EdgeInsets.all(8),
              textEditingController: _searchTextEditingController,
              labelText: UniversalStrings.searchDoctor,
              isError: false,
              onChanged: (value) {
                //TODO: CALL API FOR SEARCHING DOCTOR
                if (value.isEmpty) {
                  searchController.setIsSearching(false);
                } else {
                  searchController.setIsSearching(true);

                  searchController.searchDoctors(_totalDoctorsStaticList,
                      _searchTextEditingController.text);
                }
              },
            ),

            //Doctors Divider
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(
                left: 8,
                right: 8,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.09,
                    margin: const EdgeInsets.only(
                      // left: 8,
                      right: 8,
                    ),
                    child: Divider(),
                  ),
                  Text(
                    UniversalStrings.doctors,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.68,
                      margin: const EdgeInsets.only(
                        left: 8,
                        // right: 8,
                      ),
                      child: Divider()),
                ],
              ),
            ),

            //doctor list
            Flexible(
              fit: FlexFit.loose,
              child: searchController.isSearching.value
                  ? _buildDoctorsList(searchController.searchResults, true)
                  : _buildDoctorsList(_totalDoctorsStaticList, false),
            ),

            SizedBox(
              height: 16,
            ),

            searchController.isSearching.value
                ? Container()
                :
                //specialist divider
                Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.09,
                          margin: const EdgeInsets.only(
                            // left: 8,
                            right: 8,
                          ),
                          child: Divider(),
                        ),
                        Text(
                          UniversalStrings.specialities,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.63,
                          margin: const EdgeInsets.only(
                            left: 8,
                            // right: 8,
                          ),
                          child: Divider(),
                        ),
                      ],
                    ),
                  ),

            searchController.isSearching.value
                ? Container()
                :
                //specialities list
                Flexible(fit: FlexFit.loose, child: _buildSpecialitiesList()),
            searchController.isSearching.value
                ? Container()
                : SizedBox(
                    height: 16,
                  ),
          ],
        );
      }),
    );
  }

  Widget _buildDoctorsList(
      List<Map<String, dynamic>> doctors, bool isSearching) {
    //TODO: Remove item count when data is coming from backend
    List<int> _itemCount = List<int>();
    if (isSearching) {
      for (int i = 0; i < doctors.length; i++) {
        _itemCount.add(i);
      }
    } else {
      _itemCount = searchDoctorController.getDoctorsCount(doctors
          .length); // count for 4 docs from list and give random 4 docs from list
    }

    return isSearching && doctors.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
              ),
              Text(
                UniversalStrings.noDoctorsFound,
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          )
        : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _itemCount.length,
            itemBuilder: (context, index) {
              return GetX<SearchDoctorController>(
                builder: (controller) => GestureDetector(
                  onTap: () {
                    //TODO: Add selection
                    controller
                        .setSelectedDoctorId(doctors[_itemCount[index]]['id']);
                  },
                  child: _buildDoctorsCard(
                    isSelected: doctors[_itemCount[index]]['id'] ==
                        controller.selectedDoctorId.value,
                    doctorName: doctors[_itemCount[index]]['name'],
                    hospitalName: doctors[_itemCount[index]]['hospital'],
                    typeOfDoctor: doctors[_itemCount[index]]['type'],
                    isSpecialist: doctors[_itemCount[index]]['specialist'],
                    isNextAvailable: true, //TODO: Get Data from backend
                    nextAvailableTime: doctors[_itemCount[index]]
                        ['working_day'], //TODO: Get Data from backend
                    availableDate: doctors[_itemCount[index]]
                        ['working_day'], //TODO: Get Data from backend
                    imageUrl: doctors[_itemCount[index]]['image'],
                    id: doctors[_itemCount[index]]['id'],
                  ),
                ),
              );
            },
          );
  }

  Widget _buildDoctorsCard({
    @required String doctorName,
    @required String hospitalName,
    @required String typeOfDoctor,
    @required bool isSpecialist,
    @required bool isNextAvailable,
    @required String nextAvailableTime,
    @required String availableDate,
    @required String imageUrl,
    @required bool isSelected,
    @required String id,
  }) {
    return Container(
      margin: const EdgeInsets.only(
        left: 22,
        right: 12,
        top: 15,
      ),
      decoration: BoxDecoration(
        color: isSelected
            ? UniversalColors.gradientColorStart
            : UniversalColors.doctorListBackgroundColor,
        borderRadius: BorderRadius.all(
          Radius.circular(14),
        ),
      ),
      child: Row(
        children: [
          //Profile Image
          Container(
            transform: Matrix4Transform().translate(x: -12, y: -12).matrix4,
            child: Hero(
              tag: id,
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
                  style: isSelected
                      ? Theme.of(context).textTheme.headline4.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: UniversalColors.whiteColor,
                          )
                      : Theme.of(context).textTheme.headline4.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                ),

                //hos name
                Text(
                  hospitalName,
                  style: isSelected
                      ? Theme.of(context).textTheme.headline4.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            color: UniversalColors.whiteColor,
                          )
                      : Theme.of(context).textTheme.headline4.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                          ),
                ),

                //type of doc and specialist
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      typeOfDoctor,
                      style: isSelected
                          ? Theme.of(context).textTheme.headline4.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                color: UniversalColors.whiteColor,
                              )
                          : Theme.of(context).textTheme.headline4.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                              ),
                    ),
                    isSpecialist
                        ? Container(
                            margin: const EdgeInsets.only(right: 14),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          )
                        : Container(),
                  ],
                ),
                isNextAvailable
                    ? Text(
                        "Available at 7", //TODO: temp - will come from backend
                        style: isSelected
                            ? Theme.of(context).textTheme.headline4.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                  color: UniversalColors.whiteColor,
                                )
                            : Theme.of(context).textTheme.headline4.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                ),
                      ) //TODO: to dynamic RIGHT NOW!!!!!
                    : Text(
                        'TIME', //TODO: temp - will come from backend
                        style: isSelected
                            ? Theme.of(context).textTheme.headline4.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                  color: UniversalColors.whiteColor,
                                )
                            : Theme.of(context).textTheme.headline4.copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                ),
                      ), //TODO: CHANGE WITH PROPER TEXT
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

  Widget _buildSpecialitiesList() {
    List<Map<String, dynamic>> _list = _specialistList.getList();
    return Container(
      margin: const EdgeInsets.only(
        left: 12,
        right: 12,
        top: 10,
      ),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _list.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 80 / 90,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              //TODO: Add search using title
            },
            child: ChipThreeSectionWidget(
              imageUrl: _list[index]['image'],
              title: _list[index]['title'],
              description: _list[index]['description'],
            ),
          );
        },
      ),
    );
  }

  //Methods------------------------------

}
