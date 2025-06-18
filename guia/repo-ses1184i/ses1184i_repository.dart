import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hsmobile/app/core/exceptions/create_exception.dart';
import 'package:hsmobile/app/core/rest_client/custom_dio.dart';
import 'package:hsmobile/app/pages/ses1184i/models/ses1184i_item_model.dart';

class Ses1184iRepository {
  final CustomDio dio;
  Ses1184iRepository({
    required this.dio,
  });

  Future<Map<String, dynamic>> consultarFilial(int filial) async {
    try {
      Response result =
          await dio.auth().get('/consulta/filial', queryParameters: {
        'filial': filial,
      });
      return result.data;
    } catch (e, s) {
      log('Erro ao buscar filial', error: e, stackTrace: s);
      throw CreateException.dioexception(e, 'Erro ao buscar filial');
    }
  }

  Future<Map<String, dynamic>> consultarProduto(
      String produto, int filial) async {
    try {
      Response result =
          await dio.auth().get('/ses1184i/produto', queryParameters: {
        'produto': produto,
        'filial': filial,
      });
      return result.data;
    } catch (e, s) {
      log('Erro ao buscar produto', error: e, stackTrace: s);
      throw CreateException.dioexception(e, 'Erro ao buscar produto');
    }
  }

  Future<Map<String, dynamic>> consultarMotivo(
      int motivo, int filial, int produto) async {
    try {
      Response result =
          await dio.auth().get('/ses1184i/motivo', queryParameters: {
        'motivo': motivo,
        'filial': filial,
        'produto': produto,
      });
      return result.data;
    } catch (e, s) {
      log('Erro ao buscar motivo', error: e, stackTrace: s);
      throw CreateException.dioexception(e, 'Erro ao buscar motivo');
    }
  }

  Future<Map<String, dynamic>> consultarClifor(
      int clifor, int produto, int filial) async {
    try {
      Response result =
          await dio.auth().get('/ses1184i/clifor', queryParameters: {
        'clifor': clifor,
        'filial': filial,
        'produto': produto,
      });
      return result.data;
    } catch (e, s) {
      log('Erro ao buscar fornecedor', error: e, stackTrace: s);
      throw CreateException.dioexception(e, 'Erro ao buscar fornecedor');
    }
  }

  Future<bool> consultarQuantidade(
      int filial, int produto, num qtProduto, int motivo) async {
    try {
      await dio.auth().get('/ses1184i/quantidade', queryParameters: {
        'filial': filial,
        'produto': produto,
        'qtProduto': qtProduto,
        'motivo': motivo,
      });
      return true;
    } catch (e, s) {
      log('Erro ao consultar quantidade', error: e, stackTrace: s);
      throw CreateException.dioexception(e, 'Erro ao consultar quantidade');
    }
  }

  Future<bool> gravaRegistro(Ses1184iItemModel item) async {
    try {
      await dio.auth().post(
            '/ses1184i',
            data: item.toJson(),
          );
      return true;
    } catch (e, s) {
      log('Erro ao gravar registro', error: e, stackTrace: s);
      throw CreateException.dioexception(e, 'Erro ao gravar registro');
    }
  }
}
