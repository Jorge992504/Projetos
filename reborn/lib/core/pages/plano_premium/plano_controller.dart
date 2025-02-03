import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reborn/core/dto/plano_dto.dart';
import 'package:reborn/core/pages/plano_premium/plano_state.dart';
import 'package:reborn/core/repositorio/plano_repository.dart';

class PlanoController extends Cubit<PlanoState> {
  final PlanoRepository _planoRepository;
  PlanoController(this._planoRepository) : super(const PlanoState.initial());

  void load() async {
    try {
      emit(state.copyWith(status: PlanoStatus.loading));
      final paymentTypes = await _planoRepository.getAllPaymentTypes();
      emit(
        state.copyWith(
          paymentTypes: paymentTypes,
        ),
      );
    } catch (e, s) {
      log('Erro ao carregar pagina', error: e, stackTrace: s);
      emit(state.copyWith(
          status: PlanoStatus.error, errorMEssage: 'Erro ao carregar pagina'));
    }
  }

  void saveOrder(
      {required String address,
      required String document,
      required int paymentMethodId}) async {
    emit(state.copyWith(status: PlanoStatus.loading));
    await _planoRepository.saveOrder(
      PlanoDto(
        paymentMethodId: paymentMethodId,
      ),
    );
    emit(state.copyWith(status: PlanoStatus.success));
  }
}
