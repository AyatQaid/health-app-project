//import 'dart:html';

//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:healthapp/models/appointment_model.dart';
import 'package:healthapp/models/article_model.dart';
import 'package:healthapp/models/clinic_model.dart';
import 'package:healthapp/models/details_model.dart';
import 'package:healthapp/models/doctor_model.dart';
import 'package:healthapp/models/emergency_model.dart';
import 'package:healthapp/models/hospital_model.dart';
import 'package:healthapp/models/lab_model.dart';
import 'package:healthapp/models/user_model.dart';
import 'package:healthapp/screens/aboutApp_screen.dart';
import 'package:healthapp/screens/appointment_screen.dart';
import 'package:healthapp/screens/article_content_screen.dart';
import 'package:healthapp/screens/details_lab_screen.dart';
import 'package:healthapp/screens/details_screen.dart';
import 'package:healthapp/screens/detalis_clinic_screen.dart';
import 'package:healthapp/screens/doctor_details_screen.dart';
import 'package:healthapp/screens/login_screen.dart';
import 'package:healthapp/screens/myAppointment.dart';
import 'package:healthapp/screens/myfavorites_screen.dart';
import 'package:healthapp/screens/user_screen.dart';
import 'package:healthapp/shared/components/constant.dart';
import 'package:healthapp/shared/network/local/cache_helper.dart';
import 'package:healthapp/shared/style/constant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

import '../../screens/main_screen.dart';

AppBar appBarComponent(
        {required String title, required BuildContext context}) =>
    AppBar(
      elevation: 1,
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {
          navigateToandFinish(context, mainPage());
        },
        icon: Icon(
          Icons.home,
        ),
        color: mainColor,
        iconSize: 35,
      ),
      title: Center(
          child: Text(
        title /* "الــمــقــالات"*/,
        style: TextStyle(color: mainColor, fontFamily: 'Tajawal'),
      )),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_forward, color: mainColor)),
      ],
    );

Widget defaultFormField({
  @required TextEditingController? controller,
  @required TextInputType? type,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  Function()? onTap,
  bool isPassword = false,
  FormFieldValidator<String>? validate,
  @required String? label,
  @required IconData? prefix,
  IconData? suffix,
  Function()? prefixPressed,
  bool isClickable = true,
}) =>
    Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 0,
              // offset: Offset(0, 1),
              color: Colors.grey.shade100,
            )
          ],
          borderRadius: BorderRadius.circular(30),
          color: Color.fromARGB(255, 239, 241, 239)),
      child: TextFormField(
        textAlign: TextAlign.right,
        controller: controller,
        keyboardType: type,
        obscureText: isPassword,
        enabled: isClickable,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        onTap: onTap,
        validator: validate,
        decoration: InputDecoration(
          focusColor: mainColor,
          hintText: label,
          suffixIcon: Icon(
            suffix,
            color: mainColor,
          ),
          prefixIcon: prefix != null
              ? IconButton(
                  onPressed: prefixPressed,
                  icon: Icon(prefix),
                )
              : null,
          border: InputBorder.none,
        ),
      ),
    );

class navigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [buildHeader(context), buildMenuItems(context)],
        ),
      ),
    );
  }
}

Widget buildHeader(BuildContext context) => Material(
    color: Colors.grey.shade200,
    child: user!=null
        ? InkWell(
            onTap: () {
             navigateTo(context, userPage());
            },
            child: Container(
              padding: EdgeInsets.only(
                  bottom: 20,
                  top: 20 + MediaQuery.of(context).padding.top * 0.5),
              child: Column(
                children: [
                  CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 52,
                      child: Image(
                        width: 80,
                        image: AssetImage('assets/images/health_app_logo.png'),
                      )),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    user!.username,
                    style: largeTextBold,
                  ),
                   Text(
                     user!.email,
                     style: mediumTextRegular,
                   ),
                ],
              ),
            ),
          )
         : Container(
                padding: EdgeInsets.only(
                    bottom: 20,
                    top: 20 + MediaQuery.of(context).padding.top * 0.5),
                child: Column(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 52,
                        child: Image(
                          width: 80,
                          image:
                              AssetImage('assets/images/health_app_logo.png'),
                        )),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "تــطــبـيـق صــحـة",
                      style: largeTextBold,
                    ),
                  ],
                ),
              ));

