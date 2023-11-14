//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:healthapp/models/details_model.dart';
import 'package:healthapp/models/hospital_model.dart';
import 'package:healthapp/screens/main_screen.dart';
import 'package:healthapp/screens/signup_screen.dart';
import 'package:healthapp/shared/components/components.dart';
import 'package:healthapp/shared/style/constant.dart';

class detailsPage extends StatefulWidget {
  hospitalModel hospitalObj;
   detailsPage({Key? key,required this.hospitalObj}) : super(key: key);

  @override
  State<detailsPage> createState() => _detailsPageState();
}

class _detailsPageState extends State<detailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(
          title: "تــفــاصــيل المــسـتـشـفـى", context: context),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child:    buildDetailsItems(widget.hospitalObj, context),
            ),
    );
  
}
}