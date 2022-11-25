import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_storage/helper/sqf_lite_service.dart';
import 'package:offline_storage/response/response.dart';
import 'package:offline_storage/source/api_source.dart';

part 'jake_bloc_state.dart';

class JakeBlocCubit extends Cubit<JakeBlocState> {
  JakeBlocCubit() : super(JakeBlocInitial());

  final _apiService = ApiSource();
  final _sqfLiteServies = SqfLiteService();

  void getJake(int page) async {
    emit(JakeBlocInitial());
    try {
      final jake = await _apiService.fetchData(page);
      emit(JakeBlocCompleted(jake));
      for (var j in jake) {
        _sqfLiteServies.insertIntoDb(j);
      }

      // _sqfLiteServies.insertIntoDb(jake[0]);
    } catch (e) {
      emit(JakeBlocError(e.toString()));
    }
  }

  void getJakeFromDb() async {
    emit(JakeBlocInitial());
    try {
      final data = await _sqfLiteServies.getFromDb();
      emit(JakeBlocCompleted(data));
    } catch (e) {
      emit(JakeBlocError(e.toString()));
    }
  }
}
