import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:healthapp/models/article_model.dart';
import 'package:healthapp/screens/article_content_screen.dart';
import 'package:healthapp/screens/main_screen.dart';
import 'package:healthapp/shared/components/components.dart';
import 'package:healthapp/shared/components/constant.dart';
import 'package:healthapp/shared/style/constant.dart';

class articlesPage extends StatefulWidget {
  const articlesPage({Key? key}) : super(key: key);

  @override
  State<articlesPage> createState() => _articlesPageState();
}

class _articlesPageState extends State<articlesPage> {
  var searchController = TextEditingController();
  List<articleModel> article = [];
  List<articleModel> article_serched = [];
  bool isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseFirestore.instance.collection('articles').get().then((value) {
      if (value != null) {
        article =
            value.docs.map((e) => articleModel.fromMap(e.data())).toList();
        setState(() {
          article_serched = article;
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
      appBar: appBarComponent(title: "الـمــقـالات", context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
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
                      if (value.isEmpty) {
                        article_serched = article;
                      } else
                        article_serched = article
                            .where((element) =>
                                (element.title.contains(value) ||
                                    element.subtitle.contains(value)))
                            .toList();
                      setState(() {});
                    },
                    suffix: Icons.search),
                SizedBox(
                  height: 30,
                ),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => buildArticleCardItems(
                            article_serched[index], context),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                        itemCount: article_serched.length),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
