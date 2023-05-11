import 'package:skezik/model/model.dart';
import 'package:skezik/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'extras_state.dart';

class ExtrasCubit extends Cubit<ExtrasState> {
  ExtrasCubit(this._repository) : super(ExtrasState(page: null));

  final Repository _repository;

  Future<void> extrapage(String id) async {
    final page = await _repository.extras(id: id);
    emit(ExtrasState(page: page));
  }
}
