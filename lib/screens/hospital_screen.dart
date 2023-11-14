//import 'dart:js_util';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:healthapp/models/hospital_model.dart';
import 'package:healthapp/screens/main_screen.dart';
import 'package:healthapp/shared/components/constant.dart';
import 'package:healthapp/shared/style/constant.dart';

import '../shared/components/components.dart';

class hospitalPage extends StatefulWidget {
  const hospitalPage({Key? key}) : super(key: key);

  @override
  State<hospitalPage> createState() => _hospitalPageState();
}

class _hospitalPageState extends State<hospitalPage> {
  var searchController = TextEditingController();
  List <hospitalModel> hospital=[];
  List <hospitalModel> hospital_serched=[];
  bool isLoading=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseFirestore.instance.collection('hospitals').where('type',isEqualTo: "1").get().then((value) {
    if(value!=null){
      hospital=value.docs.map((e) => hospitalModel.fromMap(e.data())).toList();
      setState(() {
        hospital_serched=hospital;
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
      appBar: appBarComponent(title: "الـمـسـتـشـفـيــات", context: context),
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
                      hospital_serched=hospital;
                    }else
                   hospital_serched =   hospital.where((element) => (element.title.contains(value) || element.description.contains(value))).toList();
                setState(() {
                  
                });
                  },
                  suffix: Icons.search),
              SizedBox(
                height: 20,
              ),
         isLoading? Center(child: CircularProgressIndicator()):       ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => buildHospitalCardItems(
                      hospital_serched[index], context),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                  itemCount: hospital_serched.length),
            ],
          ),
        ),
      ),
    );
  }
}
