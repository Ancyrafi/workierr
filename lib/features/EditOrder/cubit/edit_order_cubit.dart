import 'package:skezik/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_order_state.dart';

class EditOrderCubit extends Cubit<EditOrderState> {
  EditOrderCubit(this._repository) : super(EditOrderState());

  final Repository _repository;

  Future<void> editOrder(
      {required String price,
      required String phoneNumber,
      required String description,
      required String fullDescription,
      required String adress,
      required String id}) async {
    await _repository.edit(
        price: price,
        phoneNumber: phoneNumber,
        description: description,
        fullDescription: adress,
        adress: fullDescription,
        id: id);
  }
}
