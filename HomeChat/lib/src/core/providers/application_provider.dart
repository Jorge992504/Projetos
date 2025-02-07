import 'dart:async';

import 'package:homechat/src/core/client/res_client.dart';
import 'package:homechat/src/core/client/ws_client.dart';
import 'package:homechat/src/core/fp/either.dart';
import 'package:homechat/src/core/models/message_model.dart';

import 'package:homechat/src/core/models/user_model.dart';
import 'package:homechat/src/core/repositories/auth/auth_repository.dart';
import 'package:homechat/src/core/repositories/auth/auth_repository_impl.dart';
import 'package:homechat/src/core/repositories/general/repository_general.dart';
import 'package:homechat/src/core/repositories/general/repository_general_impl.dart';
import 'package:homechat/src/core/repositories/messages/repository_messages.dart';
import 'package:homechat/src/core/repositories/messages/repository_messages_impl.dart';

import 'package:homechat/src/core/service/login/login_service.dart';
import 'package:homechat/src/core/service/login/login_service_impl.dart';
import 'package:homechat/src/core/service/register_service/register_service.dart';
import 'package:homechat/src/core/service/register_service/register_service_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'application_provider.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();
@Riverpod(keepAlive: true)
SocketClient socket(SocketRef ref) => SocketClient();

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) =>
    AuthRepositoryImpl(restClient: ref.read(restClientProvider));

@Riverpod(keepAlive: true)
LoginService loginService(LoginServiceRef ref) =>
    LoginServiceImpl(authRepository: ref.read(authRepositoryProvider));

//RESGISTER
@Riverpod(keepAlive: true)
RegisterService registerService(RegisterServiceRef ref) => RegisterServiceImpl(
    authRepository: ref.watch(authRepositoryProvider),
    loginService: ref.watch(loginServiceProvider));

@Riverpod(keepAlive: true)
Future<UserModel> getMe(GetMeRef ref) async {
  final result = await ref.watch(authRepositoryProvider).me();
  return switch (result) {
    Success(value: final userModel) => userModel,
    Failure(:final exception) => throw exception,
  };
}

@Riverpod(keepAlive: true)
RepositoryMessages repositoryMessages(RepositoryMessagesRef ref) =>
    RepositoryMessagesImpl(restClient: ref.watch(restClientProvider));

//
@Riverpod(keepAlive: true)
RepositoryGeneral repositoryGeneral(RepositoryGeneralRef ref) =>
    RepositoryGeneralImpl(restClient: ref.watch(restClientProvider));

@Riverpod(keepAlive: true)
Future<List<UserModel>> getMeUsers(GetMeUsersRef ref) async {
  final users = await ref.watch(getMeUsersProvider.future);
  final repositoryGeneral = ref.watch(repositoryGeneralProvider);
  final result = await repositoryGeneral.getUsers(users);
  return switch (result) {
    Success(value: final users) => users,
    Failure(:final exception) => throw exception,
  };
}

@Riverpod(keepAlive: true)
Future<void> logout(LogoutRef ref) async {
  final sp = await SharedPreferences.getInstance();
  final socket = ref.read(socketProvider);
  socket.disconnect(true);

  await sp.remove('token');

  ref.invalidate(getMeProvider);
  ref.invalidate(getMeUsersProvider);
  ref.invalidate(repositoryGeneralProvider);
  ref.invalidate(repositoryMessagesProvider);
  ref.invalidate(socketProvider);
  ref.invalidate(authRepositoryProvider);
  ref.invalidate(registerServiceProvider);
  ref.invalidate(loginServiceProvider);

  await Future.delayed(const Duration(milliseconds: 500));
  await sp.clear();
}

@Riverpod(keepAlive: true)
Stream<MessageModel> messageStream(MessageStreamRef ref) {
  final socketClient = ref.read(socketProvider);
  final controller = StreamController<MessageModel>.broadcast();

  socketClient.socket?.on('mensagem', (msg) {
    final message = MessageModel.fromMap(msg);
    controller.add(message);
  });

  ref.onDispose(() {
    controller.close();
  });

  return controller.stream;
  // final messageStream = ref.watch(messageStreamProvider);para qualquer tela ouvir as mensagens
}
