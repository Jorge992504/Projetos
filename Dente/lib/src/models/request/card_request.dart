// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CardRequest {
  num? amount;
  String? cardToken;
  String? descricao;
  int? parcelas;
  String? paymentMethodId;
  String? email;
  String? name;
  String? cpf;
  CardRequest({
    this.amount,
    this.cardToken,
    this.descricao,
    this.parcelas,
    this.paymentMethodId,
    this.email,
    this.name,
    this.cpf,
  });

  CardRequest copyWith({
    num? amount,
    String? cardToken,
    String? descricao,
    int? parcelas,
    String? paymentMethodId,
    String? email,
    String? name,
    String? cpf,
  }) {
    return CardRequest(
      amount: amount ?? this.amount,
      cardToken: cardToken ?? this.cardToken,
      descricao: descricao ?? this.descricao,
      parcelas: parcelas ?? this.parcelas,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      email: email ?? this.email,
      name: name ?? this.name,
      cpf: cpf ?? this.cpf,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amount': amount,
      'cardToken': cardToken,
      'descricao': descricao,
      'parcelas': parcelas,
      'paymentMethodId': paymentMethodId,
      'email': email,
      'name': name,
      'cpf': cpf,
    };
  }

  factory CardRequest.fromMap(Map<String, dynamic> map) {
    return CardRequest(
      amount: map['amount'] ?? 0.0,
      cardToken: map['cardToken'] ?? "",
      descricao: map['descricao'] ?? "",
      parcelas: map['parcelas'] ?? 0,
      paymentMethodId: map['paymentMethodId'] ?? "",
      email: map['email'] ?? "",
      name: map['name'] ?? "",
      cpf: map['cpf'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory CardRequest.fromJson(String source) =>
      CardRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CardRequest(amount: $amount, cardToken: $cardToken, descricao: $descricao, parcelas: $parcelas, paymentMethodId: $paymentMethodId, email: $email, name: $name, cpf: $cpf)';
  }

  @override
  bool operator ==(covariant CardRequest other) {
    if (identical(this, other)) return true;

    return other.amount == amount &&
        other.cardToken == cardToken &&
        other.descricao == descricao &&
        other.parcelas == parcelas &&
        other.paymentMethodId == paymentMethodId &&
        other.email == email &&
        other.name == name &&
        other.cpf == cpf;
  }

  @override
  int get hashCode {
    return amount.hashCode ^
        cardToken.hashCode ^
        descricao.hashCode ^
        parcelas.hashCode ^
        paymentMethodId.hashCode ^
        email.hashCode ^
        name.hashCode ^
        cpf.hashCode;
  }
}
