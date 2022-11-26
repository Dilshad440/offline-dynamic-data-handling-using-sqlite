import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:offline_storage/constants/global_variable.dart';
import 'package:offline_storage/response/base_response.dart';
import 'package:offline_storage/response/jake_list_response.dart';

class JakeBlocState<T> extends Equatable {
  final NetworkState? networkState;
  final BaseResponseModel<JakeListresponse>? responseModel;
  final bool isLoadingMore;
  final T? errorResponse;

  const JakeBlocState({
    this.networkState,
    this.responseModel,
    this.isLoadingMore = false,
    this.errorResponse,
  });

  JakeBlocState copyWith({
    final NetworkState? networkState,
    final BaseResponseModel<JakeListresponse>? responseModel,
    final bool? isLoadingMore,
    final T? errorResponse,
  }) {
    return JakeBlocState(
        networkState: networkState ?? this.networkState,
        responseModel: responseModel ?? this.responseModel,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        errorResponse: errorResponse ?? this.errorResponse);
  }

  @override
  String toString() {
    return 'JakeBlocState{networkState: $networkState, requestStatus: $responseModel}';
  }

  @override
  List<Object?> get props =>
      [networkState, responseModel, isLoadingMore, errorResponse];
}
