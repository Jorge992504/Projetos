import 'dart:developer';

import 'package:homechat/src/core/exceptions/repository_exception.dart';
import 'package:homechat/src/core/fp/either.dart';
import 'package:homechat/src/core/providers/application_provider.dart';
import 'package:homechat/src/pages/home/widgets/friend_vm/friend_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'friend_vm.g.dart';

@riverpod
class FriendVm extends _$FriendVm {
  @override
  Future<FriendState> build() async {
    try {
      final repository = ref.read(repositoryGeneralProvider);
      final friend = await repository.getFriend();

      switch (friend) {
        case Success(value: final friend):
          return FriendState(status: FriendStateStatus.loaded, friend: friend);
        case Failure():
          return FriendState(status: FriendStateStatus.error, friend: []);
      }
    } on Exception catch (e, s) {
      log('Erro: ', error: e, stackTrace: s);

      return throw RepositoryException(
        message: 'Erro ao buscar solicitações',
      );
    }
  }

  Future<void> deletFriend(int friendId) async {
    final repository = ref.read(repositoryGeneralProvider);
    final dto = (friendId: friendId);
    final result = await repository.deletFriend(dto);
    switch (result) {
      case Success():
        state = FriendStateStatus.success as AsyncValue<FriendState>;
        break;
      case Failure():
        state = state = FriendStateStatus.error as AsyncValue<FriendState>;
        break;
    }
  }
}
