import 'package:aplikacja/model/model.dart';
import 'package:aplikacja/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'allextras_state.dart';

class AllextrasCubit extends Cubit<AllextrasState> {
  AllextrasCubit(this._repository)
      : super(AllextrasState(
          page: null,
        ));
  final Repository _repository;

  Future<void> allUser({required String id, required String user}) async {
    final page = await _repository.allExtras(id: id, user: user);
    emit(AllextrasState(page: page));
  }
}
