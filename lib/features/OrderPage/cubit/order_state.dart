part of 'order_cubit.dart';

class OrderState {
  final List<Model> documents;
  bool load = false;

  OrderState(
      {required this.documents, required this.load});
}
