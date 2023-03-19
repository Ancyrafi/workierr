part of 'order_cubit.dart';

class OrderState {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;
  bool load = false;

  OrderState(
      {required this.documents, required this.load});
}
