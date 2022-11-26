import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_storage/constants/global_variable.dart';
import 'package:offline_storage/cubit/jake_bloc_state.dart';
import 'package:offline_storage/helper/sqf_lite_service.dart';
import 'package:offline_storage/response/response.dart';
import 'package:offline_storage/source/api_source.dart';
import 'package:sqflite/sqlite_api.dart';

class JakeBlocCubit extends Cubit<JakeBlocState> {
  JakeBlocCubit() : super(const JakeBlocState());

  final _apiService = ApiSource();
  final _sqfLiteServices = SqfLiteService();
  JakeBlocState? jakeBlocState;

  final List<JakeWharton> jakeList = [];
  int page = 0;

  void getJake() async {
    emit(state.copyWith(networkState: NetworkState.loading));
    try {
      final jake = await _apiService.fetchData(page);

      emit(state.copyWith(
        networkState: NetworkState.loaded,
        responseModel: jake,
      ));
      for (var j in jake.body.jake) {
        _sqfLiteServices.insertIntoDb(j);
      }
    } catch (e) {
      if (e is DioError) {
        emit(state.copyWith(
          errorResponse: e.response,
          networkState: NetworkState.failed,
          responseModel: null,
        ));
      }
    }
  }

  void getMoreJake() async {
    page++;
    emit(state.copyWith(isLoadingMore: true));
    try {
      final jake = await _apiService.fetchData(page);
      state.responseModel?.body.jake.addAll(jake.body.jake);
      emit(state.copyWith(
        isLoadingMore: false,
        networkState: NetworkState.loaded,
        responseModel: state.responseModel,
      ));
      for (var j in jake.body.jake) {
        _sqfLiteServices.insertIntoDb(j);
      }
    } catch (e) {
      if (e is DioError) {
        emit(state.copyWith(
          networkState: NetworkState.failed,
          responseModel: null,
          errorResponse: e.response,
        ));
        page--;
      }
    }
  }

  void getJakeFromDb() async {
    emit(state.copyWith(networkState: NetworkState.loading));
    try {
      final offlineData = await _sqfLiteServices.getFromDb();
      emit(state.copyWith(
        networkState: NetworkState.loaded,
        responseModel: offlineData,
      ));
    } catch (e) {
      if (e is DatabaseException) {
        emit(state.copyWith(
          networkState: NetworkState.failed,
          errorResponse: e.result,
          responseModel: null,
        ));
      }
    }
  }
}
