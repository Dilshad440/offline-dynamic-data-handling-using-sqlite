class BaseResponseModel<T> {
  final int? status;
  String? message;
  final T body;

  BaseResponseModel({
    this.status,
    this.message,
    required this.body,
  });

  @override
  String toString() {
    return 'RequestStatus( message=$message, body=$body)';
  }
}
