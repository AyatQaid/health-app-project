import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:healthapp/models/clinic_model.dart';
import 'package:healthapp/screens/main_screen.dart';
import 'package:healthapp/shared/components/constant.dart';

import '../shared/components/components.dart';
import '../shared/style/constant.dart';

class clinicPage extends StatefulWidget {
  const clinicPage({Key? key}) : super(key: key);

  @override
  State<clinicPage> createState() => _clinicPageState();
}

class _clinicPageState extends State<clinicPage> {
  var searchController = TextEditingController();
    List <clinicModel> clinic=[];

  List <clinicModel> clinic_serched=[];
  bool isLoading=true;
  @override

    void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseFirestore.instance.collection('clinics').where('type',isEqualTo: "2").get().then((value) {
    if(value!=null){
      clinic=value.docs.map((e) => clinicModel.fromMap(e.data())).toList();
      setState(() {
        clinic_serched=clinic;
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
      appBar: appBarComponent(title: "الــعــيـادات", context: context),
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
                      clinic_serched=clinic;
                    }else
                   clinic_serched =   clinic.where((element) => (element.title.contains(value)  || element.description.contains(value))).toList();
                setState(() {
                  
                });
                  },
                  suffix: Icons.search),
              SizedBox(
                height: 20,
              ),
            isLoading? Center(child: CircularProgressIndicator()):   ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      buildClinicCardItems( clinic_serched[index], context),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                  itemCount: clinic_serched.length),
            ],
          ),
        ),
      ),
    );
  }
}
