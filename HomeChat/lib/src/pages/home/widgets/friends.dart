import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homechat/src/core/router/rotas.dart';
import 'package:homechat/src/pages/home/widgets/friend_vm/friend_state.dart';
import 'package:homechat/src/pages/home/widgets/friend_vm/friend_vm.dart';
import 'package:homechat/src/pages/home/widgets/request_vm/request_state.dart';
import 'package:homechat/src/pages/home/widgets/request_vm/request_vm.dart';
import 'package:homechat/src/ui/helpers/messages.dart';
import 'package:homechat/src/ui/image/imagens.dart';
import 'package:homechat/src/ui/sizes/size_screen.dart';

class Friends extends ConsumerStatefulWidget {
  const Friends({super.key});

  @override
  ConsumerState<Friends> createState() => _FriendsState();
}

class _FriendsState extends ConsumerState<Friends> {
  @override
  Widget build(BuildContext context) {
    final getRequest = ref.watch(requestVmProvider);
    final getFriend = ref.watch(friendVmProvider);
    ref.refresh(requestVmProvider);
    ref.refresh(friendVmProvider);
    ref.listen(requestVmProvider, (_, state) {
      switch (state) {
        // ignore: constant_pattern_never_matches_value_type
        case RequestStateStatus.initial:
          break;
        // ignore: constant_pattern_never_matches_value_type
        case RequestStateStatus.success:

        // ignore: constant_pattern_never_matches_value_type
        case RequestStateStatus.error:
          Messages.showError("Erro ao aceitar solicitação", context);
      }
    });
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 70,
                height: 30,
                margin: const EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Amigos',
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: getFriend.whenOrNull(
              data: (FriendState data) {
                return SizedBox(
                  height:
                      300, // 🔴 Altura definida para evitar problemas de layout
                  child: CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(Rotas.chat,
                                    arguments: {'user': data.friend[index]});
                              },
                              child: Container(
                                width: context.screenWidth,
                                height: 50,
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: const Border(
                                    bottom: BorderSide(
                                        color: Colors.blue, width: 1),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Dismissible(
                                    direction: DismissDirection.endToStart,
                                    key: ValueKey(data.friend[index].id),
                                    onDismissed: (direction) {
                                      if (direction ==
                                          DismissDirection.endToStart) {
                                        final aceptRequest = ref
                                            .watch(friendVmProvider.notifier);

                                        aceptRequest
                                            .deletFriend(data.friend[index].id);
                                        setState(() {
                                          data.friend.removeAt(index);
                                          ref.refresh(friendVmProvider);
                                        });
                                      }
                                    },
                                    background: Container(
                                      color: Colors.red,
                                      alignment: Alignment.centerRight,
                                      child: const Text(
                                        'Eliminar',
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.white24,
                                          child: Image(
                                            image:
                                                AssetImage(ImageConstants.user),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(width: 14),
                                        Expanded(
                                          child: Text(
                                            data.friend[index].name,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          childCount: data.friend.length,
                        ),
                      ),
                    ],
                  ),
                );
              },
              error: (error, stackTrace) => Container(),
            ),
          ),
          const SizedBox(height: 24),
          Divider(color: Colors.indigo[300]),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: context.screenWidth,
                height: 30,
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Solicitações',
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ),
            ),
          ),
          Container(
            width: context.screenMetWidth(1),
            height: 300,
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: getRequest.whenOrNull(
                data: (RequestState data) {
                  return SizedBox(
                    height: 250,
                    child: CustomScrollView(
                      slivers: [
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return InkWell(
                                onTap: () {
                                  Messages.showInfo(
                                      'Arrastre para os lados para aceitar ou recusar a solicitação',
                                      context);
                                },
                                child: Container(
                                  width: context.screenWidth,
                                  height: 50,
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: const Border(
                                      bottom: BorderSide(
                                          color: Colors.blue, width: 1),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Dismissible(
                                      direction: DismissDirection.horizontal,
                                      key: ValueKey(data.request[index].id),
                                      onDismissed: (direction) {
                                        if (direction ==
                                            DismissDirection.startToEnd) {
                                          final aceptRequest = ref.watch(
                                              requestVmProvider.notifier);
                                          aceptRequest.aceptRequest(
                                              data.request[index].id);
                                          Messages.showSuccess(
                                              'Solicitação aceitada', context);
                                          setState(() {
                                            data.request.removeAt(index);
                                            ref.refresh(requestVmProvider);
                                          });
                                        } else if (direction ==
                                            DismissDirection.endToStart) {
                                          final aceptRequest = ref.watch(
                                              requestVmProvider.notifier);
                                          aceptRequest.deletRequest(
                                              data.request[index].id);
                                          Messages.showInfo(
                                              'Solicitação recusada', context);
                                          setState(() {
                                            data.request.removeAt(index);
                                            ref.refresh(requestVmProvider);
                                          });
                                        }
                                      },
                                      background: Container(
                                        color: Colors.blue,
                                        alignment: Alignment.centerLeft,
                                        child: const Text(
                                          'Aceitar',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      secondaryBackground: Container(
                                        color: Colors.red,
                                        alignment: Alignment.centerRight,
                                        child: const Text(
                                          'Cancelar',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.white24,
                                            child: Image(
                                              image: AssetImage(
                                                  ImageConstants.user),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(width: 14),
                                          Expanded(
                                            child: Text(
                                              data.request[index].name,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            childCount: data.request.length,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                error: (error, stackTrace) => Container(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
