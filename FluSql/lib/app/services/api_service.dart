import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flusql/app/models/db_lite.dart';

class ApiService {
  final Dio dio = Dio(BaseOptions(baseUrl: 'http://localhost:9003'));

  Future<bool> sendData(DbLite data) async {
    try {
      await dio.post('/dados', data: {'text': data.text});
      log('Gravado no DbLite');
      return true;
    } catch (e, s) {
      log('Sem conexão', error: e, stackTrace: s);
      return false;
    }
  }
}
