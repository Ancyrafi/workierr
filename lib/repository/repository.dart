import 'package:aplikacja/data/firebase/firebase.dart';
import 'package:aplikacja/model/model.dart';

class Repository {
  final FirebaseData _firebaseData = FirebaseData();

  Future<void> delete({required String id}) async {
    _firebaseData.delete(id: id);
  }

  Stream<List<Model>> getModel() {
    return _firebaseData.getModel();
  }

  Future<void> addOrder({
    required String title,
    required String description,
    required String price,
    required String fullDescription,
    required String phoneNumber,
    required String adress,
    required int hours,
  }) async {
    _firebaseData.addOrder(
        title: title,
        description: description,
        price: price,
        fullDescription: fullDescription,
        phoneNumber: phoneNumber,
        adress: adress,
        hours: hours);
  }

  Future<Model> extras({required id}) async {
    return _firebaseData.extras(id: id);
  }

  Stream<List<Model>> allModel() {
    return _firebaseData.allModel();
  }

  Future<Model> allExtras({
    required String id,
    required String user,
  }) async {
    return _firebaseData.allExtras(id: id, user: user);
  }
}
