import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:healthapp/models/doctor_model.dart';
import 'package:healthapp/screens/main_screen.dart';
import 'package:healthapp/shared/components/constant.dart';

import '../shared/components/components.dart';
import '../shared/style/constant.dart';

class doctorPage extends StatefulWidget {
  const doctorPage({Key? key}) : super(key: key);

  @override
  State<doctorPage> createState() => _doctorPageState();
}

class _doctorPageState extends State<doctorPage> {
  var searchController = TextEditingController();
List<doctorModel> doctor=[];
List <doctorModel> doctor_serched=[];
  bool isLoading=true;

   void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseFirestore.instance.collection('doctors').get().then((value) {
    if(value!=null){
      doctor=value.docs.map((e) => doctorModel.fromMap(e.data())).toList();
      setState(() {
         doctor_serched=doctor;
       
        isLoading=false;
      });
    }
    }).catchError((error){
      setState(() {
         isLoading=false;
      });
      print(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarComponent(title: "أطـــبـــاء", context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: 10,
              ),
              defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  label: """... بـــحــــث """,
                   onSubmit: (value) {
                    if(value.isEmpty){
                      doctor_serched=doctor;
                    }else
                  doctor_serched =   doctor.where((element) => (element.title.contains(value)  || element.description.contains(value))).toList();
                setState(() {
                  
                });
                  },
                  suffix: Icons.search),
              SizedBox(
                height: 20,
              ),
          isLoading? CircularProgressIndicator():        ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      buildDoctorCardItems(doctor_serched[index], context),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                  itemCount: doctor_serched.length),
            ],
          ),
        ),
      ),
    );
  }
}
