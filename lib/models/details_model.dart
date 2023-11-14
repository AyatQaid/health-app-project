class detailsModel {
  int id;
  String locationImg;
  String imgAssetPath;
  String title;
  String phone;
  String email;
  String location;
  String description;

  detailsModel({
    required this.id,
    required this.locationImg,
    required this.imgAssetPath,
    required this.title,
    required this.phone,
    required this.email,
    required this.location,
    required this.description,
  });

  factory detailsModel.fromMap(Map<String, dynamic> map) => detailsModel(
        id: int.parse(map["id"]),
        locationImg: map["locationImg"].toString(),
        imgAssetPath: map["imgAssetPath"].toString(),
        title: map["title"].toString(),
        phone: map["phone"].toString(),
        email: map["email"].toString(),
        location: map["location"].toString(),
        description: map["description"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "locationImg": locationImg,
        "imgAssetPath": imgAssetPath,
        "title": title,
        "phone": phone,
        "email": email,
        "location": location,
        "description": description,
      };
}

class details {
  static List<detailsModel> detailsList = [
    detailsModel(
      id: 1,
      locationImg: "assets/images/alreyada_location.png",
      imgAssetPath: "assets/images/alreyada.png",
      title: "مـسـتـشـفى الريـادة الدولــي ",
      phone: "02 300 333",
      email: "info@al-reyada.com",
      location: "المنصورة - شارع التسعين - بجانب معسكر الدفاع الجوي ",
      description: "مستشفى الريادة الدولي احدى اكبر مقدمى الرعاية الطبية الشاملة في عدن ",
    ),

     detailsModel(
      id: 2,
      locationImg: "assets/images/alreyada_location.png",
      imgAssetPath: "assets/images/alreyada.png",
      title: "مـسـتـشـفى الريـادة الدولــي ",
      phone: "02 300 333",
      email: "info@al-reyada.com",
      location: "المنصورة - شارع التسعين - بجانب معسكر الدفاع الجوي ",
      description: "مستشفى الريادة الدولي احدى اكبر مقدمى الرعاية الطبية الشاملة في عدن ",
    ),
   
   
  ];
}
