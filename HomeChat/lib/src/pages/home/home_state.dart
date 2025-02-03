// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:homechat/src/core/models/user_model.dart';

enum HomeStateStatus {
  loaded,
  error,
}

class HomeState {
  final HomeStateStatus status;
  final List<UserModel> users;
  HomeState({
    required this.status,
    required this.users,
  });

  HomeState copyWith({
    HomeStateStatus? status,
    List<UserModel>? users,
  }) {
    return HomeState(
      status: status ?? this.status,
      users: users ?? this.users,
    );
  }
}
