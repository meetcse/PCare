import 'package:flutter/material.dart';

class DoctorAllPatients extends StatelessWidget {
  List<Map<String, dynamic>> _patients = [
    {
      "id": "1",
      "name": "Pranav Suthar",
      "image":
          "https://images.pexels.com/photos/1080213/pexels-photo-1080213.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940",
    },
    {
      "id": "2",
      "name": "Marcus NG",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCexMzvTjX8oflMcyjjCL8JaeeKwqsmanIuw&usqp=CAU",
    },
    {
      "id": "3",
      "name": "Gautam Vyas",
      "image":
          "https://adultballet.com.au/wp-content/uploads/2017/02/unnamed-1.jpg",
    },
    {
      "id": "4",
      "name": "Darpan Suthar",
      "image": "https://jooinn.com/images/portrait-of-young-man-2.jpg",
    },
    {
      "id": "5",
      "name": "Mitesh Patel",
      "image":
          "https://t4.ftcdn.net/jpg/02/45/56/35/360_F_245563558_XH9Pe5LJI2kr7VQuzQKAjAbz9PAyejG1.jpg",
    },
    {
      "id": "6",
      "name": "Viay Patel",
      "image":
          "https://t4.ftcdn.net/jpg/03/03/54/59/360_F_303545914_XLEAix36kSd78qCl4XYhl2S1iYSA9IyW.jpg",
    },
    {
      "id": "7",
      "name": "Dipen Biden",
      "image":
          "https://st2.depositphotos.com/4196725/6217/i/950/depositphotos_62170113-stock-photo-young-cool-black-man-no.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        child: Text("Doctors All Patients"),
      ),
    );
  }

  Widget _buildAppBar() {
    return DoctorAppbarWidget(
      title: _doctor['name'],
    );
  }
}
