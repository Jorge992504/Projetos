import 'package:homechat/src/core/models/user_model.dart';

enum FriendStateStatus {
  loaded,
  error,
  success,
  initial,
}

class FriendState {
  final FriendStateStatus status;
  final List<UserModel> friend;
  FriendState({
    required this.status,
    required this.friend,
  });

  FriendState copyWith({
    FriendStateStatus? status,
    List<UserModel>? friend,
  }) {
    return FriendState(
      status: status ?? this.status,
      friend: friend ?? this.friend,
    );
  }
}
