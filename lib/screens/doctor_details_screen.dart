import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:healthapp/models/appointment_doctor.dart';
import 'package:healthapp/models/doctor_model.dart';
import 'package:healthapp/screens/appointment_screen.dart';
import 'package:healthapp/screens/login_screen.dart';
import 'package:healthapp/screens/main_screen.dart';
import 'package:healthapp/shared/components/components.dart';
import 'package:healthapp/shared/components/constant.dart';
import 'package:healthapp/shared/style/constant.dart';

class doctorDetailsPage extends StatefulWidget {
  doctorModel doctorObj;
  doctorDetailsPage({Key? key, required this.doctorObj}) : super(key: key);

  @override
  State<doctorDetailsPage> createState() => _doctorDetailsPageState();
}

class _doctorDetailsPageState extends State<doctorDetailsPage> {
  List<appointmentDoctorModel> appointment_doctor = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection('doctors')
        .doc(widget.doctorObj.id)
        .collection('appointments')
        .get()
        .then((value) {
      if (value != null) {
        appointment_doctor = value.docs
            .map((e) => appointmentDoctorModel.fromMap(e.data()))
            .toList();
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((error) {
      print(error);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: mainColor)),
          title: Center(
              child: Text(
            "أطــبــاء",
            style: TextStyle(color: mainColor, fontFamily: 'Tajawal'),
          )),
          actions: [
            IconButton(
              onPressed: () {
                navigateToandFinish(context, mainPage());
              },
              icon: Icon(
                Icons.home,
              ),
              color: mainColor,
              iconSize: 35,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[350],
                  radius: 65,
                  child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      height: 90,
                      // width: double.infinity,
                      imageUrl: widget.doctorObj.imgAssetPath,
                      imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Image(image: AssetImage("assets/images/doctor2.png"))),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.doctorObj.title,
                  style: largeTextBold,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.doctorObj.description,
                  style: mediumTextBold,
                ),
                Divider(
                  height: 10,
                  color: Colors.grey[350],
                ),
                SizedBox(
                  height: 40,
                ),
                isLoading
                    ? CircularProgressIndicator()
                    : Container(
                        child: ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) =>
                                buildappointementItem(
                                    appointment_doctor[index]),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 10,
                                ),
                            itemCount: appointment_doctor.length)),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30)),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: MaterialButton(
                          color: mainColor,
                          height: 60,
                          child: Text(
                            " أحــجــز الان ",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          onPressed: () {
                            if (user != null)
                              navigateTo(
                                  context,
                                  appointmentPage(
                                    doctor: widget.doctorObj,
                                  ));
                            else
                              navigateTo(context, loginPage());
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildappointementItem(appointmentDoctorModel app) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.place_outlined,
              color: mainColor,
            ),
            SizedBox(
              width: 3,
            ),
            Expanded(
              child: Text(
                app.hospitalName,
                style: smallTextBold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.calendar_month_rounded,
              color: mainColor,
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              weekNoToName(app.weekno.split('-')[0]) +
                  '-' +
                  weekNoToName(app.weekno.split('-')[1]),
              style: smallTextBold,
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.timelapse_rounded,
              color: mainColor,
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              "${app.timeFrom} - ${app.timeTo}",
              style: smallTextBold,
            ),
          ],
        ),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
