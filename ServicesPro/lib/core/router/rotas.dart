mixin Rotas {
  //** Rotas gerais */
  static const String splash = "/";
  static const String login = "/login";
  static const String register = "/register";
  static const String suporte = "/suporte";
  static const String chat = "/chat";
  //** Rotas do cliente */
  static const String clientHome = "/client/home";
  static const String clientHistoricoServico = "/client/hisotrico-servico";
  static const String clientFinalizarServico = "/client/finalizar-servico";
  static const String clientPerfil = "/client/perfil";
  static const String clientCategoriasServicos = "/client/categoria-servicos";
  static const String clientPrestadoresCategorias =
      "/client/prestadores-categorias";
  //** Rotas do prestador */
  static const String employeeHome = "/employee/home";
  static const String employeeDetalhesServico = "/employee/detalhes-servico";
}
