import 'package:aplikacja/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseData {
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
          userID: doc['userID'],
          deleteTimestamp: doc['deleteTimestamp'].toDate(),
          creationTimestamp:
              doc['creationTimestamp']?.toDate() ?? DateTime.now(),
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

  Future<void> addOrder({
    required String title,
    required String description,
    required String price,
    required String fullDescription,
    required String phoneNumber,
    required String adress,
    required int minutes,
  }) async {
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
      'creationTimestamp': FieldValue.serverTimestamp(),
      'deleteTimestamp': DateTime.now().add(Duration(minutes: minutes)),
      'userID': userID,
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
      userID: doc['userID'],
      deleteTimestamp: doc['deleteTimestamp'].toDate(),
      creationTimestamp: doc['creationTimestamp']?.toDate() ?? DateTime.now(),
    );
  }

  Future<Model> allExtras({required String id, required String user}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('Do you must logged');
    }

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user)
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
      userID: doc['userID'],
      deleteTimestamp: doc['deleteTimestamp'].toDate(),
      creationTimestamp: doc['creationTimestamp']?.toDate() ?? DateTime.now(),
    );
  }

  Stream<List<Model>> allModel() {
    return FirebaseFirestore.instance
        .collectionGroup('items')
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
          userID: doc['userID'],
          deleteTimestamp: doc['deleteTimestamp'].toDate(),
          creationTimestamp:
              doc['creationTimestamp']?.toDate() ?? DateTime.now(),
        );
      }).toList();
    });
  }

  Future<void> editOrder(
      {required String price,
      required String phoneNumber,
      required String description,
      required String fullDescription,
      required String adress,
      required String id}) async {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('do you must logging');
    }
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('items')
        .doc(id)
        .update({
      'description': description,
      'price': price,
      'fulldescription': fullDescription,
      'phonenumber': phoneNumber,
      'adress': adress,
    });
  }
}