Widget buildMenuItems(BuildContext context) => Container(
      padding: EdgeInsets.all(24),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        runSpacing: 16,
        children: [
          /* Visibility(
           // visible: user != null ? user!.id.isEmpty : false,
            child: ListTile(
              iconColor: mainColor,
              textColor: mainColor,
              title: Text(
                "تــسـجـيل خـروج",
                textAlign: TextAlign.end,
                style: TextStyle(fontFamily: 'Tajawal', fontSize: 16),
              ),
              trailing: Image.asset(
                "assets/images/logout.png",
                width: 30,
                height: 30,
              ),
              onTap: () async {
                await CacheHlper.removeData(key: "id").then((value) async {
                  if (value == true) {
                  
                 }
                });
              },
            ),
          ),*/
          //login
          Visibility(
            visible: user != null ? user!.id.isEmpty : true,
            child: ListTile(
              iconColor: mainColor,
              textColor: mainColor,
              title: Text(
                " تسـجــيل الدخــول",
                textAlign: TextAlign.end,
                style: TextStyle(fontFamily: 'Tajawal', fontSize: 16),
              ),
              trailing: Image.asset(
                "assets/images/login.png",
                width: 30,
                height: 30,
              ),
              onTap: () {
                navigateTo(context, loginPage());
              },
            ),
          ),

          ListTile(
            iconColor: mainColor,
            textColor: mainColor,
            title: Text(
              "عــن الـتـطــبـيـق",
              textAlign: TextAlign.end,
              style: TextStyle(fontFamily: 'Cairo', fontSize: 16),
            ),
            trailing: Image.asset(
              "assets/images/about.png",
              width: 30,
              height: 30,
            ),
            onTap: () {
              navigateTo(context, aboutAppPage());
            },
          ),
          ListTile(
            iconColor: mainColor,
            textColor: mainColor,
            title: Text(
              "مـشاركــة التــطـبـيق",
              textAlign: TextAlign.end,
              style: TextStyle(fontFamily: 'Tajawal', fontSize: 16),
            ),
            trailing: Image.asset(
              "assets/images/share.png",
              width: 30,
              height: 30,
            ),
            onTap: () {
              final urlapp =
                  "https://play.google.com/store/apps/details?id=com.altibbi.cds";
              Share.share("${urlapp}");
            },
          ),
          Divider(
            color: Colors.black54,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  launchUrl(Uri(
                    scheme: 'sms',
                    path: '779949435',
                  ));
                },
                icon: Icon(
                  Icons.whatsapp_outlined,
                ),
                iconSize: 30,
                color: mainColor,
              ),
              SizedBox(
                width: 5,
              ),
              IconButton(
                onPressed: () {
                  launchUrl(Uri(
                    scheme: 'tel',
                    path: '779949435',
                  ));
                },
                icon: Icon(Icons.phone),
                iconSize: 30,
                color: mainColor,
              ),
              SizedBox(
                width: 5,
              ),
              IconButton(
                onPressed: () {
                  launchUrl(Uri(
                    scheme: 'sms',
                    path: '779784007',
                  ));
                },
                icon: Icon(Icons.email_outlined),
                iconSize: 30,
                color: mainColor,
              ),
            ],
          )
        ],
      ),
    );

Widget buildLabCardItems(labModel labObj, context) => InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => detailLabPage(
                      labObj: labObj,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Color.fromARGB(255, 239, 241, 239)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: [
                Text("${labObj.title}",
                    style: TextStyle(
                        fontSize: 18,
                        color: mainColor,
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center)
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4.0, top: 4, bottom: 4),
              child: CachedNetworkImage(
                  height: 80,
                  width: 80,
                  imageUrl: labObj.imgAssetPath,
                  imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Image(image: AssetImage("assets/images/lab3.png"))),
            ),
          ],
        ),
      ),
    );

Widget buildClinicCardItems(clinicModel clinicObj, context) => InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => detailClinicPage(
                      clinicObj: clinicObj,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Color.fromARGB(255, 239, 241, 239)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: [
                Text("${clinicObj.title}",
                    style: TextStyle(
                        fontSize: 18,
                        color: mainColor,
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center)
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4.0, top: 4, bottom: 4),
              child: CachedNetworkImage(
                  height: 80,
                  width: 80,
                  imageUrl: clinicObj.imgAssetPath,
                  imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Image(image: AssetImage("assets/images/clinic.png"))),
            ),
          ],
        ),
      ),
    );

Widget buildDoctorCardItems(doctorModel doctorObj, context) =>
    SingleChildScrollView(
      child: InkWell(
        onTap: () {
          navigateTo(
              context,
              doctorDetailsPage(
                doctorObj: doctorObj,
              ));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color.fromARGB(255, 239, 241, 239)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  Text("${doctorObj.title} ",
                      style: TextStyle(
                          fontSize: 18,
                          color: mainColor,
                          fontFamily: 'Tajawal',
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center)
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 4.0, top: 4, bottom: 4),
                child: CachedNetworkImage(
                    height: 80,
                    width: 80,
                    imageUrl: doctorObj.imgAssetPath,
                    imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Image(image: AssetImage("assets/images/doctor2.png"))),
              ),
            ],
          ),
        ),
      ),
    );

