import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:matrix4_transform/matrix4_transform.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/api/patient/appointment/SearchDoctorInPatientAPI.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/app_icons.dart';
import 'package:pcare/constants/patient/doctor_specialist_list.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/flushbar_message/flushbar_message.dart';
import 'package:pcare/models/patient/appointment/SearchDoctorInPatientModel.dart';
import 'package:pcare/store/patients/appointments/search_doctor_controller.dart';
import 'package:pcare/ui/patient/appointments/doctor_profile.dart';
import 'package:pcare/widgets/AppWidgets.dart';
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
  var searchDoctorController = Get.put(SearchDoctorController());
  TextEditingController _searchTextEditingController = TextEditingController();

  DoctorSpecialistList _specialistList = DoctorSpecialistList();

  Future<List<SearchDoctorsInPatientModel>> _searchDoctorModelFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _callDoctorsApi();
  }

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
      floatingActionButton: GetX<SearchDoctorController>(
        builder: (controller) {
          return controller.selectedDoctorId.value != null &&
                  controller.selectedDoctorId.value != ''
              ? _buildFloatingActionButton()
              : Container();
        },
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        _onFloatingActionButtonClicked();
      },
      child: Icon(
        UniversalIcons.forwardArrow,
      ),
    );
  }

  Widget _buildChildWidget() {
    return FutureBuilder(
        future: _searchDoctorModelFuture,
        builder: (context,
            AsyncSnapshot<List<SearchDoctorsInPatientModel>>
                searchDoctorsModelList) {
          if (!searchDoctorsModelList.hasData) {
            return Center(child: CustomProgressIndicatorWidget());
          }

          List<SearchDoctorsInPatientModel> _searchDoctorsModelList =
              searchDoctorsModelList.data;
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Obx(
              ()
              // <SearchDoctorController>
              // (builder: (searchController)
              {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 4,
                    ),

                    //Location
                    // _buildLocationIconAndText(),

                    //Search Text
                    _searchTextField(_searchDoctorsModelList),

                    //Doctors Divider
                    _searchDoctorDivider(),

                    //doctor list
                    _doctorList(_searchDoctorsModelList),
                    SizedBox(
                      height: 16,
                    ),

                    searchDoctorController.isSearching.value
                        ? Container()
                        :
                        //specialist divider
                        _specialistDivider(),

                    searchDoctorController.isSearching.value
                        ? Container()
                        :
                        //specialities list
                        Flexible(
                            fit: FlexFit.loose,
                            child: _buildSpecialitiesList()),

                    searchDoctorController.isSearching.value
                        ? Container()
                        : SizedBox(
                            height: 16,
                          ),

                    SizedBox(
                      height: 20,
                    ),
                  ],
                );
              },
            ),
          );
        });
  }

  Widget _doctorList(List<SearchDoctorsInPatientModel> searchDoctorsModelList) {
    return Flexible(
      fit: FlexFit.loose,
      child: searchDoctorController.isSearching.value
          ? _buildDoctorsList(searchDoctorController.searchResults, true)
          : _buildDoctorsList(searchDoctorsModelList, false),
    );
  }

  Widget _searchTextField(
      List<SearchDoctorsInPatientModel> searchDoctorsModelList) {
    return Obx(() {
      return searchDoctorController.allow.value
          ? TextFieldWidget(
              margin: EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 12),
              textEditingController: _searchTextEditingController,
              labelText: UniversalStrings.searchDoctor,
              isError: false,
              onChanged: (value) {
                _onSearchTextFieldChanged(value, searchDoctorsModelList);
              },
            )
          : Container();
    });
  }

  Widget _buildDoctorsList(
      List<SearchDoctorsInPatientModel> searchDoctorsModelList,
      bool isSearching) {
    return (isSearching && searchDoctorsModelList.isEmpty) ||
            (searchDoctorsModelList.length == 0)
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
            itemCount: searchDoctorsModelList.length,
            itemBuilder: (context, index) {
              SearchDoctorsInPatientModel _searchDoctorsModel =
                  searchDoctorsModelList[index];
              return GetX<SearchDoctorController>(
                builder: (controller) => GestureDetector(
                  onTap: () {
                    //TODO: Add selection
                    controller.setSelectedDoctorId(_searchDoctorsModel.id);
                  },
                  child: _buildDoctorsCard(
                    isSelected: _searchDoctorsModel.id.toLowerCase() ==
                        controller.selectedDoctorId.value.toLowerCase(),
                    doctorName: _searchDoctorsModel.user.firstName +
                        " " +
                        _searchDoctorsModel.user.lastName,
                    hospitalName: _searchDoctorsModel.hospitalId.hospitalName,
                    typeOfDoctor: _searchDoctorsModel.doctorType,
                    isSpecialist: _searchDoctorsModel.specialist,
                    // isNextAvailable: true, //TODO: Get Data from backend
                    // nextAvailableTime:_searchDoctorsModel.workingDays, //TODO: Get Data from backend
                    // availableDate: _searchDoctorsModel.wor, //TODO: Get Data from backend
                    imageUrl: _searchDoctorsModel.user.profilePic,
                    id: _searchDoctorsModel.id,
                  ),
                ),
              );
            },
          );
  }

  Widget _buildLocationIconAndText() {
    return Container(
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
          // Text(_loggedInUser['city'],
          //     style: Theme.of(context).textTheme.bodyText1),
        ],
      ),
    );
  }

  Widget _buildDoctorsCard({
    @required String doctorName,
    @required String hospitalName,
    @required String typeOfDoctor,
    @required bool isSpecialist,
    // @required bool isNextAvailable,
    // @required String nextAvailableTime,
    // @required String availableDate,
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
            : UniversalColors.doctorListBackgroundColor.withOpacity(0.5),
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
                  width: 100,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8,
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
                // isNextAvailable
                //     ? Text(
                //         "Available at 7", //TODO: temp - will come from backend
                //         style: isSelected
                //             ? Theme.of(context).textTheme.headline4.copyWith(
                //                   fontSize: 13,
                //                   fontWeight: FontWeight.w300,
                //                   color: UniversalColors.whiteColor,
                //                 )
                //             : Theme.of(context).textTheme.headline4.copyWith(
                //                   fontSize: 13,
                //                   fontWeight: FontWeight.w300,
                //                 ),
                //       ) //TODO: to dynamic RIGHT NOW!!!!!
                //     : Text(
                //         'TIME', //TODO: temp - will come from backend
                //         style: isSelected
                //             ? Theme.of(context).textTheme.headline4.copyWith(
                //                   fontSize: 13,
                //                   fontWeight: FontWeight.w300,
                //                   color: UniversalColors.whiteColor,
                //                 )
                //             : Theme.of(context).textTheme.headline4.copyWith(
                //                   fontSize: 13,
                //                   fontWeight: FontWeight.w300,
                //                 ),
                //       ), //TODO: CHANGE WITH PROPER TEXT
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
      height: 200,
      // width: 180,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _list.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () {
                  //TODO: Add search using title
                },
                child: ChipThreeSectionWidget(
                  imageUrl: _list[index]['image'],
                  title: _list[index]['title'],
                  description: _list[index]['description'],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _specialistDivider() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(
        left: 8,
        right: 8,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Divider(
              endIndent: 8,
            ),
          ),
          Text(
            UniversalStrings.specialities,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Divider(
              indent: 8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchDoctorDivider() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(
        left: 8,
        right: 8,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Divider(),
          ),
          Text(
            UniversalStrings.doctors,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.w600),
          ),
          Expanded(child: Divider()),
        ],
      ),
    );
  }

  //Methods------------------------------

  void _callDoctorsApi() {
    SearchDoctorInPatientApi _sdpApi = SearchDoctorInPatientApi();
    _searchDoctorModelFuture = _sdpApi.getDoctors().catchError((error) {
      print("Error in getting doctors :" + error.toString());
      FlushbarMessage.errorMessage(Get.context, "Something Went Wrong");
    });
  }

  void _onFloatingActionButtonClicked() {
    AppWidgets.customProgressDialog();
    SearchDoctorsInPatientModel _selectedDoctor;

    Future.value(_searchDoctorModelFuture).then((_doctorsList) {
      _doctorsList.forEach((element) {
        if (element.id.toLowerCase().contains(
            searchDoctorController.selectedDoctorId.value.toLowerCase())) {
          _selectedDoctor = element;

          AppWidgets.closeDialog();
          _gotoDoctorProfileScreen(_selectedDoctor);
        }
      });
    });
  }

  void _onSearchTextFieldChanged(
      String value, List<SearchDoctorsInPatientModel> searchDoctorsModelList) {
    //TODO: CALL API FOR SEARCHING DOCTOR
    if (value.isEmpty) {
      searchDoctorController.setIsSearching(false);
    } else {
      searchDoctorController.setIsSearching(true);

      searchDoctorController.searchDoctors(
          searchDoctorsModelList, _searchTextEditingController.text);
    }
  }

  void _gotoDoctorProfileScreen(SearchDoctorsInPatientModel selectedDoctor) {
    PageUtils.pushPage(DoctorProfile(doctorDetails: selectedDoctor));
  }
}
