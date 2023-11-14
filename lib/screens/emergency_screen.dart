import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:healthapp/models/emergency_model.dart';
import 'package:healthapp/screens/main_screen.dart';
import 'package:healthapp/shared/components/components.dart';
import 'package:healthapp/shared/components/constant.dart';
import 'package:healthapp/shared/style/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class emergencyPage extends StatefulWidget {
  const emergencyPage({Key? key}) : super(key: key);

  @override
  State<emergencyPage> createState() => _emergencyPageState();
}

class _emergencyPageState extends State<emergencyPage> {
  var searchController = TextEditingController();

  List<emergencyModel> emergency_serched = [];
  bool isLoading = true;
  List<emergencyModel> emergency = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseFirestore.instance.collection('emergency').get().then((value) {
      if (value != null) {
        emergency =
            value.docs.map((e) => emergencyModel.fromMap(e.data())).toList();
        setState(() {
          emergency_serched = emergency;
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

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBarComponent(title: "الــطــوارئ", context: context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              SizedBox(
                height: 10,
              ),
              defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  label: """... بـــحــــث """,
                  onSubmit: (value) {
                    if (value.isEmpty) {
                      emergency_serched = emergency;
                    } else
                      emergency_serched = emergency
                          .where((element) => (element.title.contains(value)))
                          .toList();
                    setState(() {});
                  },
                  suffix: Icons.search),
              SizedBox(
                height: 25,
              ),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => buildEmergencyCardItems(
                          emergency_serched[index], context),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 25,
                          ),
                      itemCount: emergency_serched.length),
            ]),
          ),
        ));
  }
}
    /*  Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(70),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          spreadRadius: 0,
                          // offset: Offset(0, 1),
                          color: Colors.grey,
                        )
                      ],
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "سـيــارات الاسـعـاف",
                            style: TextStyle(
                                color: mainColor, fontWeight: FontWeight.bold),
                          )),
                      Container(width: 2, height: 20, color: mainColor),
                      Container(
                        color: Colors.green.shade50,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => emergencyPage()));
                            },
                            child: Text(
                              "طـوارئ المسـتـشـفـيـات",
                              style: TextStyle(
                                  color: mainColor, fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
             */
          