Widget buildHospitalCardItems(hospitalModel hospitalObj, context) => InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => detailsPage(
                      hospitalObj: hospitalObj,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Color.fromARGB(255, 239, 241, 239)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("${hospitalObj.title} ",
                style: TextStyle(
                    fontSize: 18,
                    color: mainColor,
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 2.3, top: 4, bottom: 4),
              child: CachedNetworkImage(
                  height: 80,
                  width: 80,
                  imageUrl: hospitalObj.imgAssetPath,
                  imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Image(
                      image: AssetImage(
                          "assets/images/hospital.png")) /*Icon(Icons.error)*/),
            ),
          ],
        ),
      ),
    );

Widget buildEmergencyCardItems(emergencyModel emergencyObj, context) => Card(
      elevation: 10,
      shadowColor: mainColor,
      child: ListTile(
        trailing: Image.asset(
          "assets/images/emergency.png",
          width: 35,
          height: 35,
        ),
        title: Text(
          " ${emergencyObj.title}",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: mainColor,
              fontFamily: 'Tajawal'),
        ),
        leading: IconButton(
          onPressed: () {
            launchUrl(Uri(
              scheme: 'tel',
              path: '${emergencyObj.phone}',
            ));
          },
          icon: Image.asset(
            "assets/images/call.png",
            width: 30,
            height: 30,
          ),
        ),
      ),
    );

Widget buildArticleCardItems(articleModel articleObj, context) => InkWell(
      onTap: (() {
        navigateTo(context, articleContent(articleObj: articleObj));
      }),
      child: Card(
          elevation: 10,
          shadowColor: mainColor,
          child: ListTile(
            trailing: CachedNetworkImage(
              height: 150,
              width: 150,
              imageUrl: articleObj.imgAssetPath,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            title: Text(
              " ${articleObj.title}",
              textAlign: TextAlign.right,
            ),
            subtitle: Text(
              "${articleObj.subtitle}",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.right,
            ),
          )),
    );

Widget buildArticleContent(
  articleModel artcleContentObj,
  context,
  bool fav,
  VoidCallback toggleFavorite,
) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20)),
              child: CachedNetworkImage(
                  fit: BoxFit.contain,
                  height: 200,
                  width: double.infinity,
                  imageUrl: artcleContentObj.imgAssetPath,
                  imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error)),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: toggleFavorite,
                  icon: Icon(
                    fav ? Icons.favorite : Icons.favorite_border,
                    color: fav ? Colors.red : null,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                IconButton(
                    onPressed: () async {
                      await Share.share(artcleContentObj.subtitle);
                    },
                    icon: Icon(Icons.share)),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                " ${artcleContentObj.title}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                "${artcleContentObj.subtitle}",
                // textAlign: TextAlign.right,
              ),
            )
          ],
        ),
      ),
    );

Widget buildDetailsItems(hospitalModel detailsObj, context) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20)),
            child: InteractiveViewer(
              panEnabled: true, // Set it to false
              boundaryMargin: EdgeInsets.all(100),
              minScale: 0.5,
              maxScale: 5,
              child: CachedNetworkImage(
                  fit: BoxFit.contain,
                  height: 200,
                  width: double.infinity,
                  imageUrl: detailsObj.imageLocation,
                  imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error)),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(20)),
                child: CachedNetworkImage(
                    fit: BoxFit.contain,
                    height: 150,
                    width: 150,
                    imageUrl: detailsObj.imgAssetPath,
                    imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Image(image: AssetImage("assets/images/hospital.png"))),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Center(
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          " ${detailsObj.title}",
                          style: mediumTextBold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                            child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text("${detailsObj.address} "))),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.location_on_outlined, size: 25),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("${detailsObj.phone}"),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.phone_rounded, size: 25)
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    /*      Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("${detailsObj.email}"),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.email_outlined,
                          size: 25,
                        )
                      ],
                    ),*/
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "التــفــاصيل",
            style: largeTextBold,
          ),
          SizedBox(
            height: 6,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              " ${detailsObj.description} ",
              style: smallTextBold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ]),
      ),
    );

