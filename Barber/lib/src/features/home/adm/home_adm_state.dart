// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:barber/src/models/user_model.dart';

enum HomeAmdStateStatus { loaded, error }

class HomeAdmState {
  final HomeAmdStateStatus status;
  final List<UserModel> employee;

  HomeAdmState({required this.status, required this.employee});

  HomeAdmState copyWith({
    HomeAmdStateStatus? status,
    List<UserModel>? employee,
  }) {
    return HomeAdmState(
      status: status ?? this.status,
      employee: employee ?? this.employee,
    );
  }
}
