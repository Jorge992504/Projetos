import 'dart:developer';

import 'package:homechat/src/core/exceptions/repository_exception.dart';
import 'package:homechat/src/core/fp/either.dart';
import 'package:homechat/src/core/providers/application_provider.dart';
import 'package:homechat/src/pages/home/widgets/request_vm/request_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'request_vm.g.dart';

@riverpod
class RequestVm extends _$RequestVm {
  @override
  Future<RequestState> build() async {
    try {
      final repository = ref.read(repositoryGeneralProvider);
      final request = await repository.getRequest();

      switch (request) {
        case Success(value: final request):
          return RequestState(
              status: RequestStateStatus.loaded, request: request);
        case Failure():
          return RequestState(status: RequestStateStatus.error, request: []);
      }
    } on Exception catch (e, s) {
      log('Erro: ', error: e, stackTrace: s);

      return throw RepositoryException(
        message: 'Erro ao buscar solicitações',
      );
    }
  }

  Future<void> aceptRequest(int friendId) async {
    final repository = ref.read(repositoryGeneralProvider);
    final dto = (friendId: friendId);
    final result = await repository.aceptRequest(dto);
    switch (result) {
      case Success():
        ref.invalidate(repositoryGeneralProvider);
        state = RequestStateStatus.success as AsyncValue<RequestState>;
      case Failure():
        state = RequestStateStatus.error as AsyncValue<RequestState>;
    }
  }

  Future<void> deletRequest(int request) async {
    final repository = ref.read(repositoryGeneralProvider);
    final dto = (request: request);
    final result = await repository.deletRequest(dto);
    switch (result) {
      case Success():
        state = RequestStateStatus.success as AsyncValue<RequestState>;
        break;
      case Failure():
        state = state = RequestStateStatus.error as AsyncValue<RequestState>;
        break;
    }
  }
}
