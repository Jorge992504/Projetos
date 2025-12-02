import 'package:bloc/bloc.dart';
import 'package:dente/src/pages/plano/plano_state.dart';
import 'package:dente/src/repository/plano_repository.dart';

class PlanoController extends Cubit<PlanoState> {
  final PlanoRepository _repository;

  PlanoController(this._repository) : super(PlanoState.initial());

  // Future<Map<String, dynamic>> register(EmpresaModel model) async {
  //   try {
  //     emit(state.copyWith(status: PlanoStatus.loading));

  //     final result = await _repository.register(model);

  //     emit(
  //       state.copyWith(
  //         status: PlanoStatus.success,
  //         errorMessage: null,
  //       ),
  //     );
  //     return result;
  //   } on RepositoryException catch (e, s) {
  //     log('$s');
  //     emit(
  //       state.copyWith(
  //         status: PlanoStatus.failure,
  //         errorMessage: e.message,
  //       ),
  //     );
  //     return {};
  //   }
  // }
}
