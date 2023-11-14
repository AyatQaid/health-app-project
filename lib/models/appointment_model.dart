class appointmentModel {
  String id;
  String username;
  String phone;

  String doctor;
  String description;
  String doctorid;
  String date;
  String time;

  appointmentModel({
    required this.id,
    required this.username,
    required this.phone,
    required this.doctor,
    required this.doctorid,
    required this.description,
    required this.date,
    required this.time,
  });

  factory appointmentModel.fromMap(Map<String, dynamic> map) =>
      appointmentModel(
        id: map.containsKey("id")? (map["id"]):"",
        username: map["username"].toString(),
        phone: map["phone"].toString(),
        doctor: map["doctor"].toString(),
        doctorid: map["doctorid"].toString(),
        description: map["description"].toString(),
        date: map["date"].toString(),
        time: map["time"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "phone": phone,
        "doctor": doctor,
        "doctorid": doctorid,
        "description": description,
        "date": date,
        "time": time,
      };
}
