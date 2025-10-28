// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historico_paciente_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension HistoricoPacienteStatusMatch on HistoricoPacienteStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() success,
      required T Function() failure}) {
    final v = this;
    if (v == HistoricoPacienteStatus.initial) {
      return initial();
    }

    if (v == HistoricoPacienteStatus.loading) {
      return loading();
    }

    if (v == HistoricoPacienteStatus.loaded) {
      return loaded();
    }

    if (v == HistoricoPacienteStatus.success) {
      return success();
    }

    if (v == HistoricoPacienteStatus.failure) {
      return failure();
    }

    throw Exception(
        'HistoricoPacienteStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? success,
      T Function()? failure}) {
    final v = this;
    if (v == HistoricoPacienteStatus.initial && initial != null) {
      return initial();
    }

    if (v == HistoricoPacienteStatus.loading && loading != null) {
      return loading();
    }

    if (v == HistoricoPacienteStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == HistoricoPacienteStatus.success && success != null) {
      return success();
    }

    if (v == HistoricoPacienteStatus.failure && failure != null) {
      return failure();
    }

    return any();
  }
}