Widget buildMyAppointmentItems(appointmentModel appObj, context) => InkWell(
      onTap: () {},
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Color.fromARGB(255, 239, 241, 239)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("${appObj.doctor}",
                        style: TextStyle(
                            fontSize: 20,
                            color: mainColor,
                            fontFamily: 'Tajawal',
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 4.0, top: 4, bottom: 4),
                      child: /*Image.asset(
          "assets/images/appointment.png",
          width: 70,
          height: 70,
                ),*/
                          CachedNetworkImage(
                              height: 70,
                              width: 70,
                              imageUrl:
                                  'https://cdn-icons-png.flaticon.com/128/11509/11509610.png',
                              imageBuilder: (context, imageProvider) =>
                                  Container(
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
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error)),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color.fromARGB(255, 229, 235, 229)),
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.calendar_month,
                        size: 30,
                      ),
                      Text("${appObj.date}",
                          style: TextStyle(
                              fontSize: 20,
                              color: mainColor,
                              fontFamily: 'Tajawal',
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.watch_later_outlined,
                        size: 30,
                      ),
                      Text("${appObj.time}",
                          style: TextStyle(
                              fontSize: 20,
                              color: mainColor,
                              fontFamily: 'Tajawal',
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );

Widget buildDetailsClinicItems(clinicModel clinicObj, context) =>
    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      SizedBox(
        height: 10,
      ),
      Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20)),
        child: InteractiveViewer(
          panEnabled: true, // Set it to false
          boundaryMargin: EdgeInsets.all(100),
          minScale: 0.5,
          maxScale: 5,
          child: CachedNetworkImage(
              fit: BoxFit.contain,
              height: 200,
              width: double.infinity,
              imageUrl: clinicObj.imageLocation,
              imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error)),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20)),
            child: CachedNetworkImage(
                fit: BoxFit.contain,
                height: 150,
                width: 150,
                imageUrl: clinicObj.imgAssetPath,
                imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    Image(image: AssetImage("assets/images/clinic.png"))),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      " ${clinicObj.title}",
                      style: mediumTextBold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                        child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text("${clinicObj.address} "))),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.location_on_outlined, size: 25),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("${clinicObj.phone}"),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.phone_rounded, size: 25)
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                /*      Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("${detailsObj.email}"),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.email_outlined,
                      size: 25,
                    )
                  ],
                ),*/
              ],
            ),
          )
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        "التــفــاصيل ",
        style: largeTextBold,
      ),
      SizedBox(
        height: 6,
      ),
      Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          " ${clinicObj.description}  ",
          style: smallTextBold,
        ),
      ),
      SizedBox(
        height: 10,
      ),
    ]);

Widget buildDetailsLabItems(labModel labObj, context) =>
    Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      SizedBox(
        height: 10,
      ),
      Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20)),
        child: InteractiveViewer(
          panEnabled: true, // Set it to false
          boundaryMargin: EdgeInsets.all(100),
          minScale: 0.5,
          maxScale: 5,
          child: CachedNetworkImage(
              fit: BoxFit.contain,
              height: 200,
              width: double.infinity,
              imageUrl: labObj.imageLocation,
              imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error)),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20)),
            child: CachedNetworkImage(
                fit: BoxFit.contain,
                height: 150,
                width: 150,
                imageUrl: labObj.imgAssetPath,
                imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    Image(image: AssetImage("assets/images/lab3.png"))),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      " ${labObj.title}",
                      style: mediumTextBold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                        child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text("${labObj.address} "))),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.location_on_outlined, size: 25),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("${labObj.phone}"),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(Icons.phone_rounded, size: 25)
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                /*      Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("${detailsObj.email}"),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.email_outlined,
                      size: 25,
                    )
                  ],
                ),*/
              ],
            ),
          )
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        "التــفــاصيل",
        style: largeTextBold,
      ),
      SizedBox(
        height: 6,
      ),
      Directionality(
        textDirection: TextDirection.rtl,
        child: Text(
          " ${labObj.description} ",
          style: smallTextBold,
        ),
      ),
      SizedBox(
        height: 10,
      ),
    ]);

Widget buildArticleFavCardItems(articleModel articleFavObj, context) => InkWell(
      onTap: (() {
        navigateTo(context, articleContent(articleObj: articleFavObj));
      }),
      child: Card(
          elevation: 10,
          shadowColor: mainColor,
          child: ListTile(
            trailing: CachedNetworkImage(
              height: 150,
              width: 150,
              imageUrl: articleFavObj.imgAssetPath,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            title: Text(
              " ${articleFavObj.title}",
              textAlign: TextAlign.right,
            ),
            subtitle: Text(
              "${articleFavObj.subtitle}",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.right,
            ),
          )),
    );
