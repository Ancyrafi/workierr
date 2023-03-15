import 'package:flutter_bloc/flutter_bloc.dart';

part 'quest_state.dart';

class QuestCubit extends Cubit<QuestState> {
  QuestCubit() : super(QuestState());
}
