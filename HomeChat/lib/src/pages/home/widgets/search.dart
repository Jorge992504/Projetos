import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homechat/src/core/models/user_model.dart';
import 'package:homechat/src/core/router/rotas.dart';
import 'package:homechat/src/pages/home/home_vm.dart';
import 'package:homechat/src/ui/helpers/messages.dart';

import 'package:homechat/src/ui/sizes/size_screen.dart';

class Search extends ConsumerStatefulWidget {
  const Search({super.key});

  @override
  ConsumerState<Search> createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> {
  List<UserModel> suggestions = [];
  List<UserModel> allUsers = [];
  final FocusNode searchFocusNode = FocusNode();
  bool isFocused = false;
  final searchEC = TextEditingController();
  bool isButtonEnabled = false;

  bool showSuggestions = false;

  @override
  void initState() {
    super.initState();
    fetchAllUsers();

    searchFocusNode.addListener(() {
      setState(() {
        isFocused = searchFocusNode.hasFocus;
        showSuggestions = true;
      });
    });
    // searchEC.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    searchEC.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled =
          (searchEC.text.isEmpty || suggestions.isNotEmpty) || !isFocused;
    });
  }

  Future<void> fetchAllUsers() async {
    final homeState = await ref.read(homeVmProvider.future);
    setState(() {
      allUsers = homeState.users.toList();
    });
  }

  void fetchSuggestions(String query) {
    setState(() {
      if (query.isEmpty) {
        suggestions = [];
        setState(() {});
      } else {
        suggestions = allUsers
            .where(
                (user) => user.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void addFriends(int userId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue[200],
          title: const Text('Enviar solicitação de amizade?'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    final addFriends = ref.watch(homeVmProvider.notifier);
                    addFriends.addFriends(userId);
                    Messages.showInfo('Convite enviado', context);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Sim',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Messages.showError('Envio do convite cancelado', context);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Não',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.refresh(homeVmProvider);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 44,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SizedBox(
              height: 45,
              width: context.screenMetWidth(0.95),
              child: TextField(
                onTap: () {
                  // ref.refresh(homeVmProvider);
                },
                textAlign: TextAlign.start,
                controller: searchEC,
                focusNode: searchFocusNode
                  ..addListener(() {
                    setState(() {
                      isFocused = !isFocused;
                      _updateButtonState();
                    });
                  }),
                decoration: InputDecoration(
                  labelText: 'Buscar amigos',
                  prefixIcon: const Icon(Icons.search, color: Colors.blue),
                  suffixIcon: Visibility(
                    visible:
                        (searchEC.text.isEmpty || suggestions.isNotEmpty) ||
                                !isFocused
                            ? false
                            : true,
                    child: IconButton(
                      enableFeedback: true,
                      onPressed: () {
                        isFocused = false;
                        searchFocusNode.unfocus();
                        Navigator.of(context).pushNamed(Rotas.convite);
                      },
                      icon: const Icon(
                        Icons.mail,
                        // color: (searchEC.text.isEmpty || suggestions.isNotEmpty) ||
                        //         !isFocused
                        //     ? Colors.white
                        //     : Colors.blue,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
                onChanged: (value) {
                  fetchSuggestions(value);
                  setState(() {
                    showSuggestions = value.isNotEmpty;
                  });
                },
              ),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          if (isFocused && suggestions.isNotEmpty)
            Flexible(
              child: SizedBox(
                height: context.screenHeight,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: suggestions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      // leading: Image.network(user.photo, width: 30, height: 30,fit: Boxfit.cover),

                      title: Text(
                        suggestions[index].name,
                      ),
                      onTap: () {
                        final UserModel user = suggestions[index];

                        isFocused = false;
                        searchFocusNode.unfocus();
                        addFriends(user.id);
                        // Navigator.of(context)
                        //     .pushNamed(Rotas.chat, arguments: {'user': user});
                      },
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
