import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:healthapp/models/lab_model.dart';
import 'package:healthapp/screens/main_screen.dart';
import 'package:healthapp/shared/components/constant.dart';

import '../shared/components/components.dart';
import '../shared/style/constant.dart';

class labPage extends StatefulWidget {
  const labPage({Key? key}) : super(key: key);

  @override
  State<labPage> createState() => _labPageState();
}

class _labPageState extends State<labPage> {
  var searchController = TextEditingController();
List <labModel> lab=[];

  List <labModel> lab_serched=[];
  bool isLoading=true;
  @override

    void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseFirestore.instance.collection('labs').where('type',isEqualTo: "3").get().then((value) {
    if(value!=null){
      lab=value.docs.map((e) => labModel.fromMap(e.data())).toList();
      setState(() {
        lab_serched=lab;
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
      appBar: appBarComponent(title: "مــخــتـبــرات", context: context),
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
                      lab_serched=lab;
                    }else
                  lab_serched =   lab.where((element) => (element.title.contains(value) || element.description.contains(value))).toList();
                setState(() {
                  
                });
                  },
                  suffix: Icons.search),
              SizedBox(
                height: 20,
              ),
            
            isLoading? Center(child: CircularProgressIndicator()):  ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      buildLabCardItems(  lab_serched[index], context),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                  itemCount: lab_serched.length),
            ],
          ),
        ),
      ),
    );
  }
}
