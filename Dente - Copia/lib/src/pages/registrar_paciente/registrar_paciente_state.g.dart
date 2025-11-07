// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registrar_paciente_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension RegistrarPacienteStatusMatch on RegistrarPacienteStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() success,
      required T Function() failure}) {
    final v = this;
    if (v == RegistrarPacienteStatus.initial) {
      return initial();
    }

    if (v == RegistrarPacienteStatus.loading) {
      return loading();
    }

    if (v == RegistrarPacienteStatus.loaded) {
      return loaded();
    }

    if (v == RegistrarPacienteStatus.success) {
      return success();
    }

    if (v == RegistrarPacienteStatus.failure) {
      return failure();
    }

    throw Exception(
        'RegistrarPacienteStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? success,
      T Function()? failure}) {
    final v = this;
    if (v == RegistrarPacienteStatus.initial && initial != null) {
      return initial();
    }

    if (v == RegistrarPacienteStatus.loading && loading != null) {
      return loading();
    }

    if (v == RegistrarPacienteStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == RegistrarPacienteStatus.success && success != null) {
      return success();
    }

    if (v == RegistrarPacienteStatus.failure && failure != null) {
      return failure();
    }

    return any();
  }
}
