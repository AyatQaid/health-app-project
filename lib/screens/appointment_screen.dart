import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:healthapp/models/doctor_model.dart';
import 'package:healthapp/models/user_model.dart';
import 'package:healthapp/shared/components/components.dart';
import 'package:healthapp/shared/components/constant.dart';
import 'package:healthapp/shared/style/constant.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class appointmentPage extends StatefulWidget {
  final doctorModel doctor;

  const appointmentPage({Key? key, required this.doctor}) : super(key: key);

  @override
  State<appointmentPage> createState() => _appointmentPageState();
}

class _appointmentPageState extends State<appointmentPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _doctorController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

//final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime selectedDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  String timeText = 'Select Time';
  String? dateUTC;
  String? date_Time;

  Future<void> selectDate(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    ).then(
      (date) {
        setState(
          () {
            selectedDate = date!;
            String formattedDate =
                DateFormat('dd-MM-yyyy').format(selectedDate);
            _dateController.text = formattedDate;
            dateUTC = DateFormat('yyyy-MM-dd').format(selectedDate);
          },
        );
      },
    );
  }

  Future<void> selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );
    if (selectedTime != null) {
      MaterialLocalizations localizations = MaterialLocalizations.of(context);
      String formattedTime = localizations.formatTimeOfDay(selectedTime,
          alwaysUse24HourFormat: false);

      if (formattedTime != null) {
        setState(() {
          timeText = formattedTime;
          _timeController.text = timeText;
        });
      }
      date_Time = selectedTime.toString().substring(10, 15);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
        child: Text(
          "مـوافق",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.pop(context);
          _createAppointment();
        });

    Widget cancelButton = TextButton(
        child: Text(
          "الغاء",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.pop(context);
        });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "تأكيد",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        "هل تريد تأكيد هذا الموعد؟",
        style: TextStyle(),
      ),
      actions: [
        okButton,
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // _getUser();
    // selectTime(context);
    _doctorController.text = widget.doctor.title;
    _nameController.text = user!.username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(title: "حــجــز مــوعــد", context: context),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                child: Image(
                  image: AssetImage('assets/images/medical-team.png'),
                  height: 200,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.only(top: 0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(left: 16),
                        child: Center(
                          child: Text('ادخــل تـفـاصـيـل المـريـض',
                              style: largeTextBold),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        controller: _nameController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty)
                            return 'رجـاءً ادخـل اسـم الـمـريـض';
                          return null;
                        },
                        label: 'اسم المريض',
                        prefix: Icons.abc,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: _phoneController,
                        type: TextInputType.phone,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'رجــاءً أدخـل رقـم هـاتـف';
                          } else if (value.length < 9) {
                            return ' رجــاءً أدخـل رقـم هـاتـف صـحـيـح';
                          }
                          return null;
                        },
                        label: 'رقــم الـهاتـف',
                        prefix: Icons.phone,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: _descriptionController,
                        type: TextInputType.multiline,
                        label: ' الـوصــف',
                        prefix: Icons.description,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: _doctorController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value!.isEmpty)
                            return 'رجــاءً أدخـل اسـم الـطـبـيـب';
                          return null;
                        },
                        label: 'اسم الـطـبـيـب',
                        prefix: Icons.abc,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            defaultFormField(
                                controller: _dateController,
                                type: TextInputType.datetime,
                                label: "حـدد الـتـاريـخ",
                                validate: (value) {
                                  if (value!.isEmpty)
                                    return 'رجـاءً أدخـل الـتاريـخ';
                                  return null;
                                },
                                prefix: null),
                            /* TextFormField(
                              // focusNode: f4,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(
                                  left: 20,
                                  top: 10,
                                  bottom: 10,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(90.0)),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey[350],
                                hintText: 'حـدد الـتاريــخ *',
                                hintStyle: TextStyle(
                                  color: Colors.black26,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              controller: _dateController,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return 'رجـاءً أدخـل الـتاريـخ';
                                return null;
                              },
                              onFieldSubmitted: (String value) {
                                // f4.unfocus();
                                //FocusScope.of(context).requestFocus(f5);
                              },
                              textInputAction: TextInputAction.next,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),*/
                            Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: ClipOval(
                                child: Material(
                                  color: mainColor,
                                  child: InkWell(
                                    child: SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Icon(
                                        Icons.date_range_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      selectDate(context);
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            defaultFormField(
                                controller: _timeController,
                                type: TextInputType.datetime,
                                label: "حـدد الـيـوم",
                                validate: (value) {
                                  if (value!.isEmpty)
                                    return 'رجــاءً أدخـل الـوقـت';
                                  return null;
                                },
                                prefix: null),
                            Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: ClipOval(
                                child: Material(
                                  color: mainColor, // button color
                                  child: InkWell(
                                    onTap: () {
                                      selectTime(context);
                                    },
                                    child: SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Icon(
                                        Icons.timer_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 2,
                            primary: mainColor,
                            onPrimary: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print(_nameController.text);
                              print(_dateController.text);
                              print(widget.doctor);
                              showAlertDialog(context);
                            }
                          },
                          child: Text(
                            "احــجـز مــوعــد ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createAppointment() async {
    // print(dateUTC + ' ' + date_Time + ':00');
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.id)
        .collection('myappointments')
        .doc()
        .set({
      'username': _nameController.text,
      'phone': _phoneController.text,
      'description': _descriptionController.text,
      'doctor': _doctorController.text,
      'doctorid': widget.doctor.id,
      'date': dateUTC,
      'time': date_Time
    }).then((value) {
      FirebaseFirestore.instance
          .collection('doctors')
          .doc(widget.doctor.id)
          .collection('myappointments')
          .doc()
          .set({
        'username': _nameController.text,
        'phone': _phoneController.text,
        'description': _descriptionController.text,
        'doctor': _doctorController.text,
        'doctorid': widget.doctor.id,
        'date': dateUTC,
        'time': date_Time
      });

      Navigator.pop(context);
      Fluttertoast.showToast(msg: "تم حجز موعد!");
    }).catchError((error) {
      Fluttertoast.showToast(msg: "هـناك خـطأ!");
    });
  }
}
