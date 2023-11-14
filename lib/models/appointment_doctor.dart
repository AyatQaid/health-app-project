class appointmentDoctorModel {
  String hospitalId;
  String hospitalName;
 
  String timeFrom;
  String timeTo;
String weekno;
  appointmentDoctorModel({
    required this.hospitalId,
    required this.hospitalName,
    required this.timeTo,
        required this.timeFrom,
        required this.weekno,

   
  });

  factory appointmentDoctorModel.fromMap(Map<String, dynamic> map) =>
      appointmentDoctorModel(
        hospitalId: (map["hospitalId"]),
        hospitalName: map["hospitalName"].toString(),
      
        timeTo: map["timeTo"].toString(),
                timeFrom: map["timeFrom"].toString(),
                                weekno: map["weekno"].toString(),


      );

  Map<String, dynamic> toMap() => {
        "hospitalId": hospitalId,
        "hospitalName": hospitalName,
      
        "timeTo": timeTo,
                "timeFrom": timeFrom,
                                "weekno": weekno,


      };
}
