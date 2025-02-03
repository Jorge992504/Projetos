// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:delivery/app/dto/ordem_produto_dto.dart';

class OrderDto {
  List<OrdemProduto> produtos;
  String address;
  String document;
  int paymentMethodId;
  OrderDto({
    required this.produtos,
    required this.address,
    required this.document,
    required this.paymentMethodId,
  });
}
