class DoctorSpecialistList {
  List<Map<String, dynamic>> _specialistList = [
    {
      "id": "1",
      "title": "General Physician",
      "image": "assets/images/doctor4.png",
      "description": "For any common health issues",
    },
    {
      "id": "2",
      "title": "Cardiology",
      "image": "assets/images/cardiology.png",
      "description": "For heart and blood pressure problems",
    },
    {
      "id": "3",
      "title": "Dermatology",
      "image": "assets/images/dermatology.png",
      "description": "For skin and health problems",
    },
    {
      "id": "4",
      "title": "Paediatrics",
      "image": "assets/images/paediatrician.png",
      "description": "For children's healthcare",
    },
  ];

  List<Map<String, dynamic>> getList() {
    return _specialistList;
  }
}
