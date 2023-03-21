import 'package:aplikacja/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Repository {
  Stream<List<Model>> getModel() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('Do you must logged');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('items')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return Model(
          title: doc['title'],
          description: doc['description'],
          price: doc['price'],
          id: doc.id,
          adress: doc['adress'],
          phoneNumber: doc['phonenumber'],
          fullDescription: doc['fulldescription'],
        );
      }).toList();
    });
  }

  Future<void> delete({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('Do you must logged');
    }

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('items')
        .doc(id)
        .delete();
  }

  Future<void> addOrder(
    String title,
    String description,
    String price,
    String fullDescription,
    String phoneNumber,
    String adress,
  ) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('Do you must logged');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('items')
        .add({
      'title': title,
      'description': description,
      'price': price,
      'fulldescription': fullDescription,
      'phonenumber': phoneNumber,
      'adress': adress,
    });
  }

  Future<Model> extras({required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('Do you must logged');
    }

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('items')
        .doc(id)
        .get();
    return Model(
      title: doc['title'],
      description: doc['description'],
      price: doc['price'],
      id: doc.id,
      phoneNumber: doc['phonenumber'],
      adress: doc['adress'],
      fullDescription: doc['fulldescription'],
    );
  }
}
