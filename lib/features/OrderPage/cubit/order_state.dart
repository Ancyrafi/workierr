part of 'order_cubit.dart';

class OrderState {
  final String title;
  final String description;
  final String price;
  bool load = false;

  OrderState(
      {required this.title, required this.description, required this.price, required this.load});
}
