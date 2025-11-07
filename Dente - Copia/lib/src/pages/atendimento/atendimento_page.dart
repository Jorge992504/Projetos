import 'package:dente/core/ui/base/base_state.dart';
import 'package:dente/core/ui/style/custom_colors.dart';
import 'package:dente/core/ui/style/fontes_letras.dart';
import 'package:dente/core/ui/style/size_extension.dart';
import 'package:dente/src/models/response/agendamento_paciente_response.dart';
import 'package:dente/src/pages/atendimento/atendimento_controller.dart';
import 'package:dente/src/pages/atendimento/atendimento_state.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AtendimentoPage extends StatefulWidget {
  const AtendimentoPage({super.key});

  @override
  State<AtendimentoPage> createState() => _AtendimentoPageState();
}

class _AtendimentoPageState
    extends BaseState<AtendimentoPage, AtendimentoController> {
  AgendamentoPacienteResponse agendamentoDetalhe =
      AgendamentoPacienteResponse();

  // Lista de arquivos selecionados
  List<PlatformFile> arquivosSelecionados = [];

  FormData formData = FormData();

  final atendimendoController = TextEditingController();

  bool isFinalizado = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final route = ModalRoute.of(context);
      final arguments =
          (route!.settings.arguments ?? <String, dynamic>{}) as Map;
      setState(() {
        agendamentoDetalhe = arguments['agendamentoDetalhe'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Atendimento')),
      body: BlocConsumer<AtendimentoController, AtendimentoState>(
        listener: (context, state) {
          state.status.matchAny(
            any: hideLoader,
            loading: showLoader,
            loaded: hideLoader,
            failure: () {
              showError(state.errorMessage ?? 'INTERNAL_ERROR');

              hideLoader();
            },
            success: () async {
              // showSuccess("Sucesso ao realizar cadastro.");
              // Navigator.of(context).pop();
              hideLoader();
            },
          );
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Container(
                  width: 1000,
                  height: context.percentHeight(1),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white.withOpacity(0.3),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: context.percentWidth(1),
                        height: 40,
                        margin: EdgeInsets.only(top: 16),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Paciente: ${agendamentoDetalhe.pacienteNome}',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Data/Horario: ${agendamentoDetalhe.datahorario}',
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: context.percentWidth(0.4),
                        height: 40,
                        margin: EdgeInsets.only(top: 16),

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Serviço: ${agendamentoDetalhe.servico}'),
                        ),
                      ),
                      Container(
                        width: context.percentWidth(0.4),
                        height: 40,
                        margin: EdgeInsets.only(top: 16),

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Observação: ${agendamentoDetalhe.observacoes}',
                          ),
                        ),
                      ),
                      Container(
                        width: context.percentWidth(1),
                        height: 60,
                        margin: EdgeInsets.only(top: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            enabled: !isFinalizado,
                            cursorHeight: 15,
                            cursorColor: ColorsConstants.appBarColor,
                            decoration: InputDecoration(
                              fillColor: Colors.white.withOpacity(0.3),
                              labelText:
                                  'Informe os procedimentos realizados no atendimento',
                            ),
                            controller: atendimendoController,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !isFinalizado,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            tooltip: 'Anexar documentos',
                            padding: EdgeInsets.zero, // remove o padding padrão
                            constraints: BoxConstraints(),
                            onPressed: _selecionarArquivos,
                            style: ButtonStyle(
                              overlayColor:
                                  WidgetStateProperty.resolveWith<Color?>((
                                    Set<WidgetState> states,
                                  ) {
                                    if (states.contains(WidgetState.hovered)) {
                                      return ColorsConstants.appBarColor
                                          .withOpacity(0.3); // cor de hover
                                    }
                                    return null; // cor padrão
                                  }),
                            ),
                            icon: Icon(
                              Icons.add_card_outlined,
                              color: ColorsConstants.appBarColor,
                              size: 25,
                            ),
                          ),
                        ),
                      ),

                      if (arquivosSelecionados.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        const Text(
                          'Arquivos anexados:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Expanded(
                          child: ListView.builder(
                            itemCount: arquivosSelecionados.length,
                            itemBuilder: (context, index) {
                              final arquivo = arquivosSelecionados[index];
                              final extensao = arquivo.extension ?? '';
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Icon(
                                  _iconePorExtensao(extensao),
                                  color: ColorsConstants.appBarColor,
                                ),
                                title: Text(
                                  arquivo.name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Visibility(
                                  visible: !isFinalizado,
                                  child: IconButton(
                                    tooltip: 'Remover arquivo',
                                    icon: const Icon(Icons.delete_outline),
                                    color: Colors.red,
                                    onPressed: () {
                                      setState(() {
                                        arquivosSelecionados.removeAt(index);
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                      Visibility(
                        visible: !isFinalizado,
                        child: Container(
                          alignment: Alignment.centerRight,
                          margin: EdgeInsets.only(top: 15),
                          child: ElevatedButton(
                            onPressed: finalizarAgendamento,
                            child: Text(
                              'Finalizar atendimento',
                              style: context.cusotomFontes.textBoldItalic
                                  .copyWith(
                                    color: ColorsConstants.primaryColor,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Função para escolher arquivos
  Future<void> _selecionarArquivos() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true, // permite vários arquivos
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'png', 'jpg', 'jpeg'],
    );

    if (result != null) {
      setState(() {
        arquivosSelecionados.addAll(result.files);
      });
    }
  }

  // Ícone conforme tipo do arquivo
  IconData _iconePorExtensao(String extensao) {
    switch (extensao.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      default:
        return Icons.insert_drive_file;
    }
  }

  Future<void> finalizarAgendamento() async {
    if (arquivosSelecionados.isNotEmpty) {
      for (var arquivo in arquivosSelecionados) {
        formData.files.add(
          MapEntry(
            "files",
            await MultipartFile.fromFile(arquivo.path!, filename: arquivo.name),
          ),
        );
      }
    }

    formData.fields.add(MapEntry("atendimento", atendimendoController.text));
    formData.fields.add(
      MapEntry("pacienteId", agendamentoDetalhe.pacienteId.toString()),
    );
    formData.fields.add(
      MapEntry("agendamentoId", agendamentoDetalhe.agendamentoId!.toString()),
    );

    await controller.terminarAtendimento(formData);
    setState(() {
      isFinalizado = !isFinalizado;
    });
  }
}
