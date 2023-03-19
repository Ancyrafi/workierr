import 'package:aplikacja/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Repository {
  Stream<List<Model>> getModel() {
    return FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Model(
            title: doc['title'],
            description: doc['description'],
            price: doc['price']);
      }).toList();
    });
  }
}
