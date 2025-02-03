import 'package:cep_app/models/endereco_mod.dart';
import 'package:cep_app/repositories/cep_repository.dart';
import 'package:cep_app/repositories/cep_repository_impl.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //relacionando as classes com a homepage
  final CepRepository cepRepository = CepRepositoryImpl();
  EnderecoMod? enderecoMod;

  //chave
  final formKey = GlobalKey<FormState>();

  //controladora
  final cepEC = TextEditingController();
  @override
  void dispose() {
    cepEC.dispose();
    super.dispose();
  }

  //status quando é cep não encontrado
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar CEP'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: cepEC,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'CEP obrigatorio';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  final valid = formKey.currentState?.validate() ?? false;
                  if (valid) {
                    try {
                      setState(() {
                        loading = true;
                      });
                      final endereco = await cepRepository.getCep(cepEC.text);
                      setState(() {
                        loading = false;
                        enderecoMod = endereco;
                      });
                    } catch (e) {
                      print(e);
                      setState(() {
                        loading = false;
                        enderecoMod = null;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Erro ao buscar endereo')));
                    }
                  }
                },
                child: const Text('Buscar'),
              ),
              Visibility(
                visible: loading,
                child: const CircularProgressIndicator(),
              ),
              Visibility(
                visible: enderecoMod != null,
                child: Text(
                    '${enderecoMod?.logradouro} ${enderecoMod?.complemento} ${enderecoMod?.cep}'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
