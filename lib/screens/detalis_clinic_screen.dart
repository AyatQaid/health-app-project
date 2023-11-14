import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:healthapp/models/clinic_model.dart';
import 'package:healthapp/shared/components/components.dart';

class detailClinicPage extends StatefulWidget {
  clinicModel clinicObj;

  detailClinicPage({Key? key, required this.clinicObj}) : super(key: key);

  @override
  State<detailClinicPage> createState() => _detailClinicPageState();
}

class _detailClinicPageState extends State<detailClinicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          appBarComponent(title: "تــفــاصــيل العــيــادة", context: context),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: buildDetailsClinicItems(widget.clinicObj, context),
      ),
    );
  }
}
