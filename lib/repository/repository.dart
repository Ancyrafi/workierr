import 'package:skezik/data/firebase/firebase.dart';

class Repository {
  final FirebaseData _firebaseData = FirebaseData();

  Future<void> delete({required String id}) async {
    _firebaseData.delete(id: id);
  }

  Stream getModel() {
    return _firebaseData.getModel();
  }

  Future<void> addOrder({
    required String title,
    required String description,
    required String price,
    required String fullDescription,
    required String phoneNumber,
    required String adress,
    required int minutes,
    required String city,
  }) async {
    _firebaseData.addOrder(
        city: city,
        title: title,
        description: description,
        price: price,
        fullDescription: fullDescription,
        phoneNumber: phoneNumber,
        adress: adress,
        minutes: minutes);
  }

  Future extras({required id}) async {
    return _firebaseData.extras(id: id);
  }

  Stream allModel() {
    return _firebaseData.allModel();
  }

  Future allExtras({
    required String id,
    required String user,
  }) async {
    return _firebaseData.allExtras(id: id, user: user);
  }

  Future<void> edit(
      {required String price,
      required String phoneNumber,
      required String description,
      required String fullDescription,
      required String adress,
      required String id}) async {
    return _firebaseData.editOrder(
        price: price,
        phoneNumber: phoneNumber,
        description: description,
        fullDescription: fullDescription,
        adress: adress,
        id: id);
  }
}
