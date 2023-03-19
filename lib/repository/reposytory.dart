import 'package:aplikacja/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Repository {
  Stream<List<Model>> getModel() {
    return FirebaseFirestore.instance
        .collection('users')
        .orderBy('data')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Model(
            title: doc['title'],
            imgurl: doc['imgurl'],
            realdata: doc['realdata']);
      }).toList();
    });
  }
}
