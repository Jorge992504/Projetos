import 'package:flutter/material.dart';
import 'package:hsmobile/app/core/ui/helpers/format_quantidades.dart';
import 'package:hsmobile/app/pages/ses1184i/models/ses1184i_item_model.dart';
import 'package:hsmobile/app/pages/ses1184i/ses1184i_controller.dart';

class Ses1184iValidator {
  final Ses1184iController ses1184iController;
  Ses1184iValidator({
    required this.ses1184iController,
  });

  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNode = [];

  final text_controller_cdFilial = TextEditingController();
  final text_controller_nmFilial = TextEditingController();
  final text_controller_cdBarra = TextEditingController();
  final text_controller_cdProduto = TextEditingController();
  final text_controller_produto = TextEditingController();
  final text_controller_cdMotivo = TextEditingController();
  final text_controller_nmMotivo = TextEditingController();
  final text_controller_cdFornecedor = TextEditingController();
  final text_controller_nmFornecedor = TextEditingController();
  final text_controller_qtTroca = TextEditingController();
  final text_controller_qtProduto = TextEditingController();
  final text_controller_qtSaldo = TextEditingController();
  final text_controller_obs = TextEditingController();

  final cdFilialFocus = FocusNode();
  final cdBarraFocus = FocusNode();
  final cdMotivoFocus = FocusNode();
  final cdFornecedorFocus = FocusNode();
  final qtProdutoFocus = FocusNode();
  final obsFocus = FocusNode();
  final salvarFocus = FocusNode();

