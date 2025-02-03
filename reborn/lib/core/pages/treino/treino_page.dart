import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/core/detalhes_telas/size_tela/size.dart';
import 'package:reborn/core/detalhes_telas/text/text_estilo.dart';
import 'package:reborn/core/pages/treino/treino_controller.dart';
import 'package:reborn/core/pages/treino/treino_state.dart';
import 'package:reborn/core/rotas/rotas.dart';
import 'package:reborn/core/ui/base_state.dart';

class TreinoPage extends StatefulWidget {
  const TreinoPage({
    super.key,
  });

  @override
  State<TreinoPage> createState() => _TreinoPage();
}

class _TreinoPage extends BaseState<TreinoPage, TreinoController> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TreinoController, TreinoState>(
      listener: (context, state) {
        state.status.matchAny(
            any: () => hideLoader(),
            loading: () => showLoader,
            error: () {
              hideLoader();
              showError('Sem conexão');
            },
            success: () {
              hideLoader();
              showSuccess('Treino criado com successo');
              Navigator.of(context).popAndPushNamed(Rotas.home);
            });
      },
      buildWhen: (previous, current) => current.status.matchAny(
        any: () => false,
        initial: () => true,
        loaded: () => true,
      ),
      builder: (context, state) {
        return ListView(
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                  bottom: 10,
                ),
                width: context.screenLargura,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.brown[200],
                ),
                child: SizedBox(
                  width: context.screenMetadeLargura(1),
                  height: context.screenMetadeAltura(0.6),
                  child: Image.asset(
                    'assets/imagens/activovo.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(
                bottom: 40,
              ),
              child: SizedBox(
                width: context.screenMetadeLargura(.95),
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    controller.criarTreino();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  child: Text(
                    "Continuar",
                    style: context.textEstilo.textBold.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
