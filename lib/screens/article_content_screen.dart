import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:healthapp/screens/main_screen.dart';
import 'package:healthapp/shared/components/components.dart';
import 'package:healthapp/shared/components/constant.dart';
import 'package:healthapp/shared/style/constant.dart';

import '../models/article_model.dart';

/*class articleContent extends StatelessWidget {
  articleModel articleObj;
 
  articleContent({Key? key, required this.articleObj,}) : super(key: key);
  
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(title: "الــمــقــالات", context: context),
      backgroundColor: Colors.white,
      body: buildArticleContent(articleObj, context ),
    );
  }
}
*/
class articleContent extends StatefulWidget {
  articleModel articleObj;
  articleContent({
    Key? key,
    required this.articleObj,
  }) : super(key: key);

  @override
  State<articleContent> createState() => _articleContentState();
}

class _articleContentState extends State<articleContent> {
  bool isFavorite = false;

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      if (isFavorite) {
        addToFavorites(widget.articleObj);

        /* void initState() {
    // TODO: implement initState
    super.initState();

    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.id)
        .collection("myfavorites")
        .add({ 'imgAssetPath': articlefav!.imgAssetPath,
      'title': articlefav!.title,
      'subtitle': articlefav!.subtitle,}).then((value) => null);
       
  }

  */
      }
    });
  }

  Future<void> addToFavorites(articleModel articlefav) async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.id)
          .collection('myfavorites')
          .add({
        "id": articlefav.id,
        'imgAssetPath': articlefav.imgAssetPath,
        'title': articlefav.title,
        'subtitle': articlefav.subtitle,
      });

      print(' successfully!');
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarComponent(title: "الــمــقــالات", context: context),
      backgroundColor: Colors.white,
      body: buildArticleContent(
          widget.articleObj, context, isFavorite, toggleFavorite),
    );
  }
}
