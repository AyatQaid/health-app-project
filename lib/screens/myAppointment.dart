import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:healthapp/models/appointment_model.dart';
import 'package:healthapp/shared/components/components.dart';
import 'package:healthapp/shared/components/constant.dart';
import 'package:healthapp/shared/style/constant.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class myAppointmentPage extends StatefulWidget {
  const myAppointmentPage({Key? key}) : super(key: key);

  @override
  State<myAppointmentPage> createState() => _myAppointmentPageState();
}

class _myAppointmentPageState extends State<myAppointmentPage> {
  List<appointmentModel> app = [];
  bool isLoading = true;

  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.id)
        .collection("myappointments")
        .get()
        .then((value) {
      if (value != null) {
        app =
            value.docs.map((e) => appointmentModel.fromMap(e.data())).toList();
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((error) {
      setState(() {
        isLoading = false;
      });
      print(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarComponent(title: "مــواعــيدي", context: context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 20,
              ),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Slidable(
                          startActionPane:
                              ActionPane(motion: BehindMotion(), children: [
                            SlidableAction(
                                backgroundColor: Colors.red,
                                icon: Icons.delete,
                                onPressed: ((context) {
                                  setState(() {
                                    app.removeAt(index);
                                  });
            FirebaseFirestore.instance
                .collection('users')
                .doc(user!.id)
                .collection('myappointments')
                .get()
                .then((snapshot) {
              for (DocumentSnapshot doc in snapshot.docs) {
                doc.reference.delete();
              }
            });
                                }))
                          ]),
                          child: buildMyAppointmentItems(app[index], context)),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                      itemCount: app.length),
            ],
          ),
        ),
      ),
    );
  }
}