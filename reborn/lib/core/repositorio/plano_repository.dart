import 'package:reborn/core/dto/plano_dto.dart';
import 'package:reborn/core/modelos/payment_types_model.dart';

abstract class PlanoRepository {
  Future<List<PaymentTypesModel>> getAllPaymentTypes();
  Future<void> saveOrder(PlanoDto payment);
}
