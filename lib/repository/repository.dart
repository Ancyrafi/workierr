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
    await FirebaseFirestore.instance.collection('users').doc(id).delete();
  }

  Future<void> addOrder(
    String title,
    String description,
    String price,
    String fullDescription,
    String phoneNumber,
    String adress,
  ) async {
    await FirebaseFirestore.instance.collection('users').add({
      'title': title,
      'description': description,
      'price': price,
      'fulldescription': fullDescription,
      'phonenumber': phoneNumber,
      'adress': adress,
    });
  }

  Future<Model> extras({required String id}) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
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
