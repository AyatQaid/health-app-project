import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:healthapp/models/article_model.dart';
import 'package:healthapp/shared/components/components.dart';

import '../shared/components/constant.dart';

class myFavoritesPage extends StatefulWidget {
  const myFavoritesPage({Key? key}) : super(key: key);

  @override
  State<myFavoritesPage> createState() => _myFavoritesPageState();
}

class _myFavoritesPageState extends State<myFavoritesPage> {
   List<articleModel> articlesfav = [];
  bool isLoading = true;

  void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.id)
        .collection("myfavorites")
        .get()
        .then((value) {
      if (value != null) {
        articlesfav =
            value.docs.map((e) => articleModel.fromMap(e.data())).toList();
        setState(() {
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
      appBar: appBarComponent(title: "الــمــفـضـلـة", context: context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 20,
                ),
              
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                           Slidable(  startActionPane:
                              ActionPane(motion: BehindMotion(), children: [
                            SlidableAction(
                                backgroundColor: Colors.red,
                                icon: Icons.delete,
                                onPressed: ((context) {
                                  setState(() {
                                    articlesfav.removeAt(index);
                                  });
           FirebaseFirestore.instance
                .collection('users')
                .doc(user!.id)
                .collection('myfavorites')
                .get()
                .then((snapshot) {
              for (DocumentSnapshot doc in snapshot.docs) {
                doc.reference.delete();
              }
            });

        
  }))
                          ]),
                             child: buildArticleFavCardItems(
                              articlesfav[index], context),
                           ),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 10,
                            ),
                        itemCount: articlesfav.length),
              ],
            ),
          ),
        ),
      ),
    );
  
  }
}