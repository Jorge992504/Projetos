import 'package:delivery/app/dto/order_dto.dart';
import 'package:delivery/app/models/payment_types_model.dart';

abstract class OrderRepository {
  Future<List<PaymentTypesModel>> getAllPaymentTypes();
  Future<void> saveOrder(OrderDto order);
}
