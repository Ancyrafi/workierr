import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'addorder_state.dart';

class AddOrderCubit extends Cubit<bool> {
  AddOrderCubit() : super(false);

  final _ordersCollection = FirebaseFirestore.instance.collection('users');

  Future<void> addOrder(String title, String description, String price) async {
    emit(false);
    try {
      await _ordersCollection.add({
        'title': title,
        'description': description,
        'price': price,
      });
      emit(true);
    } catch (e) {
      emit(false);
      throw Exception('Nie udało się dodać zlecenia: $e');
    }
  }
}
