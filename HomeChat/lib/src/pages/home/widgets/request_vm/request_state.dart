// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:homechat/src/core/models/user_model.dart';

enum RequestStateStatus {
  loaded,
  error,
  success,
  initial,
}

class RequestState {
  final RequestStateStatus status;
  final List<UserModel> request;
  RequestState({
    required this.status,
    required this.request,
  });

  RequestState copyWith({
    RequestStateStatus? status,
    List<UserModel>? request,
  }) {
    return RequestState(
      status: status ?? this.status,
      request: request ?? this.request,
    );
  }
}
