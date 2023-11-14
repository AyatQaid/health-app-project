import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:healthapp/models/lab_model.dart';
import 'package:healthapp/shared/components/components.dart';

class detailLabPage extends StatefulWidget {
    labModel labObj;

   detailLabPage({Key? key,required this.labObj}) : super(key: key);

  @override
  State<detailLabPage> createState() => _detailLabPageState();
}

class _detailLabPageState extends State<detailLabPage> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar:
          appBarComponent(title: "تــفــاصــيل الـمـخـتـبـرات", context: context),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: buildDetailsLabItems(widget.labObj, context),
      ),
    );
  
  }
}