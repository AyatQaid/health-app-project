import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:healthapp/screens/main_screen.dart';
import 'package:healthapp/shared/components/components.dart';
import 'package:healthapp/shared/style/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class aboutAppPage extends StatelessWidget {
  const aboutAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(title: "عـــن التــطــبــيـق ", context: context),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Container(
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  spreadRadius: 2, // Spread radius
                  blurRadius: 2, // Blur radius
                  // offset: Offset(0, 3), // Offset in the x and y direction
                ),
              ],
            ),
            padding: EdgeInsets.all(30),
            child: Text(
              """تم تصميم تطبيق "صحة" ليوفر للمستخدمين حلاً شاملاً للعثور على الخدمات الطبية وحجزها في عدن، بالإضافة إلى الوصول إلى المعلومات الطبية المهمة وأرقام الطوارئ.
      تتضمن بعض الفوائد المحتملة لهذا التطبيق ما يلي: سهولة الوصول إلى مقدمي الخدمات الطبية: من خلال تزويد المستخدمين بمنصة مركزية
                                                    للعثور على الخدمات الطبية وحجزها.
      تحسين النتائج الصحية: من خلال تزويد المستخدمين بإمكانية الوصول إلى المعلومات الطبية المهمة وموارد الطوارئ، يمكن أن يساعد التطبيق في تحسين النتائج الصحية من خلال تعزيز الرعاية الوقائية وتوفير الوصول في الوقت المناسب إلى خدمات الطوارئ.
      زيادة الكفاءة: من خلال أتمتة عملية الحجز للمواعيد الطبية، يمكن أن يساعد التطبيق في تقليل أوقات الانتظار وتحسين كفاءة تقديم الرعاية الصحية، وتجربة المستخدم المحسنة: من خلال تقديم واجهة سهلة الاستخدام وتوفير مجموعة واسعة من الميزات والقدرات. يمكن أن يساعد التطبيق في تحسين تجربة المستخدم الشاملة وتحسين رضا العملاء.""",
              textAlign: TextAlign.right,
              style: normalTextRegular,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            "للـتـواصــل",
            style: mediumTextBold,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    launchUrl(Uri(
                      scheme: 'sms',
                      path: '779949435',
                    ));
                  },
                  icon: Icon(
                    Icons.whatsapp,
                    size: 35,
                    color: mainColor,
                  )),
              SizedBox(
                width: 6,
              ),
              IconButton(
                  onPressed: () {
                    launchUrl(Uri(
                      scheme: 'tel',
                      path: '779784007',
                    ));
                  },
                  icon: Icon(Icons.phone_in_talk_sharp,
                      size: 35, color: mainColor)),
              SizedBox(
                width: 6,
              ),
              IconButton(
                  onPressed: () {
                    launchUrl(Uri(
                      scheme: 'https',
                      path:
                          'https://www.facebook.com/sara.zain.1276?mibextid=ZbWKwL',
                    ));
                  },
                  icon:
                      Icon(Icons.facebook_outlined, size: 35, color: mainColor))
            ],
          )
        ],
      ),
    );
  }
}