  Ses1085TextController() {
    _controllers.addAll([
      text_controller_cdFilial,
      text_controller_nmFilial,
      text_controller_cdBarra,
      text_controller_cdProduto,
      text_controller_produto,
      text_controller_cdMotivo,
      text_controller_nmMotivo,
      text_controller_cdFornecedor,
      text_controller_nmFornecedor,
      text_controller_qtTroca,
      text_controller_qtProduto,
      text_controller_qtSaldo,
      text_controller_obs,
    ]);
    _focusNode.addAll([
      cdFilialFocus,
      cdBarraFocus,
      cdMotivoFocus,
      cdFornecedorFocus,
      qtProdutoFocus,
      obsFocus,
      salvarFocus
    ]);
  }

  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNode) {
      focusNode.dispose();
    }
  }

  Future<String?> validarFilial() async {
    int filial = int.tryParse(text_controller_cdFilial.text) ?? 0;
    if (filial <= 0 || filial > 9999) {
      cdFilialFocus.requestFocus();
      text_controller_cdFilial.clear();
      text_controller_nmFilial.clear();
      return 'Código invalido';
    } else {
      final result = await ses1184iController.consultarFilial(filial);
      if (result['cdFilial'] == null) {
        cdFilialFocus.requestFocus();
        text_controller_cdFilial.clear();
        text_controller_nmFilial.clear();
        return ' ';
      } else {
        text_controller_nmFilial.text = result['nmFilial'];
        cdBarraFocus.requestFocus();
        return null;
      }
    }
  }

  Future<String?> validarProdutoBarra() async {
    if (text_controller_cdBarra.text.isEmpty) {
      cdBarraFocus.requestFocus();
      return 'Código obrigatorio';
    }
    int cdProduto = int.tryParse(text_controller_cdBarra.text) ?? 0;
    if (cdProduto <= 0) {
      cdBarraFocus.requestFocus();
      return 'Código invalido';
    } else {
      String produto = text_controller_cdBarra.text;
      int filial = int.tryParse(text_controller_cdFilial.text) ?? 0;
      final result = await ses1184iController.consultarProduto(produto, filial);
      if (result['cdProduto'] == null) {
        text_controller_produto.clear();

        cdBarraFocus.requestFocus();
        return ' ';
      } else {
        text_controller_cdBarra.text = result['cdBarra'];
        text_controller_cdProduto.text = result['cdProduto'].toString();
        String produto = result['cdProduto'].toString();
        text_controller_produto.text = '$produto - ${result['nmProduto']}';
        return null;
      }
    }
  }

  Future<String?> validarMotivo() async {
    int motivo = int.tryParse(text_controller_cdMotivo.text) ?? 0;
    if (motivo <= 0 || motivo > 99) {
      cdMotivoFocus.requestFocus();
      text_controller_cdMotivo.clear();
      text_controller_nmMotivo.clear();
      return 'Código invalido';
    } else {
      int filial = int.tryParse(text_controller_cdFilial.text) ?? 0;
      int produto = int.tryParse(text_controller_cdProduto.text) ?? 0;
      final result =
          await ses1184iController.consultarMotivo(motivo, filial, produto);
      if (result['cdMotivo'] == null) {
        cdMotivoFocus.requestFocus();
        text_controller_cdMotivo.clear();
        text_controller_nmMotivo.clear();
        return ' ';
      } else {
        text_controller_nmMotivo.text = result['nmMotivo'];
        text_controller_cdFornecedor.text = result['cdClifor'].toString();
        text_controller_nmFornecedor.text = result['nmClifor'];
        num qtTroca = (result['qtTroca'] ?? 0).toDouble();
        text_controller_qtTroca.text = qtTroca.format("###,###,###,##0.000");
        text_controller_obs.text = '${result['obs1']} ${result['obs2']}';
        cdFornecedorFocus.requestFocus();
        return null;
      }
    }
  }

  Future<String?> validarFornecedor() async {
    int clifor = int.tryParse(text_controller_cdFornecedor.text) ?? 0;
    if (clifor <= 0 || clifor > 9999999) {
      cdFornecedorFocus.requestFocus();
      text_controller_cdFornecedor.clear();
      text_controller_nmFornecedor.clear();
      return 'Código invalido';
    } else {
      int filial = int.tryParse(text_controller_cdFilial.text) ?? 0;
      int produto = int.tryParse(text_controller_cdProduto.text) ?? 0;
      final result =
          await ses1184iController.consultarClifor(clifor, produto, filial);
      if (result['cdClifor'] == null) {
        cdFornecedorFocus.requestFocus();
        text_controller_cdFornecedor.clear();
        text_controller_nmFornecedor.clear();
        return ' ';
      } else {
        text_controller_nmFornecedor.text = result['nmClifor'];
        text_controller_cdFornecedor.text = result['cdClifor'].toString();
        qtProdutoFocus.requestFocus();
        return null;
      }
    }
  }

  Future<String?> validarQuantidade() async {
    String qt = text_controller_qtProduto.text;
    String qtT = text_controller_qtTroca.text;
    int filial = int.tryParse(text_controller_cdFilial.text) ?? 0;
    int produto = int.tryParse(text_controller_cdProduto.text) ?? 0;
    int motivo = int.tryParse(text_controller_cdMotivo.text) ?? 0;
    if (qt.isEmpty) {
      qtProdutoFocus.requestFocus();
      return 'Informe a quantidade';
    }

    double qtProduto =
        double.tryParse(qt.replaceAll('.', '').replaceAll(',', '.')) ?? 0;
    double qtTroca =
        double.tryParse(qtT.replaceAll('.', '').replaceAll(',', '.')) ?? 0;

    final result = await ses1184iController.consultarQuantidade(
        filial, produto, qtProduto, motivo);
    if (result == false) {
      qtProdutoFocus.requestFocus();
      text_controller_qtSaldo.clear();
      return ' ';
    } else {
      double qtSaldo = qtTroca + qtProduto;
      text_controller_qtSaldo.text = qtSaldo.format("###,###,###,##0.000");
      obsFocus.requestFocus();
      return null;
    }
  }

  Future<String?> gravarRegistro() async {
    int filial = int.tryParse(text_controller_cdFilial.text) ?? 0;
    int produto = int.tryParse(text_controller_cdProduto.text) ?? 0;
    int motivo = int.tryParse(text_controller_cdMotivo.text) ?? 0;
    int clifor = int.tryParse(text_controller_cdFornecedor.text) ?? 0;
    String qt = text_controller_qtProduto.text;
    num qtProduto =
        num.tryParse(qt.replaceAll('.', '').replaceAll(',', '.')) ?? 0;
    String obs = text_controller_obs.text;

    if (filial != 0 ||
        produto != 0 ||
        motivo != 0 ||
        clifor != 0 ||
        qtProduto != 0) {
      Ses1184iItemModel item = Ses1184iItemModel(
        filial: filial,
        produto: produto,
        clifor: clifor,
        motivo: motivo,
        obs: obs,
        qtProduto: qtProduto,
      );
      final result = await ses1184iController.gravarRegistro(item);
      if (result == false) {
        return ' ';
      } else {
        return null;
      }
    } else {
      cdFilialFocus.requestFocus();
      return 'Campos vazios';
    }
  }
}
