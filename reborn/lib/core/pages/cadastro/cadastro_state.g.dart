// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cadastro_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension CadastroStatusMatch on CadastroStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() register,
      required T Function() success,
      required T Function() error}) {
    final v = this;
    if (v == CadastroStatus.initial) {
      return initial();
    }

    if (v == CadastroStatus.register) {
      return register();
    }

    if (v == CadastroStatus.success) {
      return success();
    }

    if (v == CadastroStatus.error) {
      return error();
    }

    throw Exception('CadastroStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? register,
      T Function()? success,
      T Function()? error}) {
    final v = this;
    if (v == CadastroStatus.initial && initial != null) {
      return initial();
    }

    if (v == CadastroStatus.register && register != null) {
      return register();
    }

    if (v == CadastroStatus.success && success != null) {
      return success();
    }

    if (v == CadastroStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
