// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension DashboardStatusMatch on DashboardStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() loaded,
      required T Function() success,
      required T Function() refresh,
      required T Function() failure}) {
    final v = this;
    if (v == DashboardStatus.initial) {
      return initial();
    }

    if (v == DashboardStatus.loading) {
      return loading();
    }

    if (v == DashboardStatus.loaded) {
      return loaded();
    }

    if (v == DashboardStatus.success) {
      return success();
    }

    if (v == DashboardStatus.refresh) {
      return refresh();
    }

    if (v == DashboardStatus.failure) {
      return failure();
    }

    throw Exception('DashboardStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? loaded,
      T Function()? success,
      T Function()? refresh,
      T Function()? failure}) {
    final v = this;
    if (v == DashboardStatus.initial && initial != null) {
      return initial();
    }

    if (v == DashboardStatus.loading && loading != null) {
      return loading();
    }

    if (v == DashboardStatus.loaded && loaded != null) {
      return loaded();
    }

    if (v == DashboardStatus.success && success != null) {
      return success();
    }

    if (v == DashboardStatus.refresh && refresh != null) {
      return refresh();
    }

    if (v == DashboardStatus.failure && failure != null) {
      return failure();
    }

    return any();
  }
}
