import 'package:delivery/app/models/prod_mod.dart';

abstract class ProdRepo {
  Future<List<ProdMod>> findAllProducts();
}
