// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registrar_empresa_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension RegistrarEmpresaStatusMatch on RegistrarEmpresaStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() success,
      required T Function() failure}) {
    final v = this;
    if (v == RegistrarEmpresaStatus.initial) {
      return initial();
    }

    if (v == RegistrarEmpresaStatus.loading) {
      return loading();
    }

    if (v == RegistrarEmpresaStatus.loaded) {
      return loaded();
    }

    if (v == RegistrarEmpresaStatus.success) {
      return success();
    }

    if (v == RegistrarEmpresaStatus.failure) {
      return failure();
    }

    throw Exception(
        'RegistrarEmpresaStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? success,
      T Function()? failure}) {
    final v = this;
    if (v == RegistrarEmpresaStatus.initial && initial != null) {
      return initial();
    }

    if (v == RegistrarEmpresaStatus.loading && loading != null) {
      return loading();
    }

    if (v == RegistrarEmpresaStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == RegistrarEmpresaStatus.success && success != null) {
      return success();
    }

    if (v == RegistrarEmpresaStatus.failure && failure != null) {
      return failure();
    }

    return any();
  }
}
