



import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:famibo/core/data/remote_data_source.dart';
import 'package:famibo/list_todo/shopping/domain/shopping_model.dart';
import 'package:flutter/material.dart';

class ShoppingRepository {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //

  Future<List<Shopping>> fetchShoppingsFromServer() async {
    try{
      QuerySnapshot collection = await firestore.collection('shoppings').get();

      List<Map<String, dynamic>> rawData = collection.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

           List<Shopping> shoppings =
          rawData.map((val) => Shopping.fromJson(val)).toList();
          
       return shoppings;
    } catch (err) {
      debugPrint(err.toString());
      return [];
    }
  }

//   Future createShoppingOnServer(Shopping shopping) async {
//     remoteDataSource.postData("irgendeinen Link", shopping);
//   }
// }
}