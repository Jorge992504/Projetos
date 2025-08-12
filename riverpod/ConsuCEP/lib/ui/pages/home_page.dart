import 'package:consucep/models/cep_model.dart';
import 'package:consucep/repository/cep_repository.dart';
import 'package:consucep/ui/widgets/address_widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final repository = CepRepository(client: http.Client());
  final cepController = TextEditingController();
  String? erroMsg;
  CepModel? cepModel;

  @override
  void dispose() {
    cepController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final thema = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta de CEP'),
        leading: Icon(Icons.location_city),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, //estica os componetes
          spacing: 24,
          children: [
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    thema.colorScheme.primary.withValues(alpha: 0.1),
                    thema.colorScheme.secondary.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                spacing: 4, //adiciona espaços entre os elementos
                children: [
                  Icon(
                    Icons.search_rounded,
                    size: 48,
                    color: thema.colorScheme.primary,
                  ),
                  Text(
                    'Busque por qualquer CEP',
                    style: thema.textTheme.titleLarge?.copyWith(
                      color: thema.colorScheme.primary,
                    ),
                  ),
                  Text(
                    'Digite o CEP e descubra o endereço',
                    style: thema.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            TextField(
              controller: cepController,
              keyboardType: TextInputType.number,
              maxLength: 9,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.location_on_rounded),
                labelText: 'CEP',
                hintText: 'Digite o CEP (ex: 00000-000)',
                counterText: '',
              ),
            ),
            AnimatedSwitcher(
              duration: Duration.zero,
              child: ElevatedButton.icon(
                onPressed: buscarCep,
                icon: Icon(Icons.search_rounded),
                label: Text('Buscar CEP'),
              ),
            ),
            Visibility(
              visible: erroMsg != null,
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: thema.colorScheme.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: thema.colorScheme.error.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      color: thema.colorScheme.error,
                      size: 24,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      erroMsg ?? '',
                      style: thema.textTheme.bodyMedium?.copyWith(
                        color: thema.colorScheme.error,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: cepModel != null,
              child: AddressWidgets(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> buscarCep() async {
    setState(() {
      erroMsg = null;
      cepModel = null;
    });
    final cep = cepController.text.trim(); //tira os espaçoes
    if (cep.isEmpty) {
      setState(() {
        erroMsg = 'Digite um cep valido';
      });
    }

    try {
      final addressModel = await repository.consultarCep(cep);
      setState(() {
        erroMsg = null;
        cepModel = addressModel;
      });
    } catch (e) {
      setState(() {
        erroMsg = 'Erro ao buscar endereço';
      });
    }
  }
}
