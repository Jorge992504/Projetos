import 'dart:developer';

import 'package:delivery/app/core/rest_client/custom_dio.dart';
import 'package:delivery/app/models/prod_mod.dart';
import 'package:delivery/app/repositories/exception/repository_exception.dart';
import 'package:delivery/app/repositories/products/prod_repo.dart';
import 'package:dio/dio.dart';

class ProdRepoImpl implements ProdRepo {
  final CustomDio dio;
  ProdRepoImpl({required this.dio});

  @override
  Future<List<ProdMod>> findAllProducts() async {
    try {
      final result = await dio.anuath().get('/produtos');
      return result.data
          .map<ProdMod>(
            (p) => ProdMod.fromMap(p),
          )
          .toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar produtos');
    }
  }
}
