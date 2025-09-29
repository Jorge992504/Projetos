import 'package:ichat/app/src/models/messages_of_user_model.dart';
import 'package:match/match.dart';

part 'home_state.g.dart';

@match
enum HomeStatus { initial, loading, loaded, success, error }

class HomeState {
  final HomeStatus status;
  final String? errorMessage;
  final List<MessagesOfUserModel>? conversas;
  HomeState.initial()
    : status = HomeStatus.initial,
      errorMessage = null,
      conversas = [];
  HomeState({required this.status, this.errorMessage, this.conversas});
  HomeState copyWith({
    HomeStatus? status,
    String? errorMessage,
    List<MessagesOfUserModel>? conversas,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      conversas: conversas ?? this.conversas,
    );
  }

  List<Object?> get props => [status, errorMessage, conversas];
}
