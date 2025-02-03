import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:saborito/app/core/exceptions/repository_exceptons.dart';
import 'package:saborito/app/core/rest_client/custom_dio.dart';
import 'package:saborito/app/models/produto_model.dart';

import './produtos_repository.dart';

class ProdutosRepositoryImpl implements ProdutosRepository {
  final CustomDio dio;
  ProdutosRepositoryImpl({
    required this.dio,
  });
  @override
  Future<List<ProdutoModel>> listarProdutos() async {
    try {
      final result = await dio.unauth().get('/produtos');
      return result.data
          .map<ProdutoModel>((p) => ProdutoModel.fromMap(p))
          .toList();
    } on DioException catch (e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar produtos');
    }
  }
}
