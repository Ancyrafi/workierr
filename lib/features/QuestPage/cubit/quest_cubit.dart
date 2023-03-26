import 'dart:async';

import 'package:aplikacja/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/model.dart';

part 'quest_state.dart';

class QuestCubit extends Cubit<QuestState> {
  QuestCubit(this._repository)
      : super(
          QuestState(
            documents: [],
            load: false,
          ),
        );
  final Repository _repository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(
      QuestState(
        documents: [],
        load: true,
      ),
    );

    await Future.delayed(
      const Duration(seconds: 1),
    );

    _streamSubscription = _repository.allModel().listen((model) {
      emit(
        QuestState(documents: model, load: false),
      );
    })
      ..onError((error) {
        emit(
          QuestState(documents: [], load: true),
        );
      });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
